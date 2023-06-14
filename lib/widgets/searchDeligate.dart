import 'package:clust/widgets/searchEvents.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clust/providers/event_spot_provider.dart';
import 'package:clust/styles/mobile_styles.dart' as mobile;
import '../providers/event_spot_provider.dart';
import 'package:clust/widgets/events_view.dart' as EventsViewWidget;
import 'package:clust/styles/palate.dart';

class CustomSearchDelegate extends SearchDelegate<String> {
  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        textTheme: theme.textTheme.copyWith(
          headline6: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final _eventSpotProvider = Provider.of<eventSpotProvider>(context);
    _eventSpotProvider.searchResults(query);

    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Theme(
        data: theme(context),
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Consumer<eventSpotProvider>(
                builder: (BuildContext context, eventSpotProvider provider,
                    Widget? child) {
                  return provider.search.isNotEmpty
                      ? EventsViewWidget.EventsView(provider.search)
                      : Center(
                          child: Text("No search results"),
                        );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<String> recentSearches = [
      'Event 1',
      'Event 2',
      'Event 3',
    ]; // Replace with your own recent searches list

    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Text('Search Suggestions'),
      ),
    );
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
