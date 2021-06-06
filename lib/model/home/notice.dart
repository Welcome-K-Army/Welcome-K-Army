import './content.dart';

import '../../global.dart';

int noticeNumber = 0;

final List<Content> noticeList = [
  new Content(title: "Intro", content: 'Hello World', person: personList[0], imgList: publicImgList),
  new Content(title: 'App Info', content: 'Welcome K Army', person: personList[1], imgList: publicImgList),
  new Content(title: 'Outtro', content: 'Good Bye', person: personList[2], imgList: publicImgList),
];
