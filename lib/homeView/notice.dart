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
        child: Column(children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.star, size: 20),
              Text("Notice"),
            ], // Row children
          ), // Row
          Image.network(imgList[0]),
        ] // Column children
            ) // Column
        ); // Container
  }
}
