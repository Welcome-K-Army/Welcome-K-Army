import 'package:Army/constants.dart';
import 'package:flutter/material.dart';

import 'package:Army/widget/home/list_with_title_and_day_widget.dart';

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
        appBar: AppBar(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20),
                )),
            backgroundColor: Color(COLOR_PRIMARY),
            title: Center(child: Text("공지사항")),
            leading: Container(),
            leadingWidth: 0),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: ListWithTitleAndDayWidget(
              headerTile: false,
              title: "Notices",
              notices: noticeProvider.notices,
              infinite: true,
              maxLines: 0),
        ),
      )
    );
  }
}
