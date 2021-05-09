// HomeView에 보여지는 Notice

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

import 'noticeView.dart';
import 'notice.dart';

class NoticeHomeView extends StatefulWidget {
  NoticeHomeViewState createState() => new NoticeHomeViewState();
}

class NoticeHomeViewState extends State<NoticeHomeView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFEDF0F4),
      height: 360,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TitleWithMoreBtn(title: "Notice", press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NoticeView()),
              );
            }),
            ListWithTitleAndDay(headerTile: true, title: "Notice", length: noticeList.lenghth, listTiles: noticeTiles),
          ], // Column children
        ), // Column
      ), // Padding
    ); // Container
  }
}