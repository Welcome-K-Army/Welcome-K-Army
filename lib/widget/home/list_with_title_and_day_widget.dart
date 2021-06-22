import 'package:flutter/material.dart';

import 'package:Army/model/home/notice.dart';
import 'package:Army/model/home/gallery_item.dart';
import 'package:Army/widget/home/gallery_photo_view_wrapper.dart';

class ListWithTitleAndDayWidget extends StatelessWidget {
  const ListWithTitleAndDayWidget(
      {Key key,
      this.headerTile,
      this.title,
      this.notices,
      this.infinite,
      this.maxLines})
      : super(key: key);

  final bool headerTile;
  final String title;
  final List<Notice> notices;
  final bool infinite;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    int max = 0;

    if (notices.length < maxLines)
      max = notices.length;
    else
      max = maxLines;
    return Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 4,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          HeaderTile(title: title),
          SizedBox.shrink(),
          ListView.separated(
              shrinkWrap: true,
              itemCount: infinite ? notices.length : max,
              itemBuilder: (context, index) {
                return ListTileWithTitleAndDay(
                    notice: notices[notices.length - (index + 1)]);
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  color: Colors.black12,
                  height: 10,
                  thickness: 5,
                  indent: 20,
                  endIndent: 20,
                );
              })
        ])); // ListView
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
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 0, 25, 0),
      child: SizedBox(
        height: 40.0,
        child: Card(
            color: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: Text(title),
            )),
      ),
    ); // SizedBox
    // Return Container
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
                ? notice.imageList[0] != null
                    ? buildGallery(context)
                    : Container()
                : Container(), // ListView
          )
        ]));
  }

  Widget buildGallery(BuildContext context) {
  print(notice.imageList.length);
  print(notice.imageList[0]);
    return Center(
      child: Container(
        height: 100,
        child: ListView(
            scrollDirection: Axis.horizontal,
            //mainAxisAlignment: MainAxisAlignment.center,
            children: List<Widget>.generate(notice.imageList.length, (index) {
              return GalleryItemThumbnail(
                galleryItem: notice.imageList[index],
                onTap: () {
                  open(context, index);
                },
              );
            })),
      ),
    );
  }

  void open(BuildContext context, final int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GalleryPhotoViewWrapper(
          galleryItems: notice.imageList,
          backgroundDecoration: const BoxDecoration(
            color: Colors.black,
          ),
          initialIndex: index,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }
}
