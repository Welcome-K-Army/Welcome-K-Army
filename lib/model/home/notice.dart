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

  Notice({this.title, this.contents, this.userNickname, this.imageList}) {
    this.number = noticeNumber;
    noticeNumber++;
  }

  factory Notice.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson['imageUrlList']);
    return new Notice(
      title: parsedJson['title'] ?? '', 
      contents: parsedJson['notice'] ?? '', 
      // imageList: parsedJson['imageUrlList'], 
      userNickname: parsedJson['userNickname']);
  }
}
