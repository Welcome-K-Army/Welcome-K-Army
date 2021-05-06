import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

import 'notice.dart';

class NoticeContextView extends StatefulWidget {
  int noticeContextNumber;
  NoticeContextViewState createState() => new NoticeContextViewState(noticeContextNumber);
}

class NoticeContextViewState extends State<NoticeContextView> {
  int noticeContextNumber;
  NoticeContextViewState(this.noticeContextNumber);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(children: <Widget>[
        Row(children: <Widget>[
          Text(noticeContextNumber),
          Text(noticeList[noticeContextNumber].title),
          Text(noticeList[noticeContextNumber].date_yMMMd),
        ]),
        Column(children: <Widget>[
          Text(noticeList[noticeContextNumber]),
          Text(noticeList[noticeContextNumber].person.name),
        ])
    ]));
  }
}
