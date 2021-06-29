import 'dart:io';
import 'dart:typed_data';

import 'package:Army/model/user.dart';
import 'package:Army/services/firebaseUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'notice_list_page.dart';
import 'package:provider/provider.dart';

import 'package:Army/provider/event_provider.dart';
import 'package:Army/constants.dart';
import 'package:Army/global.dart';

import 'package:Army/model/home/menu.dart';
import 'package:Army/model/home/pdf_item.dart';
import 'package:Army/provider/noticeProvider.dart';
import 'package:Army/page/home/news_list_page.dart';

import 'package:Army/widget/home/title_with_more_btn_widget.dart';
import 'package:Army/widget/home/pdf_viewing_widget.dart';
import 'package:Army/widget/home/list_with_title_and_day_widget.dart';

class HomePage extends StatefulWidget {
  final User user;
  HomePage({Key key, @required this.user}) : super(key: key);
  HomePageState createState() => new HomePageState(user);
}

class HomePageState extends State<HomePage> {
  final User user;
  HomePageState(this.user);
  List<PdfItem> pdfItems = [];
  List<String> schoolNewsItems = [];
  List<String> schools = ["육군사관학교", "해군사관학교", "공군사관학교", "국군간호사관학교", "육군3사관학교"];
  List<String> schoolNewsItemTitleList = [
    "육사신보 제629호",
    "해사학보 제312호",
    "공사신문 제357호",
    "국간사학보 제127호",
    "충성대신문 제188호"
  ];

  ///Get the PDF document as bytes.
  Future loadUrl(String schools, String title, String path, String filetype) async {
    final url = await FireStoreUtils().getFileUrl("$path/news/$schools/$title.$filetype");
    print(url);
    return url;
  }

  loadUrlList() {
    for (int index = 0; index < schools.length; index++) {
      loadUrl(schools[index], schoolNewsItemTitleList[index], 'images', 'png').then((pngUrl){
        schoolNewsItems.add(pngUrl);
      });
      loadUrl(schools[index], schoolNewsItemTitleList[index], 'pdf', 'pdf').then((pdfUrl) {
        pdfItems.add(PdfItem(url: pdfUrl, title: schoolNewsItemTitleList[index]));
      });
    }
  }

  @override
  void initState() {
    loadUrlList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xFFEDF0F4),
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(children: <Widget>[
              buildHeader(),
              buildNews(),
              SizedBox(
                height: 10,
              ),
              buildNotice(),
              SizedBox(
                height: 20,
              ),
            ])));
  } // Widget

  Widget buildHeader() {
    double _height = MediaQuery.of(context).size.height + 150.0;
    return Container(
        height: _height * 0.2,
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                  left: kDefaultPadding,
                  right: kDefaultPadding,
                  bottom: 36 + kDefaultPadding,
                  top: MediaQuery.of(context).padding.top + 20.0),
              height: _height * 0.2 - 27,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(36),
                  bottomRight: Radius.circular(36),
                ), // BorderRadius.only
              ), // BoxDecoration
              child: Row(
                children: <Widget>[
                  Text(
                    '반갑습니다 ' + user.nickName + '님!',
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                  Spacer(),
                  Icon(Icons.favorite, color: Colors.lightGreen[50], size: 100)
                ],
              ), // Row
            ), // Container
          ],
        )); // Container
  }

  Widget buildNews() {
    return Container(
        color: Color(0xFFEDF0F4),
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(children: <Widget>[
              TitleWithMoreBtnWidget(
                  title: "뉴스",
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NewsListPage()),
                    );
                  }),
              buildSlideBanner(),
            ])));
  }

  Widget buildSlideBanner() {
    return Container(
      height: 400,
        child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 4,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Swiper(
                  autoplay: false,
                  scale: 0.8,
                  viewportFraction: 1,
                  pagination: new SwiperPagination(
                    alignment: Alignment.bottomCenter,
                    builder: new DotSwiperPaginationBuilder(
                        color: Colors.grey, activeColor: Color(COLOR_PRIMARY)),
                  ),
                  itemCount: pdfItems.length, //notice imagelist length
                  itemBuilder: (BuildContext context, int index) {
                    return schoolNewsItems.isNotEmpty
                        ? Column(
                        children: [
                            Padding(
                                padding: EdgeInsets.all(10),
                                child: Center(
                                    child: InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          PdfViewingWidget(
                                                              pdfItem: pdfItems[
                                                                  index])));
                                        },
                                        child: Image.network(schoolNewsItems[index], height:300)))),
                            Padding(
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                                child: Text(pdfItems[index]?.title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                          ])
                        : Center(child: CircularProgressIndicator());
                  }), // Swiper
            ))
    );
  }

  Widget buildMenu() {
    return Container(
        color: Color(0xFFEDF0F4),
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TitleWithMoreBtnWidget(title: "Favorite", press: () {}),
                  Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 4,
                      child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 2,
                          mainAxisSpacing: 2,
                        ),
                        itemCount: menuList.length,
                        itemBuilder: (context, index) {
                          return buildMenuIconBtn(menuList[index]);
                        },
                      )),
                ]))); // GridView
  }

  Widget buildMenuIconBtn(Menu menu) {
    final provider = Provider.of<EventProvider>(context);
    final noticeProvider = Provider.of<NoticeProvider>(context);
    return InkWell(
      onTap: () {
        provider.readEvent();
        noticeProvider.readNotice();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (BuildContext context) => menu.widget),
        );
      },
      child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            menu.icon,
            Text(menu.name),
          ]), // Column
    ); // ListTile
  }

  Widget buildNotice() {
    final noticeProvider = Provider.of<NoticeProvider>(context);
    noticeProvider.readNotice();
    return Container(
      color: Color(0xFFEDF0F4),
      //height: 360,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TitleWithMoreBtnWidget(
                title: "공지",
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NoticeListPage()),
                  );
                }),
            ListWithTitleAndDayWidget(
                headerTile: false,
                title: "Notice",
                notices: noticeProvider.notices,
                infinite: false,
                maxLines: 4),
          ], // Column children
        ), // Column
      ), // Padding
    ); // Container
  }
} // Class
