import 'dart:io';

import 'package:clust/screens/categoryList.dart';
import 'package:clust/screens/createevent.dart';
import 'package:clust/screens/home.dart';
import 'package:clust/screens/home_mob.dart';
import 'package:clust/screens/landingPage.dart';
import 'package:clust/screens/logo.dart';
import 'package:clust/screens/navigation.dart';
import 'package:clust/screens/signin.dart';
import 'package:clust/screens/signup.dart';
import 'package:clust/screens/after_register.dart';
import 'package:clust/screens/start.dart';
import 'package:clust/styles/palate.dart';
import 'package:clust/styles/web_styles.dart' as web;
import 'package:clust/styles/mobile_styles.dart' as mobile;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:window_size/window_size.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: kIsWeb ? const Size(1920, 1080) : const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Palate.white,
            accentColor: Palate.wine,
            useMaterial3: true,
            textTheme: kIsWeb
                ? GoogleFonts.kameronTextTheme(
                    TextTheme(
                      displayLarge: web.displayLarge(),
                      displayMedium: web.displayMedium(),
                      headlineLarge: web.headlineLarge(),
                      headlineMedium: web.headlineMedium(),
                      headlineSmall: web.headlineSmall(),
                      bodySmall: web.bodySmall(),
                      labelLarge: web.labelLarge(),
                      labelMedium: web.labelMedium(),
                      labelSmall: web.labelSmall(),
                    ),
                  )
                : GoogleFonts.kameronTextTheme(
                    TextTheme(
                      displayLarge: mobile.displayLarge(),
                      headlineLarge: mobile.headlineLarge(),
                      headlineMedium: mobile.headlineMedium(),
                      headlineSmall: mobile.headlineSmall(),
                      bodySmall: mobile.bodySmall(),
                      labelSmall: mobile.labelSmall(),
                    ),
                  ),
          ),
          // home: kIsWeb ? EventSteps() : Logo(),
          // Scaffold(
          //   backgroundColor: Palate.black,
          //   body: kIsWeb ? landingScreen() : Logo(),
          //   // body: Logo(),
          // ),
          initialRoute: "/",
          onGenerateRoute: (settings) {
            var routes = {
              "/": (context) => Logo(),
              "/start": (context) => start(),
              "/signin": (context) => SignIn(),
              "/landing": (context) => landingScreen(),
              "/signup": (context) => Signup(),
              "/home": (context) => HomeMob(),
              "/afterRegister": (context) => Steps(),
              "/navigator": (context) => Navigation(),
            };
            WidgetBuilder builder = routes[settings.name]!;
            return MaterialPageRoute(builder: (ctx) => builder(ctx));
          },
        );
      },
    );
  }
}
