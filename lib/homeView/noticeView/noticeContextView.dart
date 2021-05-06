import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

import 'notice.dart';

class NoticeContextView extends StatefulWidget {
  int noticeNumber;
  NoticeContextView(this.noticeNumber);
  NoticeContextViewState createState() => new NoticeContextViewState(noticeNumber);
}

class NoticeContextViewState extends State<NoticeContextView> {
  int noticeNumber;
  NoticeContextViewState(this.noticeNumber);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(children: <Widget>[
        Row(children: <Widget>[
          Text(noticeList[noticeNumber].number.toString),
          Text(noticeList[noticeNumber].title),
          Text(noticeList[noticeNumber].date_yMMMd),
        ]), // Row
        Column(children: <Widget>[
          Text(noticeList[noticeNumber].context),
          Text(noticeList[noticeNumber].person.name),
        ]), // Column
      ]), // Container
    ); // Scaffold
  }
}
