import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

import 'notice.dart';
import '../slideBanner.dart';

class NoticeContextView extends StatefulWidget {
  int noticeContextNumber;
  NoticeContextView(this.noticeContextNumber);
  NoticeContextViewState createState() => new NoticeContextViewState(noticeContextNumber);
}

class NoticeContextViewState extends State<NoticeContextView> {
  int noticeContextNumber;
  NoticeContextViewState(this.noticeContextNumber);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: ListView(children: <Widget>[
          ListTile(
            leading: Icon(Icons.person, size: 40),
            title: Text(noticeList[noticeContextNumber].person.name),
            subtitle: Text(noticeList[noticeContextNumber].date_yMMMd),
          ),
          Text(noticeList[noticeContextNumber].context),
          ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: imgList.length,
              itemBuilder: (BuildContext context, int index) {
                return Image.network(imgList[index]);
              }), // Swiper
        ]));
  }
}
