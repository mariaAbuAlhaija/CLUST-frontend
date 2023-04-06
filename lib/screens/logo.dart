import 'package:flutter/material.dart';
import 'dart:async';
import 'package:clust/styles/palate.dart';

import '../styles/responsive.dart';
import 'landingPage.dart';

import '../styles/responsive.dart';
import 'landingPage.dart';

class Logo extends StatefulWidget {
  Logo({
    Key? key,
  }) : super(key: key);

  @override
  State<Logo> createState() => _LogoState();
  Center logo() {
    return Center(
      child: GestureDetector(
        onTap: () {
          // Check if screen size is greater than or equal to Responsive.desktop
          if (Responsive.isDesktop(context)) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => landingScreen()),
            );
          } else {
            // Do something else for smaller screen sizes
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Screen is too small')),
            );
          }
        },
        child: Container(
          height: 300,
          width: 164,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 120,
                width: 120,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/logo.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  height: 54,
                  width: 150,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/clust.png'),
                      fit: BoxFit.fill,
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

class _LogoState extends State<Logo> {
  Timer? timer;
  @override
  void initState() {
    super.initState();
    timer = Timer(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacementNamed(context, "/start");
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          // Check if screen size is greater than or equal to Responsive.desktop
          if (Responsive.isDesktop(context)) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => landingScreen()),
            );
          } else {
            // Do something else for smaller screen sizes
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Screen is too small')),
            );
          }
        },
        child: Container(
          height: 300,
          width: 164,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 120,
                width: 120,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/logo.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  height: 54,
                  width: 150,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/clust.png'),
                      fit: BoxFit.fill,
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
