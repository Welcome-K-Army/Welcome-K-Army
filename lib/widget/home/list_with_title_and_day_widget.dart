import 'package:Army/constants.dart';
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 4,
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 10,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10))),
              ),
            ),
            MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
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
                        thickness: 2,
                        indent: 20,
                        endIndent: 20,
                      );
                    }))
          ],
        )); // ListView
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(notice.title),
            Text(
              notice.date_yMd,
              style: TextStyle(fontSize: 14, color: Colors.black54),
            )
          ],
        ),
        subtitle: Text(notice.contents, overflow: TextOverflow.ellipsis),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ListContentView(notice: notice)),
          );
        }); // ListTile
  }
}

class ListContentView extends StatelessWidget {
  const ListContentView({Key key, this.notice}) : super(key: key);

  final Notice notice;

  String processString(String str){
    List<String> tmpList = str.split('\\');
    String result = "";
    tmpList.forEach((e) => result = result + e + "\n");
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          )),
          backgroundColor: Color(COLOR_PRIMARY),
          title: Padding(
              padding: EdgeInsets.only(bottom: 4),
              child: Text(
                notice.title,
                style: TextStyle(fontSize: 18),
              )),
        ),
        body: Padding(padding:EdgeInsets.symmetric(vertical: 5,horizontal: 10),
            child:
            ListView(children: <Widget>[
              SizedBox(width: double.infinity,height: 5,),
              // Card(
              //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
              //     elevation: 5,
              //     child:
                  ListTile(
                leading: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.black12,
                  ),
                  child: Icon(
                    Icons.person,
                    size: 40,
                  ),
                ),
                title: Text(notice.userNickname,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(notice.date_yMMMd),
              ),
              // ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                decoration: BoxDecoration(

                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    notice.imageList.length > 0 && notice.imageList[0] != null? Container(
                      padding: EdgeInsets.symmetric(vertical: 10
                      ),
                      child: buildGallery(context)
                    ): Container(),
                    Padding(
                      padding:EdgeInsets.symmetric(horizontal: 10),
                      child: Text(processString(notice.contents)),
                    )
                  ],
                )
              )
              ,

            ]),
        ));
  }

  Widget buildGallery(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
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
