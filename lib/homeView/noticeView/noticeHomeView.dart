// HomeView에 보여지는 Notice

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

import 'noticeListView.dart';
import 'notice.dart';

class NoticeHomeView extends StatefulWidget {
  NoticeHomeViewState createState() => new NoticeHomeViewState();
}

class NoticeHomeViewState extends State<NoticeHomeView> {
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
                  padding: EdgeInsets.only(right: 5, bottom: 5),
                  child: Text("Notice"),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NoticeListView()),
                        );
                      },
                      icon: Icon(Icons.add, size: 20),
                ),
              ], // Row children
            ), // Row
            ListView.separated(
                shrinkWrap: true,
                itemCount: noticeList.length,
                itemBuilder: (context, index) {
                  if (index == 0) return HeaderTile();
                  return NoticeTile(noticeList[index - 1]);
                },
                separatorBuilder: (context, index) {
                  if (index == 0) return SizedBox.shrink();
                  return const Divider();
                }) // ListView
          ], // Column children
        ), // Column
      ), // Padding
    ); // Container
  }
}
