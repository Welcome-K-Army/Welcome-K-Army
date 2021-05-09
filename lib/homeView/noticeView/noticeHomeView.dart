// HomeView에 보여지는 Notice

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

import 'noticeView.dart';
import 'notice.dart';

import '../title_with_more_bbtn.dart';

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
            TitleWithMoreBtn(title: "Notice", onpress() {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NoticeView()),
              )
            })
            ListView.separated(
                shrinkWrap: true,
                itemCount: noticeList.length+1,
                itemBuilder: (context, index) {
                  if (index == 0) return HeaderTile();
                  return NoticeTile(noticeList[index - 1]);
                },
                separatorBuilder: (context, index) {
                  if (index == 0) return SizedBox.shrink();
                  return const Divider();
                }) // ListView
          ], // Column children
        ), // Column
      ), // Padding
    ); // Container
  }
}
