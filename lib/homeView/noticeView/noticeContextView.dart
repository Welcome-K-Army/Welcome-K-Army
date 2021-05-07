import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

import 'notice.dart';

class NoticeContextView extends StatefulWidget {
  int noticeContextNumber;
  NoticeContextView(this.noticeContextNumber);
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
          ListTile(
            leading: Icon(Icons.person, size: 20),
            title: Text(noticeList[noticeContextNumber].person.name),
            subtitle: Text(noticeList[noticeContextNumber].date_yMMMd),
          ),
          Column(children: <Widget>[
            Text(noticeList[noticeContextNumber].context),
            Text(noticeList[noticeContextNumber].person.name),
          ])
        ]));
  }
}
