import '../models/category_model.dart';

import 'api_helper.dart';

class CategoryController {
  String domain = "jsonplaceholder.typicode.com";
  Future<List<Category>> getAll() async {
    dynamic jsonObject = await ApiHelper(domain: domain).get("posts");
    List<Category> result = [];
    jsonObject.forEach((json) {
      result.add(Category.fromJson(json));
    });
    return result;
  }

  Future<Category> getByID(int id) async {
    dynamic jsonObject = await ApiHelper(domain: domain).get("posts/$id");
    Category result = Category.fromJson(jsonObject);
    return result;
  }

//   Future<Category> createCategory(Category category) async {
//   dynamic jsonObject = await ApiHelper(domain: '').postCategory(category);
//   Category result = Category.fromJson(jsonObject);
//   return result;
// }
}
