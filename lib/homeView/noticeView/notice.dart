import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

import 'package:intl/intl.dart';

import '../list_with_title_and_day.dart';

import 'person.dart';

int noticeNumber = 0;

final List<Notice> noticeList = [
  new Notice(title: "Intro", content: 'Hello World', person: personList[0], imgList: publicImgList),
  new Notice(title: 'App Info', content: 'Welcome K Army', person: personList[1], imgList: publicImgList),
  new Notice(title: 'Outtro', content: 'Good Bye', person: personList[2], imgList: publicImgList),
];

final List<ListTile> noticeTiles = List.generate(noticeList.length, (index) {
  return noticeList[index].tile;
});

/*

final List<ListTileWithTitleAndDay> noticeListTiles = [
  ListTileWithTitleAndDay(
    length: noticeList.length,
  )
];

final List<ListContent> noticeContents = List.generate(noticeList.length, (index) {
  ListContent(
    name: noticeList[index].person.name,
    date_yMMMd: noticeList[index].date_yMMMd,
    title: noticeList[index].title,
    content: noticeList[index].content,
    imgList: noticeList[index].imgList
  );
});
*/

class Notice {
  var date_yMd = DateFormat.yMd().format(new DateTime.now());
  var date_yMMMd = DateFormat.yMMMd().format(new DateTime.now());

  int number;

  String title;
  String content;
  List<String> imgList;
  Person person;

  Scaffold contentView;
  ListTile tile;

  Function press;

  Notice({this.title, this.content, this.person, this.imgList}) {
    this.number = noticeNumber;

    this.contentView = ListContent(name: this.person.name, date_yMMMd: this.date_yMMMd, title: this.title, content: this.content, imgList: this.imgList);

    this.press = () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => this.contentView));
    };

    this.tile = ListTileWithTitleAndDay(title: this.title, date_yMd: this.date_yMd, press: this.press);

    noticeNumber++;
  }
}