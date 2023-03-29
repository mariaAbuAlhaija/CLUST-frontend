import 'package:clust/models/user_model.dart';

import 'api_helper.dart';

class UserController {
  String path = "user/";
  Future<List<User>> getAll() async {
    dynamic jsonObject = await ApiHelper().get(path);
    List<User> result = [];
    jsonObject.forEach((json) {
      result.add(User.fromJson(json));
    });
    return result;
  }

  Future<User> getByID(int id) async {
    dynamic jsonObject = await ApiHelper().get("$path$id");
    User result = User.fromJson(jsonObject);
    return result;
  }

  Future<User> create(User user) async {
    dynamic jsonObject = await ApiHelper().post(path, user.toJson());
    User result = User.fromJson(jsonObject);
    return result;
  }

  Future<User> update(User user) async {
    dynamic jsonObject = await ApiHelper().put(path, user.toJson());
    User result = User.fromJson(jsonObject);
    return result;
  }

  Future<void> distroy(int id) async {
    dynamic jsonObject = await ApiHelper().delete("$path$id");
    // User result = User.fromJson(jsonObject);
    // return result;
  }
}
