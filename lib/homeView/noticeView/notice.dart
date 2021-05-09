import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

import 'package:intl/intl.dart';

import '../list_with_title_and_day.dart';

import '../slideBanner.dart';
import 'person.dart';

int noticeNumber = 0;

final List<Content> noticeList = [
  new Content(title: "Intro", content: 'Hello World', person: personList[0], imgList: publicImgList),
  new Content(title: 'App Info', content: 'Welcome K Army', person: personList[1], imgList: publicImgList),
  new Content(title: 'Outtro', content: 'Good Bye', person: personList[2], imgList: publicImgList),
];

final List<ListTile> noticeTiles = List.generate(noticeList.length, (index) {
  return ListTileWithTitleAndDay(noticeList[index]);
});

final List<ListContent> noticeContents = List.generate(noticeList.length, (index) {
  return ListContent(noticeList[index]);
});
