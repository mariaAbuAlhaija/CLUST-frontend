import 'package:clust/controllers/country_controller.dart';
import 'package:clust/widgets/sized_box.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../controllers/category_contoller.dart';
import '../styles/palate.dart';

class CategorySelector extends StatefulWidget {
  final TextEditingController controller;
  final bool isCategory;

  CategorySelector(
      {Key? key, required this.controller, required this.isCategory})
      : super(key: key);
  @override
  _CategorySelectorState createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  void initState() {
    // TODO: implement initState
    _loadData();
  }

  late Future<List<Category>> _categoriesFuture;
  String? _selectedCategory;
  var _items = <DropdownMenuItem>[];
  _loadData() async {
    if (widget.isCategory) {
      var _categoryService = CategoryController();
      var categories = await _categoryService.getAll();
      categories.forEach((category) {
        setState(() {
          _items.add(DropdownMenuItem(
            child: Text(category.name),
            value: category.id,
          ));
        });
      });
    } else {
      var _countriesService = CountryController();
      var countries = await _countriesService.getAll();
      countries.forEach((country) {
        setState(() {
          _items.add(DropdownMenuItem(
            child: Text(country.countryName),
            value: country.id,
          ));
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String selectedCategoryName = '';

    return DropdownButtonFormField(
      hint: Text(selectedCategoryName),
      items: _items,
      onChanged: ((value) {
        setState(() {
          selectedCategoryName =
              _items.firstWhere((item) => item.value == value).child.toString();
          debugPrint(value.toString());
          _selectedCategory = value.toString();
          widget.controller.text = value.toString();
        });
      }),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        isDense: true,
        hintStyle: TextStyle(color: Colors.black),
        hintText: widget.isCategory ? "Select Category" : "Select Country",
        labelText: widget.isCategory ? "Select Category" : "Select Country",
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.transparent, width: 0),
          gapPadding: 20,
        ),
      ),
    );
  }
}
