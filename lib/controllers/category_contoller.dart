import '../models/category_model.dart';

import 'api_helper.dart';

class CategoryController {
  String domain = "192.168.1.24:3333";
  String path = "category/";
  Future<List<Category>> getAll() async {
    dynamic jsonObject = await ApiHelper(domain: domain).get(path);
    List<Category> result = [];
    jsonObject.forEach((json) {
      result.add(Category.fromJson(json));
    });
    return result;
  }

  Future<Category> getByID(int id) async {
    dynamic jsonObject = await ApiHelper(domain: domain).get("$path$id");
    Category result = Category.fromJson(jsonObject);
    return result;
  }

  Future<Category> create(Category category) async {
    dynamic jsonObject =
        await ApiHelper(domain: domain).post(path, category.toJson());
    Category result = Category.fromJson(jsonObject);
    return result;
  }

  Future<Category> update(Category category) async {
    dynamic jsonObject =
        await ApiHelper(domain: domain).put(path, category.toJson());
    Category result = Category.fromJson(jsonObject);
    return result;
  }

  Future<void> distroy(int id) async {
    dynamic jsonObject = await ApiHelper(domain: domain).delete("$path$id");
    // Category result = Category.fromJson(jsonObject);
    // return result;
  }
}
