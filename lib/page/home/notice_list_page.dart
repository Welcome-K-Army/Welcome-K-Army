// Notice view

import 'package:flutter/material.dart';

import '../../widget/home/list_with_title_and_day.dart';

import '../../model/home/notice.dart';

class NoticeListPage extends StatefulWidget {
  NoticeListPageState createState() => new NoticeListPageState();
}

class NoticeListPageState extends State<NoticeListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('k army notice')),
      body: ListWithTitleAndDay(headerTile: false, title: "Notice", contents: noticeList),
    );
  }
}
