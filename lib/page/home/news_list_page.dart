import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:thumbnailer/thumbnailer.dart';

import 'package:Army/constants.dart';
import 'package:Army/model/home/pdf_item.dart';
import 'package:Army/widget/home/pdf_viewing_widget.dart';

class NewsListPage extends StatefulWidget {
  @override
  NewsListPageState createState() => NewsListPageState();
}

class NewsListPageState extends State<NewsListPage> {
  List<String> schools = [
    "육사학보",
    "해사학보",
    "공사학보",
    "간호학보"
  ];
  String school;
  PdfPageImage pdf;
  List<PdfPageImage> pdfList = [];
  List<PdfPageImage> pdfList1 = [];
  List<PdfItem> pdfItems = [];
  List<PdfItem> pdfItems1 = [];
  List<String> schools = [
    "육군사관학교",
    "해군사관학교",
    "공군사관학교",
    "국군간호사관학교",
    "육군3사관학교"
  ];
  List<String> items = [
    'https://s23.q4cdn.com/202968100/files/doc_downloads/test.pdf',
    'https://s23.q4cdn.com/202968100/files/doc_downloads/test.pdf',
    'https://s23.q4cdn.com/202968100/files/doc_downloads/test.pdf',
    'https://s23.q4cdn.com/202968100/files/doc_downloads/test.pdf'
  ];
  List<String> items1 = [
    'https://s-space.snu.ac.kr/bitstream/10371/160367/1/2%20%EA%B9%80%EC%84%9D%EC%A7%84.pdf',
    'https://s-space.snu.ac.kr/bitstream/10371/160367/1/2%20%EA%B9%80%EC%84%9D%EC%A7%84.pdf',
    'https://s-space.snu.ac.kr/bitstream/10371/160367/1/2%20%EA%B9%80%EC%84%9D%EC%A7%84.pdf'
  ];
  List<String> itemsTitle = [
    '2022학년도(82기)육군사관생도모집요강',
    '2022학년도(제82기) 육군사관생도 선발시험 세부시행계획',
    '2022학년도(제82기) 육군사관생도 선발시험 세부시행계획',
    '2022학년도(제82기) 육군사관생도 선발시험 세부시행계획'
  ];

  ///Get the PDF document as bytes.
  Future<PdfPageImage> getPdfThumbnails(String url) async {
    final _documentBytes = (await NetworkAssetBundle(Uri.parse(url)).load(url)).buffer.asUint8List();
    final document = await PdfDocument.openData(_documentBytes);
    final page = await document.getPage(1);
    final pageImage = await page.render(width: page.width, height: 400);
    await page.close();
    return pageImage;
  }

  Future loadPdf(String url) async {
    final pdfThumbnail = await getPdfThumbnails(url);
    pdf = pdfThumbnail;
    return pdf;
  }

  loadPdfsList() {
    for (int index = 0; index < items.length; index++) {
      loadPdf(items[index]).then((value) {
        pdfList.add(value);
      });
    }
    for (int index = 0; index < items1.length; index++) {
      loadPdf(items1[index]).then((value) {
        pdfList1.add(value);
      });
    }
  }

