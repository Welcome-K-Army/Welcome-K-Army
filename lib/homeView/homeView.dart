import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

import '../constants.dart';
import 'header.dart';

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
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Header(size: size),
            Expanded(child: NewsView(),),
            Expanded(child: MenuView(),),
            Expanded(child: NoticeHomeView(),),
          ] // <Widget>[]
        ) // Column
      ) // SingleChildScrollview
    ); // Container
  } // Widget
} // Class
