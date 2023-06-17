import 'package:clust/controllers/user_controller.dart';
import 'package:clust/models/user_model.dart';
import 'package:clust/screens/profile.dart';
import 'package:clust/screens/qr_scan.dart';
import 'package:clust/screens/searchpage.dart';
import 'package:clust/styles/palate.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'home_mob.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  var _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    HomeMob(),
    SearchPage(),
     ScanQRScreen(),
     ProfilePage(),
   
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            home(),
            orders(),
            scan(),
            profile(),
            
          ],
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: false,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black54,
          iconSize: 40,
          onTap: _onItemTapped,
          elevation: 5),
    );
  }

  BottomNavigationBarItem profile() {
    return const BottomNavigationBarItem(
      icon: Icon(
        Icons.person,
        size: 30,
      ),
      label: 'Profile',
    );
  }

  BottomNavigationBarItem orders() {
    return const BottomNavigationBarItem(
      icon: Icon(
        FontAwesomeIcons.search,
        size: 25,
      ),
      label: 'Search',
    );
  }

  BottomNavigationBarItem home() {
    return const BottomNavigationBarItem(
      icon: Icon(
        Icons.home,
        size: 30,
      ),
      label: 'Home',
    );
  }
  BottomNavigationBarItem scan() {
    return const BottomNavigationBarItem(
      icon: Icon(
        Icons.qr_code_scanner_rounded,
        size: 30,
      ),
      label: 'Qr',
    );
  }
  Padding cart() {
    return Padding(
      padding: EdgeInsets.only(right: 20.w),
      child: Icon(
        FontAwesomeIcons.bagShopping,
        color: Colors.black54,
        size: 21,
      ),
    );
  }
}
