import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

class ListWithTitleAndDay extends StatelessWidget {
  const ListWithTitleAndDay({
    Key key,
    this.title,
    this.length,
    this.listTiles,
  }) : super(key: key);

  final String title;
  final int length;
  final List<ListTile> listTiles;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        itemCount: length + 1,
        itemBuilder: (context, index) {
          if (index == 0) return HeaderTile(title: title);
          return listTiles[index];
        },
        separatorBuilder: (context, index) {
          if (index == 0) return SizedBox.shrink();
          return const Divider();
        }); // ListView
  }
}

class ListTileWithTitleAndDay extends StatelessWidget {
  const ListTileWithTitleAndDay({
    Key key,
    this.title,
    this.date_yMd,
    this.press,
  }) : super(key: key);

  final String title;
  final String date_yMd;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(date_yMd),
      onTap: press,
    ); // ListTile
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

class ListContent extends StatelessWidget {
  const ListContent({
    Key key,
    this.name,
    this.date_yMMMd,
    this.title,
    this.content,
    this.imgList,
  }) : super(key: key);

  final String name;
  final String date_yMMMd;
  final String title;
  final String content;
  final List<String> imgList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: ListView(children: <Widget>[
          ListTile(
            leading: Icon(Icons.person, size: 40),
            title: Text(name),
            subtitle: Text(date_yMMMd),
          ),
          Text(content),
          Container(
            height: 60,
            child: ListView.builder(
                // 높이 설정 안 됌 -> 수정하기
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: imgList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 50,
                    child: Image.asset(imgList[index]),
                  ); // Container
                }), // ListView
          )
        ]));
  }
}