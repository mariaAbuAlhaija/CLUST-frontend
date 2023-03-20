import 'package:clust/logo.dart';
import 'package:clust/signinx.dart';
import 'package:clust/start.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      // theme: ThemeData(primaryColor: Color(0x707070)),
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
