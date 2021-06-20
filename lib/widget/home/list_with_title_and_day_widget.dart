import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

import 'package:Army/model/home/notice.dart';

class ListWithTitleAndDayWidget extends StatelessWidget {
  const ListWithTitleAndDayWidget({
    Key key,
    this.headerTile,
    this.title,
    this.notices,
    this.infinite,
    this.maxLines
  }) : super(key: key);

  final bool headerTile;
  final String title;
  final List<Notice> notices;
  final bool infinite;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    int max = 0;

    if (notices.length < maxLines) max = notices.length;
    else max = maxLines;
    return Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 4,
        child: ListView.separated(
            shrinkWrap: true,
            itemCount: infinite ? notices.length + 1 : max + 1,
            itemBuilder: (context, index) {
              if (index == 0) return HeaderTile(title: title);
              return ListTileWithTitleAndDay(notice: notices[notices.length - index]);
            },
            separatorBuilder: (context, index) {
              if (index == 0) return SizedBox.shrink();
              return const Divider(
                color: Colors.black12,
                height: 10,
                thickness: 5,
                indent: 20,
                endIndent: 20,
              );
            })); // ListView
  }
}

class ListTileWithTitleAndDay extends StatelessWidget {
  const ListTileWithTitleAndDay({
    Key key,
    this.notice,
  }) : super(key: key);

  final Notice notice;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(notice.title),
        subtitle: Text(notice.date_yMd),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ListContentView(notice: notice)),
          );
        }); // ListTile
  }
}

class HeaderTile extends StatelessWidget {
  const HeaderTile({
    Key key,
    this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SizedBox(
      width: 27.0,
      height: 13.0,
      child: Card(
        color: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Text(title),
      ),
    ) // SizedBox
        ); // Return Container
  }
}

class ListContentView extends StatelessWidget {
  const ListContentView({Key key, this.notice}) : super(key: key);

  final Notice notice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: ListView(children: <Widget>[
          ListTile(
            leading: Icon(Icons.person, size: 40),
            title: Text(notice.userNickname),
            subtitle: Text(notice.date_yMMMd),
          ),
          Text(notice.contents),
          Container(
            height: 60,
            child: notice.imageList.length > 0
                ? ListView.builder(
                    // 높이 설정 안 됌 -> 수정하기
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: notice.imageList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 50,
                        child: notice.imageList[index] != null
                            ? Image.network(notice.imageList[index])
                            : Container(),
                      ); // Container
                    })
                : Container(), // ListView
          )
        ]));
  }
}
