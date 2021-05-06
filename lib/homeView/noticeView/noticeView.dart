// Notice view

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

import 'notice.dart';

class NoticeListView extends StatefulWidget {
  NoticeListViewState createState() => new NoticeListViewState();
}

class NoticeListViewState extends State<NoticeListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        itemCount: noticeList.length,
        itemBuilder: (context, index) {
          if (index == 0) return HeaderTile();
          return NoticeTile(noticeList[index - 1]);
        },
        separatorBuilder: (context, index) {
          if (index == 0) return SizedBox.shrink();
          return const Divider();
        }); // ListView
  }
}
