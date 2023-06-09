import 'package:clust/controllers/event_controller.dart';
import 'package:clust/controllers/spot_controller.dart';
import 'package:clust/controllers/user_controller.dart';
import 'package:clust/models/event_model.dart';
import 'package:clust/models/spot_model.dart';
import 'package:clust/models/user_model.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  User? user;
  static final UserProvider _userProvider = UserProvider._internal();

  factory UserProvider() {
    return _userProvider;
  }

  UserProvider._internal() {
    fetchUser();
  }

  fetchUser() async {
    user = await UserController().getAll();
    notifyListeners();
  }

//!!!! it updates user and retrive the past update,, home_mob wont update the accessrole
  updateUser(User user2) async {
    UserController().update(user2);

    print("updating1 ${user!.sid}");
    user = user2;
    print("updating ${user2.sid}");
    print("updating1 ${user!.sid}");
    // fetchUser();
    notifyListeners();
  }
}
