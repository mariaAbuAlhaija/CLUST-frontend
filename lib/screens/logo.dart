import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'start.dart';
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
    return Scaffold(
      backgroundColor: const Color(0xff1e1c1c),
      body: Center(
        child: Container(
          height: 263,
          width: 664,
          color: Colors.amber.withOpacity(0.5),
          child: Stack(
            children: [
              Positioned(
                top: MediaQuery.of(context).size.height * 0.0,
                left: MediaQuery.of(context).size.width * 0.25,
                child: Container(
                  height: 209,
                  width: 500,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/logo.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.215,
                left: MediaQuery.of(context).size.width * 0.33,
                child: Container(
                  height: 54,
                  width: 164,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/clust.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // Positioned(
      //   top: MediaQuery.of(context).size.height * 0.339,
      //   left: MediaQuery.of(context).size.width * 0.25,
      //   child: Container(
      //     height: 209,
      //     width: 500,
      //     decoration: const BoxDecoration(
      //       image: DecorationImage(
      //         image: AssetImage('assets/logo.png'),
      //         fit: BoxFit.fill,
      //       ),
      //     ),
      //   ),
      // ),
      // Positioned(
      //   top: MediaQuery.of(context).size.height * 0.564,
      //   left: MediaQuery.of(context).size.width * 0.33,
      //   child: Container(
      //     height: 54,
      //     width: 164,
      //     decoration: const BoxDecoration(
      //       image: DecorationImage(
      //         image: AssetImage('assets/clust.png'),
      //         fit: BoxFit.fill,
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
