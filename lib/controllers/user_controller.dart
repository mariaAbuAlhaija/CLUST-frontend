import 'dart:developer';

import 'package:clust/models/user_model.dart';
import 'package:clust/providers/user_provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'api_helper.dart';

class UserController {
  String path = "user/";
  Future<User> getAll() async {
    dynamic jsonObject = await ApiHelper().get(path);
    print(jsonObject);
    User result = User.fromJson(jsonObject);
    return result;
  }

  Future<User> getByID(int id) async {
    dynamic jsonObject = await ApiHelper().get("$path$id");
    User result = User.fromJson(jsonObject);
    return result;
  }

  Future<User> create(User user) async {
    user.accessRole = AccessRole.attendee;
    dynamic jsonObject = await ApiHelper().post(path, body: user.toJson());
    print(jsonObject);
    User result = User.fromJson(jsonObject);
    signin(user.email, user.password);
    return result;
  }

  Future<User> update(User user) async {
    print(user.accessRole);
    dynamic jsonObject = await ApiHelper().put(path, user.toJson());
    User result = User.fromJson(jsonObject);
    return result;
  }

  Future<void> distroy(int id) async {
    dynamic jsonObject = await ApiHelper().delete("$path$id/");
    // User result = User.fromJson(jsonObject);
    // return result;
  }

  Future<bool> signin(email, password) async {
    try {
      dynamic jsonObject = await ApiHelper().post(
        "${path}login/",
        body: ({'email': email, 'password': password}),
      );
      String type = jsonObject["type"];
      String token = jsonObject["token"];
      var storage = FlutterSecureStorage();
      await storage.write(key: "token", value: "$type $token");
      await UserProvider().fetchUser();
      return true;
    } catch (ex) {
      print(ex);
      rethrow;
    }
  }

  Future<bool> signout() async {
    try {
      dynamic jsonObject = await ApiHelper().postAuth("${path}logout");
      print(jsonObject);
      var storage = FlutterSecureStorage();
      await storage.delete(key: "token");
      return true;
    } catch (ex) {
      print(ex);
      rethrow;
    }
  }
}
