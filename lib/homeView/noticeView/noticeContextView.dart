import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

import 'notice.dart';

class NoticeContextView extends StatefulWidget {
  int noticeNumber;
  NoticeContextViewState createState() => new NoticeContextViewState(noticeNumber);
}

class NoticeContextViewState extends State<NoticeContextView> {
  int noticeNumber;
  NoticeContextViewState(this.noticeNumber);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.separated(
        children: 
          <Widget> [
          Row(children: <Widget>[
            Text(noticeList[noticeNumber].number),
            Text(noticeList[noticeNumber].title),
            Text(noticeList[noticeNumber].date_yMMMd),
          ]), // Row
          Column(children: <Widget>[
            Text(noticeList[noticeNumber].context),
            Text(noticeList[noticeNumber].person),
          ]), // Column
          ]
      ), // Container
    ); // Scaffold
  }
}
ListView.separated(
                shrinkWrap: true,
                itemCount: noticeList.length+1,
                itemBuilder: (context, index) {
                  if (index == 0) return HeaderTile();
                  return NoticeTile(noticeList[index - 1]);
                },
                separatorBuilder: (context, index) {
                  if (index == 0) return SizedBox.shrink();
                  return const Divider();
                }) // ListView