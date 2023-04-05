import 'package:clust/styles/palate.dart';
import 'package:clust/styles/web_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/staggered.dart';

class landingScreen extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      // Scroll to bottom after the widget has been built
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.kameronTextTheme().apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
      ),
      home: Scaffold(
        backgroundColor: Palate.darkred,
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            children: [
              Container(
                width: 100,
                height: 1024,
                decoration: BoxDecoration(
                  color: Palate.darkred,
                ),
                child: Stack(
                  children: [
                    Stack(
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Align(
                                alignment: AlignmentDirectional(0, -1),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 304, 0, 304),
                                  child: Container(
                                    width: 854,
                                    height: 304,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF221F1F),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Center(
                                          child: Align(
                                              alignment:
                                                  AlignmentDirectional(0, -1),
                                              child: Text('You Are Invited!',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: largeTextSize,
                                                  ))),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 48, 0, 0),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                24, // subtract 24 for left and right padding
                                            child: Center(
                                              child: Text(
                                                'To a new experience of organizing and attending events\n',
                                                textAlign: TextAlign.center,
                                                maxLines: 1,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: mediumTextSize,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment:
                                                AlignmentDirectional(0, 1),
                                            child: SizedBox(
                                              width: 258,
                                              height: 75,
                                              child: FloatingActionButton(
                                                onPressed: () {
                                                  // Add your onPressed action here
                                                },
                                                child: Text(
                                                  'Get started!',
                                                  style: TextStyle(
                                                    fontSize: 23,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                backgroundColor:
                                                    Palate.lightwine,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: AlignmentDirectional(0, -1),
                          child: ListView(
                            controller: _scrollController,
                            padding: EdgeInsets.zero,
                            reverse: true,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    206, 0, 206, 62),
                                child: Image.asset(
                                  'assets/images/landing.gif',
                                  width: 1467,
                                  height: 1024,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                width: 100,
                                height: 832,
                                decoration: BoxDecoration(),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(180, 39, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/images/logo.png',
                                width: 100,
                                height: 45,
                              ),
                              SizedBox(
                                  width:
                                      1), // add some space between the images
                              Image.asset(
                                'assets/images/clust.png',
                                width: 100,
                                height: 78,
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(1, -1),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 51, 222, 0),
                            child: SizedBox(
                              width: 125,
                              height: 57,
                              child: FloatingActionButton(
                                onPressed: () {
                                  print('Button pressed ...');
                                },
                                child: Text(
                                  'Join',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                backgroundColor: Color(0xFF454242),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(1, -1),
                          child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 68, 373, 0),
                              child: TextButton(
                                onPressed: () => print("pressddd"),
                                child: Text(
                                  'Sign In',
                                  style: TextStyle(
                                    color: Palate.white,
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                ),
                              )),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: 100,
                height: 1024,
                decoration: BoxDecoration(
                  color: Color(0xFF221F1F),
                ),
                child: Column(mainAxisSize: MainAxisSize.max, children: [
                  Container(
                    width: 1920,
                    height: 500,
                    decoration: BoxDecoration(
                      color: Color(0xFF1E1C1C),
                    ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: AlignmentDirectional(1, 0),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(52, 50, 252, 79),
                            child: Image(
                              image:
                                  AssetImage('assets/images/environment.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(406, 151, 52, 42),
                          child: Text(
                            'An environment where to\nplan and manage events',
                            style: TextStyle(
                              fontSize: mediumestTextSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(406, 275, 52, 0),
                          child: Text(
                            'Browse events, reserve spots, enjoy your \ntime,\nMake extraordinary memories!',
                            style: TextStyle(
                              fontSize: mediumTextSize,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                      child: Container(
                          width: 1920,
                          height: 511,
                          decoration: BoxDecoration(
                            color: Color(0xFF221F1F),
                          ),
                          child: Stack(children: [
                            Align(
                              alignment: AlignmentDirectional(-1, 0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    406, 45, 0, 44),
                                child: Image(
                                  image:
                                      AssetImage('assets/images/boxsmall.png'),
                                  width: 400,
                                  height: 400,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Column(
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional(1, -1),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            616, 200, 331, 44),
                                        child: Text(
                                          'Create Your own',
                                          style: TextStyle(
                                            fontSize: mediumestTextSize,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment:
                                          AlignmentDirectional.centerStart,
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            945, 0, 0, 44), //  0, 0, 331, 0),
                                        child: Text(
                                          'CLUST is designed to help you \ncustomize your own events',
                                          style: TextStyle(
                                            fontSize: mediumTextSize,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ])))
                ]),
              ),
              Container(
                color: Palate.black,
                height: 1700,
                child: Column(
                  children: [
                    Align(
                      alignment: AlignmentDirectional(-1, 0),
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(407, 120, 0, 64),
                        child: Text(
                          'Gallary',
                          style: TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Container(
                          height: 1000,
                          decoration: BoxDecoration(color: Palate.darkred),
                          child:
                              Container(width: 1000, child: StaggeredPage())),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 170, 0, 0),
                      child: Text(
                        'Dive more?',
                        style: TextStyle(
                          fontSize: 70,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: AlignmentDirectional(0, -1),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 55, 0, 0),
                          child: SizedBox(
                            width: 258,
                            child: FloatingActionButton(
                              onPressed: () {
                                // Add your onPressed action here
                              },
                              child: Text(
                                'Home Page',
                                style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              backgroundColor: Palate.lightwine,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 359,
                color: Palate.darkred,
                child: Stack(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 100, 0),
                        child: Image.asset(
                          'assets/images/biglogo.png',
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(100, 0, 0, 0),
                        child: Image.asset(
                          'assets/images/bigclust.png',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
