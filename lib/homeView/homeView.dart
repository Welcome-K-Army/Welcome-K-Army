import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

import '../constants.dart';
import 'header.dart';
import 'slideBanner.dart';

import './newsView/newsView.dart';
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
        Padding(
          padding: EdgeInsets.all(10),
          child: Padding(
            padding: EdgeInsets.only(bottom: kDefaultPadding),
            child: Column(
              children: <Widget>[
                NewsView(),
                MenuView(),
                NoticeHomeView(),
              ]
            ),
          ),
        ),
    ] // Column children
            ) // Column
        ); // Return Widget
  } // Wdiget
} // Class
