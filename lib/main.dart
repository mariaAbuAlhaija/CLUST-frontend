import 'package:clust/controllers/event_controller.dart';
import 'package:clust/controllers/report_controller.dart';
import 'package:clust/models/event_model.dart';
import 'package:clust/models/report_model.dart';
import 'package:clust/models/event_model.dart';
import 'package:clust/screens/logo.dart';
import 'package:clust/screens/signinx.dart';
import 'package:clust/screens/start.dart';
import 'package:clust/styles/colors.dart';
import 'package:clust/styles/web_styles.dart' as web;
import 'package:clust/styles/mobile_styles.dart' as mobile;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io' show Platform;
//C:\Users\Admin\clustt\lib\controllers\event_contoller.dart
import 'models/event_model.dart';

Future<void> main() async {
  EventController controller = EventController();

///////////////////////////////////////////
  Event newEvent = Event(
2,
    'New Event',
    'A new event',
    2,
    1,
    DateTime.parse("2023-03-19"),
    DateTime.parse( "2023-03-19"),
    'available',
    0,
    100,
    'Thank you for registering!',
  );
  //Event newevent = Event(5, "update");

///////////////////////////////////////////////////
//

  List<Event> events = await controller.getAll();
  Event eventbyid = await controller.getByID(2);
  events.forEach((event) {
    print(event.name);
  });
  print(eventbyid.name);
 // Event addedEvent = await controller.create(newEvent);
 Event addedEvent = await controller.update(newEvent);

await controller.destroy(5);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Constants.white,
          accentColor: Constants.wine,
          useMaterial3: true,
          textTheme: Platform.isWindows
              ? GoogleFonts.kameronTextTheme(
                  const TextTheme(
                    displayLarge: web.displayLarge,
                    displayMedium: web.displayMedium,
                    headlineLarge: web.headlineLarge,
                    headlineMedium: web.headlineMedium,
                    headlineSmall: web.headlineSmall,
                    bodyLarge: web.bodyLarge,
                    bodyMedium: web.bodyMedium,
                    bodySmall: web.bodySmall,
                    labelLarge: web.labelLarge,
                    labelMedium: web.labelMedium,
                    labelSmall: web.labelSmall,
                  ),
                )
              : GoogleFonts.kameronTextTheme(
                  const TextTheme(
                    displayLarge: mobile.displayLarge,
                    headlineLarge: mobile.headlineLarge,
                    headlineMedium: mobile.headlineMedium,
                    headlineSmall: mobile.headlineSmall,
                    bodySmall: mobile.bodySmall,
                    labelSmall: mobile.labelSmall,
                  ),
                )),
      home: Scaffold(
        body: Center(
          child: logo(),
        ),
      ),
      routes: {
        "/start": (context) => start(),
        "/signin": (context) => signinx(),
      },
    );
  }
}
