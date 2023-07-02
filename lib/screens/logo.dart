import 'package:clust/screens/start.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:clust/styles/palate.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Logo extends StatefulWidget {
  Logo({
    Key? key,
  }) : super(key: key);

  @override
  State<Logo> createState() => _LogoState();
  Center logo() {
    return Center(
      child: Container(
        height: 185,
        width: 164,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            logoBox(),
            clust(),
          ],
        ),
      ),
    );
  }
}

class _LogoState extends State<Logo> {
  Timer? timer;
  var visible = false;
  @override
  void initState() {
    super.initState();
    timer = Timer(
      const Duration(seconds: 3),
      () async {
        var storage = const FlutterSecureStorage();
        var authirized = await storage.containsKey(key: "token");
        print(authirized);
        authirized
            ? Navigator.pushReplacementNamed(context, "/navigator")
            : setState(() {
                visible = true;
              });
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
      backgroundColor: Palate.black,
      body: widget.logo(),
      bottomNavigationBar: Visibility(
        visible: visible,
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: start(),
        ),
      ),
    );
  }
}

Padding clust() {
  return Padding(
    padding: const EdgeInsets.only(top: 8.0),
    child: Container(
      height: 54,
      width: 150,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/clust.png'),
          fit: BoxFit.fill,
        ),
      ),
    ),
  );
}

Container logoBox() {
  return Container(
    height: 120,
    width: 120,
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/logo.png'),
        fit: BoxFit.fill,
      ),
    ),
  );
}
