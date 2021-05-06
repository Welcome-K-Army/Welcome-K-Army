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
        body: 
          Row(
            children: <Widget> [
              Text(noticeList.number),
              Text(noticeList.title),
              Text(noticeList.date_yMMMd),
            ]
          ),
          Column(
            Text(noticeList.context),
            Text(noticeList.person),
          )
    );
  }
}
