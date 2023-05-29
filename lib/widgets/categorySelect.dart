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
 final  TextEditingController categoryController ;

     CategorySelector({Key?key,required this.categoryController}):super(key: key);
     @override
  _CategorySelectorState createState() => _CategorySelectorState();
}

 
class _CategorySelectorState extends State<CategorySelector> {
    void initState() {
    // TODO: implement initState
        _loadCategories();

  }

  late Future<List<Category>> _categoriesFuture;
  String? _selectedCategory;
  var _categories = <DropdownMenuItem>[];
  _loadCategories() async {
    var _categoryService = CategoryController();
    var categories = await _categoryService.getAll();
    categories.forEach((category) {
      setState(() {
        _categories.add(DropdownMenuItem(
          child: Text(category.name),
          
          value: category.id,
        ));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
        String selectedCategoryName = '';

    return DropdownButtonFormField(
      hint: Text(selectedCategoryName),
      items: _categories,
      onChanged: ((value) {
        setState(() {
          selectedCategoryName = _categories
              .firstWhere((item) => item.value == value)
              .child
              .toString();
          debugPrint(value.toString());
          _selectedCategory = value.toString();
          widget.categoryController.text = value.toString();
        });
      }),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        isDense: true,
        hintStyle: TextStyle(color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.transparent, width: 0),
          gapPadding: 20,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.transparent, width: 0),
          gapPadding: 20,
        ),
      ),
      

    );
    
  }
}
