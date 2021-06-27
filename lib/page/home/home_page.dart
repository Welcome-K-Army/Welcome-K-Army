import 'dart:io';
import 'dart:typed_data';

import 'package:Army/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter/services.dart';

import 'notice_list_page.dart';
import 'package:provider/provider.dart';
import 'package:native_pdf_renderer/native_pdf_renderer.dart';
import 'package:thumbnailer/thumbnailer.dart';

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
  PdfPageImage pdf;
  List<PdfPageImage> pdfList = [];
  List<PdfItem> pdfItems = [];
  List<String> items = [
    'https://s23.q4cdn.com/202968100/files/doc_downloads/test.pdf',
    'https://s23.q4cdn.com/202968100/files/doc_downloads/test.pdf',
  ];
  List<String> itemsTitle = [
    '2022학년도(82기)육군사관생도모집요강',
    '2022학년도(제82기) 육군사관생도 선발시험 세부시행계획'
  ];

  ///Get the PDF document as bytes.
  Future<PdfPageImage> getPdfThumbnails(String url) async {
    final _documentBytes = (await NetworkAssetBundle(Uri.parse(url)).load(url))
        .buffer
        .asUint8List();
    final document = await PdfDocument.openData(_documentBytes);
    final page = await document.getPage(1);
    final pageImage = await page.render(width: page.width, height: 400);
    await page.close();
    return pageImage;
  }

  Future loadPdf(String url) async {
    final pdfThumbnail = await getPdfThumbnails(url);
    print(pdfThumbnail);
    pdf = pdfThumbnail;
    return pdf;
  }

  loadPdfsList() {
    for (int index = 0; index < items.length; index++) {
      loadPdf(items[index]).then((value) {
        pdfList.add(value);
      });
    }
  }

  @override
  void initState() {
    for (int index = 0; index < items.length; index++) {
      pdfItems.add(PdfItem(url: items[index], title: itemsTitle[index]));
      loadPdfsList();
    }
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
        height: 350,
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
                    return !pdfList.isEmpty
                        ? Column(children: [
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
                                        child: Image(
                                            image: MemoryImage(
                                                pdfList[index].bytes))))),
                            Padding(
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                                child: Text(pdfItems[index]?.title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                          ])
                        : Center(child:CircularProgressIndicator());
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
