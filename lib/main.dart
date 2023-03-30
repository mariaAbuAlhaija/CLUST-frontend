import 'package:clust/controllers/image_controller.dart';
import 'package:clust/models/event_model.dart';

import 'package:clust/screens/logo.dart';
import 'package:clust/screens/signinx.dart';
import 'package:clust/screens/start.dart';
import 'package:clust/styles/palate.dart';
import 'package:clust/styles/responsive.dart';
import 'package:clust/styles/web_styles.dart' as web;
import 'package:clust/styles/mobile_styles.dart' as mobile;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;

Future<void> main() async {
  //! delete the comments below
//   EventController controller = EventController();
//   controller.getAll();
// ///////////////////////////////////////////
//   Event newEvent = Event(
//     5,
//     'New Event',
//     'A new image',
//     2,
//     1,
//     DateTime.parse("2023-03-19"),
//     DateTime.parse( "2023-03-19"),
//     'available',
//     0,
//     100,
//     'Thank you for registering!',
//   );
// //  Event newimage = Event(1, "cont_test", 2, true);

// ///////////////////////////////////////////////////
// //

//   List images = await controller.getAll();
//     images.forEach((image) {
//     print(image.id);
//   });
//   print("byid:\n");
//   Event imagebyid = await controller.getByID(2);

//   print(imagebyid.id);
//   print("create:\n");
//    Event addedEvent = await controller.create(newEvent);
//   print("update:\n");

//    addedEvent = await controller.update(newEvent);
//   print("delete:\n");
//   await controller.destroy(4);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var kameronTextTheme = GoogleFonts.kameronTextTheme(
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
    );
    var kameronTextTheme2 = GoogleFonts.kameronTextTheme(
      const TextTheme(
        displayLarge: mobile.displayLarge,
        headlineLarge: mobile.headlineLarge,
        headlineMedium: mobile.headlineMedium,
        headlineSmall: mobile.headlineSmall,
        bodySmall: mobile.bodySmall,
        labelSmall: mobile.labelSmall,
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Palate.white,
        accentColor: Palate.wine,
        useMaterial3: true,
        textTheme: kIsWeb ? kameronTextTheme2 : kameronTextTheme,
      ),
      home: Scaffold(
        backgroundColor: Palate.black,
        body: logo(),
      ),
      onGenerateRoute: (settings) {
        var routes = {
          "/start": (context) => start(),
          "/signin": (context) => signinx(),
        };
        WidgetBuilder builder = routes[settings.name]!;
        return MaterialPageRoute(builder: (ctx) => builder(ctx));
      },
    );
  }
}
