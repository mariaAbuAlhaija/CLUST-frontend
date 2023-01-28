import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import '_1.dart';
import 'dart:async';

class logo extends StatefulWidget {
  logo({
    Key? key,
  }) : super(key: key);

  @override
  State<logo> createState() => _logoState();
}

class _logoState extends State<logo> {
  Timer? timer;
  @override
  void initState() {
    timer = Timer(
      const Duration(seconds: 3),
      () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => st1(),
          ),
        );
      },
    );
  }

  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xff1e1c1c),
        body: Stack(
          children: <Widget>[
            Pinned.fromPins(
              Pin(size: 500.0, end: -190.0),
              Pin(size: 250.0, middle: 0.4747),
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: const AssetImage('assets/logo.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                    margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 40.2),
                  ),
                  Pinned.fromPins(
                    Pin(size: 164.0, start: 33.0),
                    Pin(size: 54.0, end: 0.0),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: const AssetImage('assets/clust.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Pinned.fromPins(
              Pin(size: 210.0, start: -73.0),
              Pin(size: 220.0, start: 25.0),
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                      border: Border.all(
                          width: 0.5, color: const Color(0xff2b2828)),
                    ),
                  ),
                  Align(
                    alignment: Alignment(0.0, 0.009),
                    child: Container(
                      width: 104.0,
                      height: 109.0,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                        border: Border.all(
                            width: 0.5, color: const Color(0xff2b2828)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Pinned.fromPins(
              Pin(size: 158.0, end: -55.0),
              Pin(size: 166.0, end: -87.0),
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                      border: Border.all(
                          width: 0.5, color: const Color(0xff2b2828)),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                      border: Border.all(
                          width: 0.5, color: const Color(0xff2b2828)),
                    ),
                    margin: EdgeInsets.fromLTRB(27.0, 29.0, 27.0, 28.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
