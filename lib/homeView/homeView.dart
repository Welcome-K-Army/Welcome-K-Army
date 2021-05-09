import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

import 'header.dart';
import 'slideBanner.dart';
import './menuView/menuView.dart';
import './noticeView/noticeHomeView.dart';

class HomeView extends StatefulWidget {
  HomeViewState createState() => new HomeViewState();
}

class HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Color(0xFFEDF0F4),
      child: ListView(children: [
        Header(size: size),
        SlideBanner(),
        Padding(
          padding: EdgeInsets.all(10),
          children: <Widget>[
            MenuView(),
            NoticeHomeView(),
          ],
        )
    ] // Column children
            ) // Column
        ); // Return Widget
  } // Wdiget
} // Class
