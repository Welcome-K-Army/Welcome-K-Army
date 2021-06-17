import 'package:intl/intl.dart';
import 'package:Army/model/user.dart';

int contentNumber = 0;

class Content {
  var date_yMd = DateFormat.yMd().format(new DateTime.now());
  var date_yMMMd = DateFormat.yMMMd().format(new DateTime.now());

  int number;

  User writer;

  String title;
  String content;
  List<String> imgList;

  Content({this.title, this.content, this.writer, this.imgList}) {
    this.number = contentNumber;

    contentNumber++;
  }
}
