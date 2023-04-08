import 'package:flutter/material.dart';
import 'signinx.dart';
import 'package:adobe_xd/page_link.dart';

class start extends StatelessWidget {
  start({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1e1c1c),
      body: Center(
        child: Container(
          width: 136.0,
          height: 49.0,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/signup");
            },
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                )),
                backgroundColor:
                    MaterialStateProperty.all(const Color(0xffe4e4e4))),
            child: const Text(
              "Get Started",
              style: TextStyle(
                fontFamily: 'Rockwell',
                fontSize: 15,
                color: Color(0xff1e1c1c),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
