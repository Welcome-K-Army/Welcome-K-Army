import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:thumbnailer/thumbnailer.dart';

import 'package:Army/model/home/pdf_item.dart';
import 'package:Army/widget/home/pdf_viewing_widget.dart';

class NewsListPage extends StatefulWidget {
  @override
  NewsListPageState createState() => NewsListPageState();
}

class NewsListPageState extends State<NewsListPage> {
  List<PdfItem> pdfItems;

  ///Get the PDF document as bytes.
  Future<Uint8List> getPdfBytes(String url) async {
    Uint8List _documentBytes;
    _documentBytes = (await NetworkAssetBundle(Uri.parse(url)).load(url)).buffer.asUint8List();
    return _documentBytes;
  }

  @override
  void initState() {
    List<String> items = [
      'https://s23.q4cdn.com/202968100/files/doc_downloads/test.pdf',
      'https://s23.q4cdn.com/202968100/files/doc_downloads/test.pdf',
    ];
    List<String> itemsTitle = [
      '2022학년도(82기)육군사관생도모집요강',
      '2022학년도(제82기) 육군사관생도 선발시험 세부시행계획'
    ];
    for (int index = 0; index < items.length; index++) pdfItems.add(PdfItem(item: items[index], title: itemsTitle[index]));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(contgext).size;
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.all(10),
      child: ListView.separated(
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
          itemCount: pdfItems.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
                padding: EdgeInsets.all(10.0),
                child: Card(
                    child: Column(children: <Widget>[
                  InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => PdfViewingPage(pdfItem: pdfItems[index].item, title: pdfItems[index].title)));
                      },
                      child: Thumbnail(
                        dataResolver: () async {
                          return getPdfBytes(pdfItems[index].item);
                        },
                        mimeType: 'application/pdf',
                        widgetSize: size.width - 20,
                      )),
                  Text(pdfItems[index].title, style: TextStyle(fontWeight: FontWeight.bold)),
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
          }),
    ));
  }
}