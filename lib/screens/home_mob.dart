import 'package:clust/styles/palate.dart';
import 'package:clust/styles/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        elevation: 0,
        title: Text(
          "Welcome",
          style: TextStyle(color: Palate.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 150.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: 200.w,
                    child: Card(
                      color: Palate.sand,
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 20.h, left: 20.h),
                            child: Text("Create event"),
                          )),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Text("Hot in Amman"),
          ],
        ),
      ),
    );
  }
}
