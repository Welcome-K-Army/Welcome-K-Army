import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

import 'notice.dart';

final List<String> noticeList = [
  new Notice(title: "Intro", context: 'Hello World'),
  new Notice(title: 'App Info', context: 'Welcome K Army'),
  new Notice(title: 'Outtro', context: 'Good Bye'),
];

class NoticeView extends StatefulWidget {
  NoticeViewState createState() => new NoticeViewState();
}

class NoticeViewState extends State<NoticeView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFEDF0F4),
      height: 280,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 5, bottom: 5),
                  child: Icon(Icons.star, size: 20),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Text("Notice"),
                ),
              ], // Row children
            ), // Row
            ListView.separated(
                itemCount: noticeList.length,
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
