import 'package:intl/intl.dart';

import 'package:Army/model/home/gallery_item.dart';
import 'package:Army/services/helper.dart';
// import 'package:Army/model/user.dart';

int noticeNumber = 0;

class Notice {
  var date_yMd = DateFormat.yMd('ko-kr').format(new DateTime.now());
  var date_yMMMd = DateFormat.yMMMd('ko-kr').format(new DateTime.now());

  int number;

  String userNickname;

  String title;
  String contents;
  List<GalleryItem> imageList;

  Notice({this.title, this.contents, this.userNickname, this.imageList}) {
    this.number = noticeNumber;
    noticeNumber++;
  }

  factory Notice.fromJson(Map<String, dynamic> parsedJson) {
    return new Notice(title: parsedJson['title'] ?? '', contents: parsedJson['notice'] ?? '', imageList: parsedGalleryItem(parsedJson['imageUrlList']), userNickname: parsedJson['userNickname']);
  }
}