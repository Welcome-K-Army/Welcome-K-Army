import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

import 'notice.dart';

class NoticeContextView extends StatefulWidget {
  NoticeContextViewState createState() => new NoticeContextViewState();
}

class NoticeContextViewState extends State<NoticeContextView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: ListView(children: [
          Row(children: <Widget>[
            Text(noticeNumber.toString()),
            Text(noticeList[noticeNumber].title),
            Text(noticeList[noticenumber].date_yMMMd),
          ]),
          Column(
            Text(noticeList[noticeNumber].context),
            Text(noticeList[noticeNumber].person.name),
          )
        ])); // Container
  }
}
