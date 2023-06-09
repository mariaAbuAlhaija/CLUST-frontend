import 'package:clust/controllers/user_controller.dart';
import 'package:clust/models/user_model.dart';

class Globals {
  User? user;
  Globals() {
    fetchUser();
  }
  fetchUser() async {
    user = await UserController().getAll();
  }
}
