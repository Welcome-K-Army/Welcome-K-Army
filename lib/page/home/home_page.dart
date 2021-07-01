import 'package:Army/model/user.dart';
import 'package:Army/provider/pdf_provider.dart';
import 'package:Army/services/firebaseUtil.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'notice_list_page.dart';
import 'package:provider/provider.dart';

import 'package:Army/provider/event_provider.dart';
import 'package:Army/constants.dart';
import 'package:Army/global.dart';
import 'package:Army/assets/custom_icons.dart';

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

  @override
  void initState() {
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
                  left: kDefaultPadding + 20,
                  right: kDefaultPadding + 20,
                  bottom: kDefaultPadding,
                  top: MediaQuery.of(context).padding.top + 14.0),
              height: _height * 0.2 - 28,
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
                    '안녕하세요\n' + user.nickName + ' 님!',
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 20.0),
                  ),
                  Spacer(),
                  Column(children: [
                    Icon(CustomIcons.go2star,
                        color: Colors.lightGreen[50], size: 65),
                    Text(
                      "켠김에 별까지",
                      style: Theme.of(context).textTheme.headline5?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 10.0),
                    ),
                  ]),
                  //Image.asset("lib/assets/go2star.png", width: 100, height: 100),
                  // Icon(Icons.favorite, color: Colors.lightGreen[50], size: 100)
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
    final pdfProvider = Provider.of<PdfProvider>(context);
    return Container(
        height: 400,
        child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 4,
            child: pdfProvider.newsLoading
                ? Center(child: CircularProgressIndicator())
                : Padding(
                    padding: EdgeInsets.all(10),
                    child: Swiper(
                        autoplay: false,
                        scale: 0.8,
                        viewportFraction: 1,
                        pagination: new SwiperPagination(
                          alignment: Alignment.bottomCenter,
                          builder: new DotSwiperPaginationBuilder(
                              color: Colors.grey,
                              activeColor: Color(COLOR_PRIMARY)),
                        ),
                        itemCount: pdfProvider.schoolNewsPdfItems.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(children: [
                            Padding(
                                padding: EdgeInsets.all(10),
                                child: Center(
                                    child: InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (BuildContext
                                                          context) =>
                                                      PdfViewingWidget(
                                                          pdfItem: pdfProvider
                                                                  .schoolNewsPdfItems[
                                                              index][4])));
                                        },
                                        child: Image.network(
                                            pdfProvider.schoolNewsItems[index]
                                                [4],
                                            height: 300)))),
                            Padding(
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                                child: Text(
                                    pdfProvider
                                        .schoolNewsPdfItems[index][4].title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                          ]);
                        }), // Swiper
                  )));
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
