import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

final List<String> noticeList = [
  
];

class NoticeView extends StatefulWidget {
  NoticeViewState createState() => new NoticeViewState();
}

class NoticeViewState extends State<NoticeView> {
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
                  padding: EdgeInsets.only(bottom: 5),
                  child: Text("Notice"),
                ),
              ], // Row children
            ), // Row
            Padding(
              padding: EdgeInsets.all(10),
              child: ListView(
                children: <Widget>[
                    title: Column(
                      children: <Widget>[
                        Text(data),
                        Text(data),
                      ], // ListTile Column children
                    ), // ListTile Column
                  ), // ListTile
                ], // ListView children 
              ), // ListView
            ), // Padding
          ], // Column children
        ), // Column
      ), // Padding
    ); // Container
  }
}
