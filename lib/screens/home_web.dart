import 'package:clust/controllers/event_controller.dart';
import 'package:clust/models/event_model.dart';
import 'package:clust/screens/logo.dart';
import 'package:clust/screens/start.dart';
import 'package:clust/styles/palate.dart';
import 'package:clust/widgets/horizontal_logo.dart';
import 'package:clust/widgets/notification.dart';
import 'package:clust/widgets/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_images/carousel_images.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool tapped = false;

  @override
  Widget build(BuildContext context) {
    var _pageViewController = PageController(initialPage: 0);
    int index = 0;
    bool arrowBack = false;
    bool arrowFront = false;
    var tabs2 = [
      Tab(text: 'About'),
      Tab(text: 'Spots'),
      Tab(text: 'Create'),
    ];
    List<String> listImages = [
      'assets/images/intro2.png',
      'assets/images/intro6.png',
      'assets/images/intro6.png',
      'assets/images/intro2.png'
    ];
    return DefaultTabController(
      length: tabs2.length,
      child: Scaffold(
          backgroundColor: Palate.black,
          appBar: AppBar(
            backgroundColor: Palate.black,
            leadingWidth: 350,
            leading: leading(context),
            title: TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                labelColor: Palate.white,
                unselectedLabelColor: Palate.white,
                overlayColor:
                    MaterialStateProperty.all(Palate.white.withOpacity(0.5)),
                dividerColor: Colors.transparent,
                indicatorWeight: 1,
                indicatorColor: Colors.transparent,
                onTap: (value) {
                  setState(() {
                    tapped = true;
                  });
                },
                labelStyle: Theme.of(context).textTheme.labelLarge,
                unselectedLabelStyle: Theme.of(context).textTheme.labelMedium,
                tabs: tabs2),
            actions: [
              Padding(
                  padding: const EdgeInsets.only(right: 15, left: 10),
                  child: Notifications()),
              Padding(
                padding: EdgeInsets.only(right: 150.w, left: 15),
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/box.png"),
                ),
              )
            ],
          ),
          body: tapped
              ? TabBarView(
                  children: [Logo(), Logo(), Logo()],
                )
              : Container(
                  padding: EdgeInsets.only(right: 150.w, left: 150.w),
                  child: SingleChildScrollView(
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                                height: 127,
                                width: 127,
                                child: Image.asset(
                                    "assets/images/flame icon.png")),
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: "Hot In",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge),
                              TextSpan(
                                  text: " Amman",
                                  style:
                                      Theme.of(context).textTheme.displayMedium)
                            ]))
                          ],
                        ),
                        SizedBox(
                          width: 807.w,
                          height: 568.h,
                          child: Stack(
                            children: [
                              InkWell(
                                onHover: (value) {
                                  setState(() {
                                    arrowBack = !arrowBack;
                                  });
                                },
                                child: Visibility(
                                  visible: arrowBack,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.5),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      child: InkWell(
                                        onTap: () {
                                          _pageViewController.animateToPage(
                                              index--,
                                              duration:
                                                  Duration(microseconds: 250),
                                              curve: Curves.bounceOut);
                                        },
                                        child: Icon(Icons.arrow_back_ios),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              PageView.builder(
                                  itemCount: 3,
                                  controller: _pageViewController,
                                  onPageChanged: (value) {
                                    setState(() {
                                      index = value;
                                    });
                                  },
                                  itemBuilder: (BuildContext, index) {
                                    return Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      child: Image.asset(
                                        'assets/images/intro${index + 1}.png',
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  }),
                              InkWell(
                                onHover: (value) {
                                  setState(() {
                                    arrowFront = !arrowFront;
                                  });
                                },
                                child: Visibility(
                                  visible: arrowFront,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.5),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      child: InkWell(
                                        onTap: () {
                                          _pageViewController.animateToPage(
                                              index++,
                                              duration:
                                                  Duration(microseconds: 250),
                                              curve: Curves.bounceIn);
                                        },
                                        child: Icon(Icons.arrow_back_ios),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        ImageSlideshow(
                          width: 807.w,
                          height: 568.h,
                          initialPage: 0,
                          indicatorRadius: 0,
                          autoPlayInterval: 3000,
                          isLoop: true,
                          children: [
                            Image.asset(
                              'assets/images/intro2.png',
                              fit: BoxFit.cover,
                            ),
                            Image.asset('assets/images/intro6.png',
                                fit: BoxFit.cover),
                          ],
                        ),

                        // FutureBuilder<List<Event>>(
                        //     future: EventController().getAll(),
                        //     builder: (context, snapShot) {
                        //       if (snapShot.hasError) return error();

                        //       if (!snapShot.hasData)
                        //         return empty();
                        //       else {
                        //         return ImageSlideshow(
                        //           width: 807.w,
                        //           height: 568.h,
                        //           initialPage: 0,
                        //           indicatorRadius: 0,
                        //           autoPlayInterval: 3000,
                        //           isLoop: true,
                        //           children: [
                        //             Image.asset('assets/images/intro2.png'),
                        //             Image.asset('assets/images/intro6.png'),
                        //           ],
                        //         );
                        //       }
                        //     })
                      ],
                    ),
                  ),
                )),
    );
  }

  InkWell leading(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushReplacementNamed(context, '/home');
      },
      child: const HorizontalLogo(),
    );
  }

  Center empty() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  SnackBar error() {
    return const SnackBar(
      content: Text("Error"),
    );
  }
}
