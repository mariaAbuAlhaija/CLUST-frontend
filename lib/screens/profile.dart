import 'package:clust/models/event_model.dart';
import 'package:clust/widgets/image.dart';
import 'package:clust/widgets/items_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clust/models/user_model.dart';
import 'package:clust/providers/user_provider.dart';
import 'package:clust/controllers/event_controller.dart';
import 'package:clust/controllers/user_controller.dart';
import 'package:intl/intl.dart';

import '../widgets/events_view.dart';
import 'display_orgEvents.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Access the user provider to get the user data
    UserProvider userProvider = Provider.of<UserProvider>(context);
    User? user = userProvider.user;

    // Access the event controller to get the events for the organizer
    EventController eventController = EventController();
    UserController userController = UserController();

    DateFormat dateFormat = DateFormat('yyyy/MM/dd');

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipOval(
                    child: Container(
                      width: 75,
                      height: 75,
                      child: ImageView(user),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${user?.firstName} ${user?.lastName}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Text(
                              user?.email ?? '',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(width: 8),
                            Container(
                              width: 1,
                              height: 12,
                              color: Colors.grey.withOpacity(0.7),
                            ),
                            SizedBox(width: 8),
                            Text(
                              '(${user!.accessRole.toString().split('.').last})',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Visibility(
                visible: user?.about != null && user!.about!.isNotEmpty,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15),
                    if (user!.about.isNotEmpty)
                      Container(
                        width: MediaQuery.of(context).size.width * 2 / 3,
                        child: Text(user!.about),
                      ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 16.0),
                child: TextButton.icon(
                  onPressed: () {
                    // Handle edit profile button tap
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    alignment: Alignment.centerLeft,
                  ),
                  icon: Icon(
                    Icons.edit,
                    size: 20,
                    color: Colors.grey.withOpacity(0.7),
                  ),
                  label: Text(
                    'Edit Profile',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: user?.accessRole == AccessRole.organizer,
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 16.0),
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
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      alignment: Alignment.centerLeft,
                    ),
                    icon: Icon(
                      Icons.event,
                      size: 20,
                      color: Colors.grey.withOpacity(0.7),
                    ),
                    label: Text(
                      'Events',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 16.0),
                child: TextButton.icon(
                  onPressed: () async {
                    bool signedOut = await userController.signout(user!.id);
                    if (signedOut) {
                      // Handle successful signout
                    } else {
                      // Handle signout failure
                    }
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    alignment: Alignment.centerLeft,
                  ),
                  icon: Icon(
                    Icons.logout,
                    size: 20,
                    color: Colors.grey.withOpacity(0.7),
                  ),
                  label: Text(
                    'Sign Out',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
