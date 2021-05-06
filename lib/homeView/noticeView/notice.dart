import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

import 'package:intl/intl.dart';

import 'noticeContextView.dart';

import 'person.dart';

final List<Notice> noticeList = [
  new Notice(title: "Intro", context: 'Hello World', person: personList[0]),
  new Notice(title: 'App Info', context: 'Welcome K Army', person: personList[1]),
  new Notice(title: 'Outtro', context: 'Good Bye', person: personList[2]),
];

class Notice {
  var date_yMd = DateFormat.yMd().format(new DateTime.now());
  var date_yMMMd = DateFormat.yMMMd().format(new DateTime.now());
  String title;
  String context;
  Person person;

  Notice({this.title, this.context, this.person});
}

class NoticeTile extends StatelessWidget {
  NoticeTile(this._notice);

  final Notice _notice;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(_notice.title),
      subtitle: Text(_notice.date_yMd),
      onTap: () {
        // 공지 제목을 누르면 공지 게시글로 이동
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => noticeContextView()),
        );
      },
    ); // ListTile
  }
}

class HeaderTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: SizedBox(
            width: 27.0,
            height: 13.0,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(6.0),
                child: Container(
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(color: Colors.black12, offset: Offset(3.0, 6.0), blurRadius: 10.0),
                ] // boxShadw
                        ) // BoxDecoration
                    ) // Container
                ) // ClipRRect
            ) // SizedBox
        ); // Return Container
  }
}
