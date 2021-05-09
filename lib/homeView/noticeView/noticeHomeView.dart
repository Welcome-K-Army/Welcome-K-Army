// HomeView에 보여지는 Notice

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

import 'noticeView.dart';
import 'notice.dart';

import '../title_with_more_bbtn.dart';
import '../list_with_title_and_day.dart';

class NoticeHomeView extends StatefulWidget {
  NoticeHomeViewState createState() => new NoticeHomeViewState();
}

class NoticeHomeViewState extends State<NoticeHomeView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 360,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TitleWithMoreBtn(
                title: "Notice",
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NoticeView()),
                  );
                }),
            ListWithTitleAndDay(title: "Notice", length: noticeList.length, listTiles: noticeTiles),
          ], // Column children
        ), // Column
      ), // Padding
    ); // Container
  }
}
