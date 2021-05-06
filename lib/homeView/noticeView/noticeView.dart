// Notice view

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

import 'notice.dart';

class NoticeView extends StatefulWidget {
  NoticeViewState createState() => new NoticeViewState();
}

class NoticeViewState extends State<NoticeView> {
  @override
  Widget build(BuildContext context) {
    return MateriallApp(
        home: Scaffold(
          appBar: AppBar(title: Text('k army notice')),
        ),
        body: ListView.separated(
            shrinkWrap: true,
            itemCount: noticeList.length,
            itemBuilder: (context, index) {
              if (index == 0) return HeaderTile();
              return NoticeTile(noticeList[index - 1]);
            },
            separatorBuilder: (context, index) {
              if (index == 0) return SizedBox.shrink();
              return const Divider();
            }) // ListView
        );
  }
}
