// import 'package:clust/controllers/category_contoller.dart';
// import 'package:flutter/material.dart';
// import '../models/category_model.dart';

// class CategoryDropdown extends StatefulWidget {
//   const CategoryDropdown({super.key});
//   @override
//   _CategoryDropdownState createState() => _CategoryDropdownState();
// }

// class _CategoryDropdownState extends State<CategoryDropdown> {
//   late Future<List<Category>> _categoriesFuture;
//   String? _selectedCategory;

//   @override
//   void initState() {
//     super.initState();
//     _loadCategories() ;
//   }

//   var _categories = <DropdownMenuItem>[];
//   _loadCategories() async {
//     var _categoryService = CategoryController();
//     var categories = await _categoryService.getAll();
//     categories.forEach((category) {
//       setState(() {
//         _categories.add(DropdownMenuItem(child: Text(category.name),value: category.name,));
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButtonFormField(items: _categories, onChanged:((value) {
//       setState(() {
//         _selectedCategory =value;
//       });
//     } ));
//   }
// }

