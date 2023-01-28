import 'package:clust/_1.dart';
import 'package:clust/main.dart';
import 'package:clust/signupx.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'model/mysql.dart';

class signinx extends StatefulWidget {
  signinx({
    Key? key,
  }) : super(key: key);

  @override
  State<signinx> createState() => _signinxState();
}

class _signinxState extends State<signinx> {
  var db = new Mysql();
  var mail = '';
  final userEmail = TextEditingController();
  final userPass = TextEditingController();
  var isobscure = true;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    isobscure = true;
    db.getConnection().then((conn) {
      String sql = 'SELECT `email` FROM `userlogin` WHERE 1';
      conn.query(sql).then((value) {
        for (var row in value) {
          setState(() {
            mail = row[0];
          });
        }
        debugPrint(mail);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xff1e1c1c),
      body: Stack(
        children: <Widget>[
          // Pinned.fromPins(
          //   Pin(size: 500.0, middle: -1),
          //   Pin(size: 239.0, start: 115.0),
          //   child: Stack(
          //     children: <Widget>[
          //       Container(
          //         decoration: BoxDecoration(
          //           image: DecorationImage(
          //             image: const AssetImage('assets/logo.png'),
          //             fit: BoxFit.fill,
          //           ),
          //         ),
          //         margin: EdgeInsets.fromLTRB(0.0, 0.0, 2.0, 29.0),
          //       ),
          //       Pinned.fromPins(
          //         Pin(size: 164.0, start: 33.0),
          //         Pin(size: 54.0, end: 0.0),
          //         child: Container(
          //           decoration: BoxDecoration(
          //             image: DecorationImage(
          //               image: const AssetImage('assets/clust.png'),
          //               fit: BoxFit.fill,
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // Align(
          //     // alignment: Alignment(0.016, 1),
          //     child: SizedBox(
          //   // width: 268.0,
          //   // height: 500.0,
          Form(
              key: _formKey,
              child: Stack(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Pinned.fromPins(
                    Pin(size: 500.0, middle: -1),
                    Pin(size: 239.0, start: 115.0),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: const AssetImage('assets/logo.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                          margin: EdgeInsets.fromLTRB(0.0, 0.0, 2.0, 29.0),
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
                  Align(
                      alignment: Alignment(0.016, 0.09),
                      child: SizedBox(
                        width: 268.0,
                        height: 150.0,
                        child: Column(children: [
                          TextFormField(
                            controller: userEmail,
                            style: const TextStyle(
                              color: Color(0xff1e1c1c),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              focusColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              filled: true,
                              fillColor: Color(0xffffffff),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              hintText: "Email",
                              hintStyle: const TextStyle(
                                fontFamily: 'Rockwell',
                                fontSize: 13,
                                color: Color(0xff1e1c1c),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          TextFormField(
                            textAlign: TextAlign.left,
                            controller: userPass,
                            style: const TextStyle(
                              color: Color(0xff1e1c1c),
                            ),
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: isobscure,
                            decoration: InputDecoration(
                              focusColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              filled: true,
                              fillColor: Color(0xffffffff),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              suffixIcon: IconButton(
                                iconSize: 20,
                                icon: isobscure
                                    ? Icon(Icons.visibility)
                                    : Icon(Icons.visibility_off),
                                onPressed: (() {
                                  setState(() {
                                    isobscure = !isobscure;
                                  });
                                }),
                              ),
                              hintText: "Password",
                              hintStyle: const TextStyle(
                                fontFamily: 'Rockwell',
                                fontSize: 13,
                                color: Color(0xff1e1c1c),
                              ),
                            ),
                          ),
                        ]),
                      )),
                  Pinned.fromPins(Pin(size: 268.0, middle: 0.5),
                      Pin(size: 99.0, end: 115.0),
                      child: Stack(
                        children: <Widget>[
                          Pinned.fromPins(
                            Pin(start: 0.0, end: 0.0),
                            Pin(size: 43.0, start: 0.0),
                            child: SvgPicture.string(
                              _svg_suldka,
                              allowDrawingOutsideViewBox: true,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Pinned.fromPins(Pin(size: 71.0, middle: 0.5025),
                              Pin(size: 35.0, start: 9.0),
                              child: RichText(
                                  text: TextSpan(
                                      text: 'Sign up',
                                      style: TextStyle(
                                        fontFamily: 'Rockwell',
                                        fontSize: 13,
                                        color: const Color(0xffe1bc6d),
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => st1(),
                                            ),
                                          );
                                        }
                                      // textAlign: TextAlign.center,
                                      // softWrap: false,
                                      ))),
                        ],
                      ))
                ],
              )),
          //         Align(
          //           alignment: Alignment.topLeft,
          //           child: SizedBox(
          //             width: 75.0,
          //             height: 17.0,
          //             child: Text(
          //               'Password',
          //               style: TextStyle(
          //                 fontFamily: 'Rockwell',
          //                 fontSize: 15,
          //                 color: const Color(0xffffffff),
          //               ),
          //               softWrap: false,
          //             ),
          //           ),
          //         ),
          //         // Pinned.fromPins(
          //         //   Pin(size: 15.0, end: 20.0),
          //         //   Pin(size: 12.7, middle: 0.75),
          //         //   child: SvgPicture.string(
          //         //     _svg_kx3v88,
          //         //     allowDrawingOutsideViewBox: true,
          //         //     fit: BoxFit.fill,
          //         //   ),
          //         // ),
          //       ],
          //     ),
          //   ),
          // ),
          // Align(
          //   alignment: Alignment(-0.527, 0.321),
          //   child: SizedBox(
          //     width: 100.0,
          //     height: 13.0,
          //     child: Text.rich(
          //       TextSpan(
          //         style: TextStyle(
          //           fontFamily: 'Rockwell',
          //           fontSize: 17,
          //           color: const Color(0xffffffff),
          //         ),
          //         children: [
          //           TextSpan(
          //             text: 'Forgot password?',
          //             style: TextStyle(
          //               fontSize: 11,
          //               decoration: TextDecoration.underline,
          //             ),
          //           ),
          //         ],
          //       ),
          //       textHeightBehavior:
          //           TextHeightBehavior(applyHeightToFirstAscent: false),
          //       textAlign: TextAlign.center,
          //       softWrap: false,
          //     ),
          //   ),
          // ),
          Pinned.fromPins(
            Pin(size: 268.0, middle: 0.5),
            Pin(size: 99.0, end: 115.0),
            child: Stack(
              children: <Widget>[
                Pinned.fromPins(
                  Pin(start: 0.0, end: 0.0),
                  Pin(size: 43.0, start: 0.0),
                  child: SvgPicture.string(
                    _svg_suldka,
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 71.0, middle: 0.5025),
                  Pin(size: 35.0, start: 9.0),
                  child: Text(
                    'Sign in',
                    style: TextStyle(
                      fontFamily: 'Rockwell',
                      fontSize: 21,
                      color: const Color(0xffffffff),
                      fontWeight: FontWeight.w700,
                    ),
                    softWrap: false,
                  ),
                ),
                Align(
                  alignment: Alignment(0.008, 1.0),
                  child: SizedBox(
                    width: 141.0,
                    height: 15.0,
                    child: Pinned.fromPins(
                        Pin(size: 200.0, end: 5), Pin(start: 0.0, end: 0.0),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Not a member? ',
                                style: TextStyle(
                                  fontFamily: 'Rockwell',
                                  fontSize: 13,
                                  color: Color(0xffffffff),
                                ),
                                // textAlign: TextAlign.center,
                                // softWrap: false,
                              ),
                              TextSpan(
                                  text: 'Sign up',
                                  style: TextStyle(
                                    fontFamily: 'Rockwell',
                                    fontSize: 13,
                                    color: const Color(0xffe1bc6d),
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => signupx(),
                                        ),
                                      );
                                    }
                                  // textAlign: TextAlign.center,
                                  // softWrap: false,
                                  )
                            ],
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

const String _svg_kx3v88 =
    '<svg viewBox="963.0 382.0 19.0 12.7" ><path transform="translate(963.0, 377.5)" d="M 18.88526344299316 10.3517484664917 C 17.09642219543457 6.861481189727783 13.55502796173096 4.5 9.50003719329834 4.5 C 5.445046901702881 4.5 1.902662873268127 6.863129615783691 0.1148122847080231 10.35207748413086 C -0.03821951150894165 10.6547908782959 -0.03821951150894165 11.01222896575928 0.1148123219609261 11.31494235992432 C 1.903652667999268 14.80520915985107 5.445047855377197 17.16669082641602 9.50003719329834 17.16669082641602 C 13.55502796173096 17.16669082641602 17.097412109375 14.80356121063232 18.8852596282959 11.31461429595947 C 19.03829574584961 11.0118989944458 19.03829574584961 10.65446281433105 18.88526344299316 10.3517484664917 Z M 9.50003719329834 15.58335494995117 C 6.876681327819824 15.58335494995117 4.75002908706665 13.45670413970947 4.75002908706665 10.83334636688232 C 4.75002908706665 8.209988594055176 6.876681327819824 6.083337306976318 9.50003719329834 6.083337306976318 C 12.12339496612549 6.083337306976318 14.25004577636719 8.209988594055176 14.25004577636719 10.83334636688232 C 14.25132179260254 13.45723247528076 12.12392234802246 15.58463001251221 9.50003719329834 15.58335494995117 Z M 9.50003719329834 7.666672706604004 C 9.217389106750488 7.6706223487854 8.936564445495605 7.712673187255859 8.665157318115234 7.791689395904541 C 9.127466201782227 8.419950485229492 9.061518669128418 9.291702270507812 8.509957313537598 9.843264579772949 C 7.958395957946777 10.39482688903809 7.086645126342773 10.46077442169189 6.458383083343506 9.998465538024902 C 6.103400707244873 11.30628776550293 6.621984004974365 12.69484043121338 7.747353553771973 13.44979572296143 C 8.872721672058105 14.20475101470947 10.35421276092529 14.15794944763184 11.4296875 13.33346939086914 C 12.50516319274902 12.50898838043213 12.93507099151611 11.09047412872314 12.49824905395508 9.807663917541504 C 12.06142711639404 8.52485466003418 10.85517501831055 7.663483142852783 9.500036239624023 7.66667366027832 Z" fill="#1e1c1c" fill-opacity="0.85" stroke="none" stroke-width="1" stroke-opacity="0.85" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_suldka =
    '<svg viewBox="329.0 -24.0 268.0 43.0" ><path transform="translate(329.0, -24.0)" d="M 5.82608699798584 0 L 262.1739196777344 0 C 265.3915710449219 0 268 3.319268226623535 268 7.413793087005615 L 268 35.58620834350586 C 268 39.68073272705078 265.3915710449219 43 262.1739196777344 43 L 5.82608699798584 43 C 2.608428001403809 43 0 39.68073272705078 0 35.58620834350586 L 0 7.413793087005615 C 0 3.319268226623535 2.608428001403809 0 5.82608699798584 0 Z" fill="#454242" fill-opacity="0.48" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
