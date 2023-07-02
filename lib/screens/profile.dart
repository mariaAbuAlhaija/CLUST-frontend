import 'package:clust/widgets/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:clust/models/user_model.dart';
import 'package:clust/providers/user_provider.dart';
import 'package:clust/controllers/user_controller.dart';
import 'package:intl/intl.dart';
import 'display_org_events.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    User? user = userProvider.user;

    UserController userController = UserController();

    DateFormat dateFormat = DateFormat('yyyy/MM/dd');

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              userInfo(user!),
              about(user, context),
              editProfile(context),
              events(user, context, userProvider),
              signout(userController, context),
            ],
          ),
        ),
      ),
    );
  }

  Container signout(UserController userController, BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16.0),
      child: TextButton.icon(
        onPressed: () async {
          userController.signout().then((value) {
            Navigator.pushReplacementNamed(context, "/signin");
          }).onError((error, stackTrace) {
            print(error);
            print(stackTrace);
          });
        },
        style: TextButton.styleFrom(
          primary: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          alignment: Alignment.centerLeft,
        ),
        icon: const Icon(
          Icons.logout,
          size: 20,
        ),
        label: const Text(
          'Sign Out',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  Visibility events(
      User user, BuildContext context, UserProvider userProvider) {
    return Visibility(
      visible: user.accessRole == AccessRole.organizer,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 16.0),
        child: TextButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OrgEventsScreen(
                  organizerId: userProvider.user?.id,
                ),
              ),
            );
          },
          style: TextButton.styleFrom(
            primary: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            alignment: Alignment.centerLeft,
          ),
          icon: const Icon(
            Icons.event,
            size: 20,
          ),
          label: const Text(
            'Events',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }

  Container editProfile(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16.0),
      child: TextButton.icon(
        onPressed: () {
          Navigator.pushNamed(context, "/edit");
        },
        style: TextButton.styleFrom(
          primary: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          alignment: Alignment.centerLeft,
        ),
        icon: const Icon(
          Icons.edit,
          size: 20,
        ),
        label: const Text(
          'Account info',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  Visibility about(User user, BuildContext context) {
    return Visibility(
      visible: user.about != " ",
      child: Container(
        margin: EdgeInsets.only(left: 10.w, top: 10.h, bottom: 20.h),
        width: MediaQuery.of(context).size.width * 2 / 3,
        child: Text(user.about!),
      ),
    );
  }

  Row userInfo(User? user) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        avatar(user!),
        const SizedBox(width: 16),
        info(user),
      ],
    );
  }

  Column info(User user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${user.firstName} ${user.lastName}',
          style: const TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          ' ${user.accessRole!.name}',
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 25),
      ],
    );
  }

  ClipOval avatar(User? user) {
    return ClipOval(
      child: Container(
        width: 100,
        height: 100,
        child: ImageView(image: user!.image),
      ),
    );
  }
}
