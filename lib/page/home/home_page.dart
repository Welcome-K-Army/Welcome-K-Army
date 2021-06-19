import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'notice_list_page.dart';
import 'package:provider/provider.dart';

import 'package:Army/provider/event_provider.dart';
import 'package:Army/constants.dart';
import 'package:Army/global.dart';

import 'package:Army/model/home/menu.dart';
import 'package:Army/provider/noticeProvider.dart';

import 'package:Army/widget/home/title_with_more_btn_widget.dart';
import 'package:Army/widget/home/list_with_title_and_day_widget.dart';

class HomePage extends StatefulWidget {
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xFFEDF0F4),
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(children: <Widget>[
              buildHeader(),
              buildNews(),
              Container(
                height: 50,
              ),
              buildMenu(),
              Container(
                height: 50,
              ),
              buildNotice(),
            ] // <Widget>[]
                ) // Column
            ) // SingleChildScrollview
        ); // Container
  } // Widget

  Widget buildHeader() {
    Size size = MediaQuery.of(context).size;
    return Container(
        height: size.height * 0.2,
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                left: kDefaultPadding,
                right: kDefaultPadding,
                bottom: 36 + kDefaultPadding,
              ),
              height: size.height * 0.2 - 27,
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
                    'wecome k army',
                    style: Theme.of(context).textTheme.headline5?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Image.asset("assets/images/4.jpg")
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
              TitleWithMoreBtnWidget(title: "News", press: () {}),
              buildSlideBanner(),
            ])));
  }

  Widget buildSlideBanner() {
    return Container(
      height: 200,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Swiper(
              autoplay: true,
              scale: 0.8,
              viewportFraction: 1,
              pagination: SwiperPagination(),
              itemCount: publicImgList.length, //notice imagelist length
              itemBuilder: (BuildContext context, int index) {
                return Image.asset(publicImgList[index]);
              }), // Swiper
        ),
      ), // Padding
    ); // Container
  }

  Widget buildMenu() {
    return Container(
        color: Color(0xFFEDF0F4),
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
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
      child: Column(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
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
                title: "Notice",
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NoticeListPage()),
                  );
                }),
            ListWithTitleAndDayWidget(headerTile: true, title: "Notice", notices: noticeProvider.notices),
          ], // Column children
        ), // Column
      ), // Padding
    ); // Container
  }
} // Class
