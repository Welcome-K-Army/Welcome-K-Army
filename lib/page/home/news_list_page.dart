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
  List<PdfItem> pdfItems = [];
  List<String> schools = ["육사학보", "해사학보", "공사학보", "간호학보"];
  String school;

  ///Get the PDF document as bytes.
  Future<Uint8List> getPdfBytes(String url) async {
    Uint8List _documentBytes;
    _documentBytes = (await NetworkAssetBundle(Uri.parse(url)).load(url))
        .buffer
        .asUint8List();
    return _documentBytes;
  }

  @override
  void initState() {
    school = schools[0];
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
    for (int index = 0; index < items.length; index++)
      pdfItems.add(PdfItem(url: items[index], title: itemsTitle[index]));
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
      body: buildNewsCard(school, size),
    );
  }

  Widget buildDropdownBtn() {
    return DropdownButtonHideUnderline(
        child: DropdownButton(
      isExpanded: true,
      iconSize: 24,
      elevation: 16,
      underline: Container(
          decoration: BoxDecoration(
              border: Border.all(width: 0.5, color: Colors.black38))),
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

  Widget buildNewsCard(String school, Size size) {
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
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  PdfViewingWidget(pdfItem: pdfItems[index])));
                        },
                        child: Thumbnail(
                          dataResolver: () {
                            return getPdfBytes(pdfItems[index].url);
                          },
                          mimeType: 'application/pdf',
                          widgetSize: size.width / 2 - 20,
                        ))),
                Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: Text(pdfItems[index].title,
                        style: TextStyle(fontWeight: FontWeight.bold))),
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
