import 'package:clust/signinx.dart';
import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_svg/flutter_svg.dart';

class signupx extends StatelessWidget {
  signupx({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1e1c1c),
      body: Stack(
        children: <Widget>[
          Pinned.fromPins(
            Pin(size: 268.0, middle: 0.5),
            Pin(size: 99.0, end: 91.0),
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
                  Pin(size: 76.0, middle: 0.5156),
                  Pin(size: 25.0, start: 9.0),
                  child: Text(
                    'Sign up',
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
                  alignment: Alignment(-0.215, 1.0),
                  child: SizedBox(
                    width: 161.0,
                    height: 15.0,
                    child: Pinned.fromPins(
                        Pin(size: 200.0, end: 5), Pin(start: 0.0, end: 0.0),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Already a member? ',
                                style: TextStyle(
                                  fontFamily: 'Rockwell',
                                  fontSize: 13,
                                  color: const Color(0xffffffff),
                                ),
                                // textAlign: TextAlign.center,
                                // softWrap: false,
                              ),
                              TextSpan(
                                  text: 'Sign in',
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
                                          builder: (context) => signinx(),
                                        ),
                                      );
                                    }
                                  // textAlign: TextAlign.center,
                                  // softWrap: false,
                                  )
                            ],
                          ),
                        )),
                    //   Text(
                    //     'already a member?',
                    //     style: TextStyle(
                    //       fontFamily: 'Rockwell',
                    //       fontSize: 13,
                    //       color: const Color(0xffffffff),
                    //     ),
                    //     textAlign: TextAlign.center,
                    //     softWrap: false,
                    //   ),
                    // ),
                    // Pinned.fromPins(
                    //   Pin(size: 40.0, end: 0.0),
                    //   Pin(start: 0.0, end: 0.0),
                    //   child: Text(
                    //     'Sign in',
                    //     style: TextStyle(
                    //       fontFamily: 'Rockwell',
                    //       fontSize: 13,
                    //       color: const Color(0xffe1bc6d),
                    //       decoration: TextDecoration.underline,
                    //     ),
                    //     textAlign: TextAlign.center,
                    //     softWrap: false,
                    //   ),
                    // ),
                  ),
                ),
              ],
            ),
          ),
          Pinned.fromPins(
            Pin(start: 46.0, end: 46.0),
            Pin(size: 447.0, middle: 0.3955),
            child: Stack(
              children: <Widget>[
                Pinned.fromPins(
                  Pin(start: 16.0, end: 14.0),
                  Pin(size: 74.0, middle: 0.7426),
                  child: Stack(
                    children: <Widget>[
                      Pinned.fromPins(
                        Pin(start: 0.0, end: 0.0),
                        Pin(size: 43.0, end: 0.0),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xffffffff),
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                    width: 1.0, color: const Color(0xff1e1c1c)),
                              ),
                            ),
                            Pinned.fromPins(
                              Pin(size: 34.0, start: 20.0),
                              Pin(size: 15.0, middle: 0.5),
                              child: Text(
                                'Email',
                                style: TextStyle(
                                  fontFamily: 'Rockwell',
                                  fontSize: 13,
                                  color: const Color(0x801e1c1c),
                                ),
                                softWrap: false,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: SizedBox(
                          width: 39.0,
                          height: 17.0,
                          child: Text(
                            'Email',
                            style: TextStyle(
                              fontFamily: 'Rockwell',
                              fontSize: 15,
                              color: const Color(0xffffffff),
                            ),
                            softWrap: false,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Pinned.fromPins(
                  Pin(start: 16.0, end: 14.0),
                  Pin(size: 74.0, middle: 0.2386),
                  child: Stack(
                    children: <Widget>[
                      Pinned.fromPins(
                        Pin(start: 0.0, end: 0.0),
                        Pin(size: 43.0, end: 0.0),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xffffffff),
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                    width: 1.0, color: const Color(0xff1e1c1c)),
                              ),
                            ),
                            Pinned.fromPins(
                              Pin(size: 87.0, start: 20.0),
                              Pin(size: 15.0, middle: 0.5),
                              child: Text(
                                'MM/DD/YYYY',
                                style: TextStyle(
                                  fontFamily: 'Rockwell',
                                  fontSize: 13,
                                  color: const Color(0x801e1c1c),
                                ),
                                softWrap: false,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: SizedBox(
                          width: 86.0,
                          height: 17.0,
                          child: Text(
                            'Date of birth',
                            style: TextStyle(
                              fontFamily: 'Rockwell',
                              fontSize: 15,
                              color: const Color(0xffffffff),
                            ),
                            softWrap: false,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Pinned.fromPins(
                  Pin(start: 15.0, end: 14.0),
                  Pin(size: 74.0, start: 0.0),
                  child: Stack(
                    children: <Widget>[
                      Pinned.fromPins(
                        Pin(start: 1.0, end: 0.0),
                        Pin(size: 43.0, end: 0.0),
                        child: Stack(
                          children: <Widget>[
                            Pinned.fromPins(
                              Pin(size: 130.0, start: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xffffffff),
                                      borderRadius: BorderRadius.circular(10.0),
                                      border: Border.all(
                                          width: 1.0,
                                          color: const Color(0xff1e1c1c)),
                                    ),
                                  ),
                                  Pinned.fromPins(
                                    Pin(size: 63.0, start: 19.0),
                                    Pin(size: 15.0, middle: 0.5),
                                    child: Text(
                                      'First name',
                                      style: TextStyle(
                                        fontFamily: 'Rockwell',
                                        fontSize: 13,
                                        color: const Color(0x801e1c1c),
                                      ),
                                      softWrap: false,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Pinned.fromPins(
                              Pin(size: 130.0, end: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xffffffff),
                                      borderRadius: BorderRadius.circular(10.0),
                                      border: Border.all(
                                          width: 1.0,
                                          color: const Color(0xff1e1c1c)),
                                    ),
                                  ),
                                  Pinned.fromPins(
                                    Pin(size: 60.0, start: 19.0),
                                    Pin(size: 15.0, middle: 0.5),
                                    child: Text(
                                      'Last name',
                                      style: TextStyle(
                                        fontFamily: 'Rockwell',
                                        fontSize: 13,
                                        color: const Color(0x801e1c1c),
                                      ),
                                      softWrap: false,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: SizedBox(
                          width: 72.0,
                          height: 17.0,
                          child: Text(
                            'First name',
                            style: TextStyle(
                              fontFamily: 'Rockwell',
                              fontSize: 15,
                              color: const Color(0xffffffff),
                            ),
                            softWrap: false,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment(0.39, -1.0),
                        child: SizedBox(
                          width: 69.0,
                          height: 17.0,
                          child: Text(
                            'Last name',
                            style: TextStyle(
                              fontFamily: 'Rockwell',
                              fontSize: 15,
                              color: const Color(0xffffffff),
                            ),
                            softWrap: false,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Pinned.fromPins(
                  Pin(start: 0.0, end: 0.0),
                  Pin(size: 74.0, end: 0.0),
                  child: Stack(
                    children: <Widget>[
                      Pinned.fromPins(
                        Pin(start: 0.0, end: 0.0),
                        Pin(size: 43.0, end: 0.0),
                        child: Stack(
                          children: <Widget>[
                            Pinned.fromPins(
                              Pin(size: 145.0, end: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xffffffff),
                                      borderRadius: BorderRadius.circular(10.0),
                                      border: Border.all(
                                          width: 1.0,
                                          color: const Color(0xff1e1c1c)),
                                    ),
                                  ),
                                  Pinned.fromPins(
                                    Pin(size: 49.0, start: 19.0),
                                    Pin(size: 15.0, middle: 0.5),
                                    child: Text(
                                      'Confirm',
                                      style: TextStyle(
                                        fontFamily: 'Rockwell',
                                        fontSize: 13,
                                        color: const Color(0x801e1c1c),
                                      ),
                                      softWrap: false,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Pinned.fromPins(
                              Pin(size: 145.0, start: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xffffffff),
                                      borderRadius: BorderRadius.circular(10.0),
                                      border: Border.all(
                                          width: 1.0,
                                          color: const Color(0xff1e1c1c)),
                                    ),
                                  ),
                                  Pinned.fromPins(
                                    Pin(size: 57.0, start: 19.0),
                                    Pin(size: 15.0, middle: 0.5),
                                    child: Text(
                                      'Password',
                                      style: TextStyle(
                                        fontFamily: 'Rockwell',
                                        fontSize: 13,
                                        color: const Color(0x801e1c1c),
                                      ),
                                      softWrap: false,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: SizedBox(
                          width: 66.0,
                          height: 17.0,
                          child: Text(
                            'Password',
                            style: TextStyle(
                              fontFamily: 'Rockwell',
                              fontSize: 15,
                              color: const Color(0xffffffff),
                            ),
                            softWrap: false,
                          ),
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(size: 127.0, end: 18.0),
                        Pin(size: 17.0, start: 0.0),
                        child: Text(
                          'Confirm password',
                          style: TextStyle(
                            fontFamily: 'Rockwell',
                            fontSize: 15,
                            color: const Color(0xffffffff),
                          ),
                          softWrap: false,
                        ),
                      ),
                    ],
                  ),
                ),
                Pinned.fromPins(
                  Pin(start: 15.0, end: 15.0),
                  Pin(size: 74.0, middle: 0.4906),
                  child: Stack(
                    children: <Widget>[
                      Pinned.fromPins(
                        Pin(start: 0.0, end: 0.0),
                        Pin(size: 43.0, end: 0.0),
                        child: Stack(
                          children: <Widget>[
                            Pinned.fromPins(
                              Pin(size: 87.0, start: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xffffffff),
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                      width: 1.0,
                                      color: const Color(0xff1e1c1c)),
                                ),
                              ),
                            ),
                            Pinned.fromPins(
                              Pin(size: 44.0, start: 19.0),
                              Pin(size: 15.0, middle: 0.5),
                              child: Text(
                                'Female',
                                style: TextStyle(
                                  fontFamily: 'Rockwell',
                                  fontSize: 13,
                                  color: const Color(0xff1e1c1c),
                                ),
                                softWrap: false,
                              ),
                            ),
                            Pinned.fromPins(
                              Pin(size: 87.0, middle: 0.5028),
                              Pin(start: 0.0, end: 0.0),
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0x7a454242),
                                      borderRadius: BorderRadius.circular(10.0),
                                      border: Border.all(
                                          width: 1.0,
                                          color: const Color(0xff1e1c1c)),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment(-0.333, 0.0),
                                    child: SizedBox(
                                      width: 30.0,
                                      height: 15.0,
                                      child: Text(
                                        'Male',
                                        style: TextStyle(
                                          fontFamily: 'Rockwell',
                                          fontSize: 13,
                                          color: const Color(0xffffffff),
                                        ),
                                        softWrap: false,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Pinned.fromPins(
                              Pin(size: 87.0, end: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0x7a454242),
                                      borderRadius: BorderRadius.circular(10.0),
                                      border: Border.all(
                                          width: 1.0,
                                          color: const Color(0xff1e1c1c)),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment(-0.269, 0.0),
                                    child: SizedBox(
                                      width: 35.0,
                                      height: 15.0,
                                      child: Text(
                                        'Other',
                                        style: TextStyle(
                                          fontFamily: 'Rockwell',
                                          fontSize: 13,
                                          color: const Color(0xffffffff),
                                        ),
                                        softWrap: false,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(size: 53.0, start: 1.0),
                        Pin(size: 17.0, start: 0.0),
                        child: Text(
                          'Gender',
                          style: TextStyle(
                            fontFamily: 'Rockwell',
                            fontSize: 15,
                            color: const Color(0xffffffff),
                          ),
                          softWrap: false,
                        ),
                      ),
                    ],
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

const String _svg_suldka =
    '<svg viewBox="329.0 -24.0 268.0 43.0" ><path transform="translate(329.0, -24.0)" d="M 5.82608699798584 0 L 262.1739196777344 0 C 265.3915710449219 0 268 3.319268226623535 268 7.413793087005615 L 268 35.58620834350586 C 268 39.68073272705078 265.3915710449219 43 262.1739196777344 43 L 5.82608699798584 43 C 2.608428001403809 43 0 39.68073272705078 0 35.58620834350586 L 0 7.413793087005615 C 0 3.319268226623535 2.608428001403809 0 5.82608699798584 0 Z" fill="#454242" fill-opacity="0.48" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
