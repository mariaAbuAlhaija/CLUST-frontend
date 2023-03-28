import 'package:clust/models/user_model.dart';

import 'api_helper.dart';

class UserController {
  String domain = "192.168.1.24:3333";
  String path = "user/";
  Future<List<User>> getAll() async {
    dynamic jsonObject = await ApiHelper(domain: domain).get(path);
    List<User> result = [];
    jsonObject.forEach((json) {
      result.add(User.fromJson(json));
    });
    return result;
  }

  Future<User> getByID(int id) async {
    dynamic jsonObject = await ApiHelper(domain: domain).get("$path$id");
    User result = User.fromJson(jsonObject);
    return result;
  }

  Future<User> create(User user) async {
    dynamic jsonObject =
        await ApiHelper(domain: domain).post(path, user.toJson());
    User result = User.fromJson(jsonObject);
    return result;
  }

  Future<User> update(User user) async {
    dynamic jsonObject =
        await ApiHelper(domain: domain).put(path, user.toJson());
    User result = User.fromJson(jsonObject);
    return result;
  }

  Future<void> distroy(int id) async {
    dynamic jsonObject = await ApiHelper(domain: domain).delete("$path$id");
    // User result = User.fromJson(jsonObject);
    // return result;
  }
}
