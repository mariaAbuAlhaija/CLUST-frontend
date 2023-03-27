import 'package:clust/controllers/report_controller.dart';
import 'package:clust/models/category_model.dart';
import 'package:clust/models/report_model.dart';
import 'package:clust/models/category_model.dart';
import 'package:clust/screens/logo.dart';
import 'package:clust/screens/signinx.dart';
import 'package:clust/screens/start.dart';
import 'package:clust/styles/colors.dart';
import 'package:clust/styles/web_styles.dart' as web;
import 'package:clust/styles/mobile_styles.dart' as mobile;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io' show Platform;
import 'controllers/category_contoller.dart';
//C:\Users\Admin\clustt\lib\controllers\category_contoller.dart
import 'models/category_model.dart';

Future<void> main() async {
  CategoryController controller = CategoryController();

///////////////////////////////////////////
//   Category newCategory = Category(
// 0,
//     'New Category',
//     'A new category',
//     2,
//     1,
//     DateTime.parse("2023-03-19"),
//     DateTime.parse( "2023-03-19"),
//     'available',
//     0,
//     100,
//     'Thank you for registering!',
//   );
  Category newcategory = Category(0, "test");
  Category addedCategory = await controller.create(newcategory);

///////////////////////////////////////////////////
//

  List<Category> categorys = await controller.getAll();
  Category categorybyid = await controller.getByID(2);
  categorys.forEach((category) {
    print(category.name);
  });
  print(categorybyid.name);
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
