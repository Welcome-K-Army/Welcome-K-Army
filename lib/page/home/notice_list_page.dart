import 'package:flutter/material.dart';

import 'package:Army/widget/home/list_with_title_and_day_widget.dart';

import 'package:Army/model/home/notice.dart';
import 'package:Army/model/home/noticeList.dart';

class NoticeListPage extends StatefulWidget {
  NoticeListPageState createState() => new NoticeListPageState();
}

class NoticeListPageState extends State<NoticeListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('k army notice')),
      body: ListWithTitleAndDayWidget(headerTile: false, title: "Notice", contents: noticeList),
    );
  }
}
