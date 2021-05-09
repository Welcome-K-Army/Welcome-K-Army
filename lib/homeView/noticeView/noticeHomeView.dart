// HomeView에 보여지는 Notice

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

import '../title_with_more_bbtn.dart';
import '../list_with_title_and_day.dart';

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
            ListWithTitleAndDay(headerTile: true, title: "Notice", contents: noticeList),
          ], // Column children
        ), // Column
      ), // Padding
    ); // Container
  }
}
