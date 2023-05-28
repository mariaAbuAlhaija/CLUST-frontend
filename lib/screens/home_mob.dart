import 'package:clust/styles/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart';

class HomeMob extends StatefulWidget {
  const HomeMob({super.key});

  @override
  State<HomeMob> createState() => _HomeMobState();
}

class _HomeMobState extends State<HomeMob> {
  @override
  Widget build(BuildContext context) {
    return Responsive(
        mobile: mobileWidget(),
        desktop: Container(
          child: Center(
            child: Text("Not Supported"),
          ),
        ));
  }

  Widget mobileWidget() {
    return Scaffold(
      body: Container(
        color: Colors.amber,
      ),
    );
  }
}
