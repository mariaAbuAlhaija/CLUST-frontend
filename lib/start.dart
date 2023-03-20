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
      body: Stack(
        children: <Widget>[
          Center(
            child: Container(
              width: 136.0,
              height: 49.0,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, "/signin");
                },
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    )),
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xffe4e4e4))),
                child: Text(
                  "Get Started",
                  style: TextStyle(
                    fontFamily: 'Rockwell',
                    fontSize: 15,
                    color: const Color(0xff1e1c1c),
                  ),
                ),
              ),
            ),
          ),
          // Align(
          //   alignment: Alignment(0.008, 0.089),
          //   child: SizedBox(
          //     width: 136.0,
          //     height: 49.0,
          //     child: PageLink(
          //       links: [
          //         PageLinkInfo(
          //           ease: Curves.easeOut,
          //           duration: 0.3,
          //           pageBuilder: () => signinx(),
          //         ),
          //       ],
          //       child: Stack(
          //         children: <Widget>[
          //           Container(
          //             decoration: BoxDecoration(
          //               color: const Color(0xffe4e4e4),
          //               borderRadius: BorderRadius.circular(12.0),
          //             ),
          //           ),
          //           Align(
          //             alignment: Alignment(0.023, 0.034),
          //             child: SizedBox(
          //               width: 93.0,
          //               height: 20.0,
          //               child: Text(
          //                 'Get Started!',
          //                 style: TextStyle(
          //                   fontFamily: 'Rockwell',
          //                   fontSize: 17,
          //                   color: const Color(0xff1e1c1c),
          //                 ),
          //                 softWrap: false,
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
