import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clust/providers/event_spot_provider.dart';
import 'package:clust/widgets/events_view.dart' as events_view_widget;
import 'package:clust/styles/palate.dart';
import 'package:clust/styles/mobile_styles.dart' as mobile;
import '../models/category_model.dart';

import '../controllers/category_contoller.dart';
import '../widgets/searchDeligate.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late Future<List<Category>> _categoriesFuture;
  List<int> selectedCategoryIds = [];

  @override
  void initState() {
    super.initState();
    _categoriesFuture = _loadCategories();
  }

  Future<List<Category>> _loadCategories() async {
    var categoryController = CategoryController();
    return categoryController.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Column(
        children: [
          const SizedBox(height: 20),
          FutureBuilder<List<Category>>(
            future: _categoriesFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final categories = snapshot.data!;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Wrap(
                    spacing: 8,
                    children: getChoiceChips(categories),
                  ),
                );
              } else if (snapshot.hasError) {
                return const Text('Error loading categories');
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
          const SizedBox(height: 20),
          Expanded(
              child: Theme(
            data: theme(context),
            child: Container(
              child: SingleChildScrollView(
                  child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Consumer<eventSpotProvider>(
                  builder: (context, provider, _) {
                    final events =
                        provider.getEventsByCategoryIds(selectedCategoryIds);
                    return events_view_widget.EventsView(
                        provider.filteredEvents);
                  },
                ),
              )),
            ),
          )),
        ],
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      title: const Text('Search'),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            showSearch(
              context: context,
              delegate: CustomSearchDelegate(),
            );
          },
        ),
      ],
    );
  }

  List<Widget> getChoiceChips(List<Category> categories) {
    return categories.map((category) {
      return ChoiceChip(
        label: Text(
          category.name,
          style: const TextStyle(fontSize: 10),
        ),
        labelPadding: const EdgeInsets.symmetric(horizontal: 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        selected: selectedCategoryIds.contains(category.id),
        selectedColor: Palate.sand.withOpacity(0.7),
        onSelected: (isSelected) {
          setState(() {
            if (isSelected) {
              selectedCategoryIds.add(category.id);
            } else {
              selectedCategoryIds.remove(category.id);
            }
          });
        },
        visualDensity: const VisualDensity(horizontal: -3, vertical: -3),
        backgroundColor: Colors.grey.withOpacity(0.1),
      );
    }).toList();
  }

  ThemeData theme(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      textTheme: Theme.of(context).textTheme.copyWith(
            displayLarge: mobile.displayLarge(color: Colors.amber),
            headlineLarge: mobile.headlineLarge(color: Palate.black),
            headlineMedium: mobile.headlineMedium(color: Palate.black),
            headlineSmall: mobile.headlineSmall(color: Palate.black),
            bodySmall: mobile.bodySmall(color: Palate.black),
            labelSmall: mobile.labelSmall(color: Palate.black),
          ),
    );
  }
}
