import 'package:clust/logo.dart';
import 'package:clust/_1.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData(primaryColor: Color(0x707070)),
      home: Scaffold(
        body: Center(
          child: logo(),
        ),
      ),
    );
  }
}
