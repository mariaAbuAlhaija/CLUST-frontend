import '../models/category_model.dart';

import 'api_helper.dart';

class CategoryController {
  Future<List<Category>> getAll() async {
    dynamic jsonObject = await ApiHelper(domain: '').getCategorys();
    List<Category> result = [];
    jsonObject.forEach((json) {
      result.add(Category.fromJson(json));
    });
    return result;
  }

  Future<Category> getByID(int id) async {
    dynamic jsonObject = await ApiHelper(domain: '').getCategory(id);
    Category result = Category.fromJson(jsonObject);
    return result;
  }

//   Future<Category> createCategory(Category category) async {
//   dynamic jsonObject = await ApiHelper(domain: '').postCategory(category);
//   Category result = Category.fromJson(jsonObject);
//   return result;
// }

}
