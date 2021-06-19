import 'package:intl/intl.dart';
// import 'package:Army/model/user.dart';

int noticeNumber = 0;

class Notice {
  var date_yMd = DateFormat.yMd().format(new DateTime.now());
  var date_yMMMd = DateFormat.yMMMd().format(new DateTime.now());

  int number;

  String userNickname;

  String title;
  String contents;
  List<String> imageList;

  Notice({this.number??0,this.title, this.contents, this.userNickname, this.imageList}) {
    this.number = noticeNumber;
    noticeNumber++;
  }

  factory Notice.fromJson(Map<String, dynamic> parsedJson) {
    return new Notice(
      number: parsedJson['number'] as int ?? 0, 
      title: parsedJson['title'] ?? '', 
      contents: parsedJson['notice'] ?? '', 
      imageList: parsedJson['imageUrlList'], 
      userNickname: parsedJson['userNickname']);
  }
}
