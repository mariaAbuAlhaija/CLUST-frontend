import 'package:clust/screens/logo.dart';
import 'package:clust/screens/start.dart';
import 'package:clust/styles/palate.dart';
import 'package:clust/widgets/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: Palate.black,
        appBar: AppBar(
          backgroundColor: Palate.black,
          leadingWidth: 350,
          leading: InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/start');
            },
            child: Padding(
              padding: EdgeInsets.only(left: 150.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  logoBox(),
                  Sized_Box().sizedBoxW(context, 15.w),
                  clust(),
                ],
              ),
            ),
          ),
          title: TabBar(tabs: [
            Tab(text: 'About'),
            Tab(text: 'Spots'),
            Tab(text: 'Create'),
          ]),
        ),
        body: TabBarView(
          children: [Logo(), Logo(), Logo(), Logo()],
        ),
      ),
    );
  }

  Container clust() {
    return Container(
      width: 130,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/clust.png'),
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }

  Container logoBox() {
    return Container(
      height: 50,
      width: 50,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/logo.png'),
        ),
      ),
    );
  }
}
