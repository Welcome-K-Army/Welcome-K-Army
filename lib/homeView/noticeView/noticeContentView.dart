import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

import 'notice.dart';
import '../slideBanner.dart';

class NoticeContentView extends StatefulWidget {
  int noticeContentNumber;
  NoticeContentView(this.noticeContentNumber);
  NoticeContentViewState createState() => new NoticeContentViewState(noticeContentNumber);
}

class NoticeContentViewState extends State<NoticeContentView> {
  int noticeContentNumber;
  NoticeContentViewState(this.noticeContentNumber);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: ListView(children: <Widget>[
          ListTile(
            leading: Icon(Icons.person, size: 40),
            title: Text(noticeList[noticeContentNumber].person.name),
            subtitle: Text(noticeList[noticeContentNumber].date_yMMMd),
          ),
          Text(noticeList[noticeContentNumber].content),
          Container(
            height: 60,
            child: ListView.builder(
                // 높이 설정 안 됌 -> 수정하기
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: imgList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 50,
                    child: Image.asset(imgList[index]),
                  ); // Container
                }), // ListView
          )
        ]));
  }
}
