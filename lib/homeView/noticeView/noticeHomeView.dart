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
    return Card(
      color: Color(0xFFEDF0F4),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      elevation: 4,
      //height: 360,
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
