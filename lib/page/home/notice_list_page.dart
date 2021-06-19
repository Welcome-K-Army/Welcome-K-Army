import 'package:flutter/material.dart';

import 'package:Army/widget/home/list_with_title_and_day_widget.dart';

import 'package:Army/model/home/notice.dart';
import 'package:Army/provider/noticeProvider.dart';
import 'package:provider/provider.dart';

class NoticeListPage extends StatefulWidget {
  NoticeListPageState createState() => new NoticeListPageState();
}

class NoticeListPageState extends State<NoticeListPage> {
  @override
  Widget build(BuildContext context) {
    final noticeProvider = Provider.of<NoticeProvider>(context);
    noticeProvider.readNotice();
    return Scaffold(
      appBar: AppBar(title: Text('k army notice')),
      body: ListWithTitleAndDayWidget(headerTile: false, title: "Notice", notices: noticeProvider.notices),
    );
  }
}
