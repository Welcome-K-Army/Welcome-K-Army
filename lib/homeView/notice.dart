import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

final List<String> imgList = [
  'https://reasley.com/wp-content/uploads/2020/04/one.jpg',
];

class Notice extends StatefulWidget {
  NoticeState createState() => new NoticeState();
}

class NoticeState extends State<Notice> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFEDF0F4),
      height: 280,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 5, bottom: 5),
                  child: Icon(Icons.star, size: 20),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5, bottom: 5),
                  child: Text("Notice"),
                ),
              ], // Row children
            ), // Row
            Image.network(imgList[0]),
          ], // Column children
        ), // Column
      ), // Padding
    ); // Container
  }
}