  @override
  void initState() {
    school = schools[0];
    loadPdfsList();
    for (int index = 0; index < items.length; index++) {
      pdfItems.add(PdfItem(url: items[index], title: itemsTitle[index]));
      pdfItems1.add(PdfItem(url: items1[index], title: itemsTitle[index]));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          )),
          backgroundColor: Color(COLOR_PRIMARY),
          title: buildDropdownBtn()),
      body: buildnews(school, size),
    );
  }

  Widget buildDropdownBtn() {
    return DropdownButtonHideUnderline(
        child: DropdownButton(
      isExpanded: true,
      iconSize: 24,
      elevation: 16,
      underline: Container(decoration: BoxDecoration(border: Border.all(width: 0.5, color: Colors.black38))),
      dropdownColor: Colors.white,
      style: TextStyle(
        color: Colors.black,
      ),
      value: school,
      onChanged: (val) => setState(() => school = val), // 이 부분에 네트워크 pdf 연결코드 넣기
      items: [
        for (var sch in schools)
          DropdownMenuItem(
            value: sch,
            child: SizedBox(
              child: Text(
                sch.toString(),
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black87,
                ),
              ),
            ),
          ),
      ],
    )); // Container
  }

  Widget buildnews(String school, Size size) {
    if (school == "육군사관학교" || "해군사관학교" || "공군사관학교")
      return buildNewsCard(pdfItems, size);
    else
      return buildNewsCard(pdfItems1, size);
  }

  Widget buildNewsCard(List<PdfItem> pdfItems, Size size) {
    return ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        itemCount: pdfItems.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
              padding: EdgeInsets.all(10.0),
              child: Card(
                  child: Column(children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(10.0),
                    child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => PdfViewingWidget(pdfItem: pdfItems[index])));
                        },
                        child: Image(image: MemoryImage(pdfList[index].bytes)))),
                Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 10), child: Text(pdfItems[index].title, style: TextStyle(fontWeight: FontWeight.bold))),
              ])));
        },
        separatorBuilder: (context, index) {
          return const Divider(
            color: Colors.black12,
            height: 10,
            thickness: 1,
            indent: 15,
            endIndent: 15,
          );
        });
  }
}
/*
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:thumbnailer/thumbnailer.dart';

import 'package:Army/constants.dart';
import 'package:Army/model/home/pdf_item.dart';
import 'package:Army/widget/home/pdf_viewing_widget.dart';

class NewsListPage extends StatefulWidget {
  @override
  NewsListPageState createState() => NewsListPageState();
}

class NewsListPageState extends State<NewsListPage> {
  String school;
  PdfPageImage pdf;
  List<PdfPageImage> pdfList = [];
  List<PdfItem> pdfItems = [];
  List<String> schools = [
    "육군사관학교",
    "해군사관학교",
    "공군사관학교",
    "국군간호사관학교",
    "육군3사관학교"
  ];
  List<String> items = [
    'https://s23.q4cdn.com/202968100/files/doc_downloads/test.pdf',
    'https://s23.q4cdn.com/202968100/files/doc_downloads/test.pdf',
    'https://s23.q4cdn.com/202968100/files/doc_downloads/test.pdf',
    'https://s23.q4cdn.com/202968100/files/doc_downloads/test.pdf'
  ];
  List<String> itemsTitle = [
    '2022학년도(82기)육군사관생도모집요강',
    '2022학년도(제82기) 육군사관생도 선발시험 세부시행계획',
    '2022학년도(제82기) 육군사관생도 선발시험 세부시행계획',
    '2022학년도(제82기) 육군사관생도 선발시험 세부시행계획'
  ];

  ///Get the PDF document as bytes.
  Future<PdfPageImage> getPdfThumbnails(String url) async {
    final _documentBytes = (await NetworkAssetBundle(Uri.parse(url)).load(url)).buffer.asUint8List();
    final document = await PdfDocument.openData(_documentBytes);
    final page = await document.getPage(1);
    final pageImage = await page.render(width: page.width, height: 400);
    await page.close();
    return pageImage;
  }

  Future loadPdf(String url) async {
    final pdfThumbnail = await getPdfThumbnails(url);
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
    school = schools[0];
    loadPdfsList();
    for (int index = 0; index < items.length; index++) {
      pdfItems.add(PdfItem(url: items[index], title: itemsTitle[index]));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          )),
          backgroundColor: Color(COLOR_PRIMARY),
          title: buildDropdownBtn()),
      body: buildNewsCard(size),
    );
  }

  Widget buildDropdownBtn() {
    return DropdownButtonHideUnderline(
        child: DropdownButton(
      isExpanded: true,
      iconSize: 24,
      elevation: 16,
      underline: Container(decoration: BoxDecoration(border: Border.all(width: 0.5, color: Colors.black38))),
      dropdownColor: Colors.white,
      style: TextStyle(
        color: Colors.black,
      ),
      value: school,
      onChanged: (val) => setState(() => school = val), // 이 부분에 네트워크 pdf 연결코드 넣기
      items: [
        for (var sch in schools)
          DropdownMenuItem(
            value: sch,
            child: SizedBox(
              child: Text(
                sch.toString(),
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black87,
                ),
              ),
            ),
          ),
      ],
    )); // Container
  }

  Widget buildNewsCard(Size size) {
    return ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        itemCount: pdfItems.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
              padding: EdgeInsets.all(10.0),
              child: Card(
                  child: Column(children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(10.0),
                    child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => PdfViewingWidget(pdfItem: pdfItems[index])));
                        },
                        child: Image(image: MemoryImage(pdfList[index].bytes)))),
                Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 10), child: Text(pdfItems[index].title, style: TextStyle(fontWeight: FontWeight.bold))),
              ])));
        },
        separatorBuilder: (context, index) {
          return const Divider(
            color: Colors.black12,
            height: 10,
            thickness: 1,
            indent: 15,
            endIndent: 15,
          );
        });
  }
}
*/
