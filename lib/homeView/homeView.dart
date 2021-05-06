import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

import 'slideBanner.dart';
import './noticeView/noticeHomeView.dart';

class HomeView extends StatefulWidget {
  HomeViewState createState() => new HomeViewState();
}

class HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(children: [
      SlideBanner(),
      NoticeHomeView(),
    ] // Column children
            ) // Column
        ); // Return Widget
  } // Wdiget
} // Class
