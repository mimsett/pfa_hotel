import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:hotel_pfa/pages/booking_page.dart';
import 'package:hotel_pfa/pages/home_page.dart';
import 'package:hotel_pfa/pages/information_page.dart';
import 'package:hotel_pfa/pages/searcher_page.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';

import '../pallete.dart';
import 'old_search.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List pages=[
    HomePage(),
    SearchPage(),
    OldSearchPage(),
    InfoPage(),
  ];
  int currentIndex=0;
  void onTap(int index){
    setState(() {
      currentIndex =index;
    });
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(

      body: pages[currentIndex],
      backgroundColor: Colors.white,


      bottomNavigationBar:
        Container(
          margin: const EdgeInsets.all(6.0),
          padding: const EdgeInsets.all(0),

          decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 1),
          borderRadius:BorderRadius.circular(13.4) ,
    ),
     child: FloatingNavbar(
        backgroundColor: OGrey,

        //width: 450,
       margin: const EdgeInsets.all(0),
        borderRadius: 14,
        onTap: onTap,
          currentIndex: currentIndex,
          selectedItemColor: Colors.black54,
          unselectedItemColor: Colors.black54,
          selectedBackgroundColor: LBlue,
          elevation: 0,
          items:  [
            FloatingNavbarItem(icon: Icons.home, title: 'Home'),
            FloatingNavbarItem(icon: Icons.search,title:'Search'),
            FloatingNavbarItem(icon: Icons.bookmark_border,title:'booking'),
            FloatingNavbarItem(icon: Icons.person_outline_outlined ,title:'myInfo'),

          ],
        ),

      )
    );

  }
}

