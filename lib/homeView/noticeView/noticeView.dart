// Notice view

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

import '../list_with_title_and_day.dart';

import 'notice.dart';

class NoticeView extends StatefulWidget {
  NoticeViewState createState() => new NoticeViewState();
}

class NoticeViewState extends State<NoticeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('k army notice')),
        body: ListWithTitleAndDay(headerTile: false, title: "Notice", length: noticeList.lenghth, listTiles: noticeTiles),
    );
  }
}