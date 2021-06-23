import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:thumbnailer/thumbnailer.dart';

import '../model/pdf_items.dart';
import '../page/pdf_viewing_page.dart';

class AdmissionWidget extends StatefulWidget {
  @override
  AdmissionWidgetState createState() => AdmissionWidgetState();
}

class AdmissionWidgetState extends State<AdmissionWidget> {
  PdfItems pdfItems;

  ///Get the PDF document as bytes.
  Future<Uint8List> getPdfBytes(String url) async {
    Uint8List _documentBytes;
    print("before");
    _documentBytes = (await NetworkAssetBundle(Uri.parse(url)).load(url)).buffer.asUint8List();
    print(_documentBytes);
    return _documentBytes;
  }

  @override
  void initState() {
    List<String> items = [
      'https://firebasestorage.googleapis.com/v0/b/login-project-afa09.appspot.com/o/pdf%2F2022%ED%95%99%EB%85%84%EB%8F%84(82%EA%B8%B0)%EC%9C%A1%EA%B5%B0%EC%82%AC%EA%B4%80%EC%83%9D%EB%8F%84%EB%AA%A8%EC%A7%91%EC%9A%94%EA%B0%95.pdf?alt=media&token=b0d42ed4-0949-4c14-a41f-758bc966762a',
      'https://firebasestorage.googleapis.com/v0/b/login-project-afa09.appspot.com/o/pdf%2F2022%ED%95%99%EB%85%84%EB%8F%84(82%EA%B8%B0)%EC%9C%A1%EA%B5%B0%EC%82%AC%EA%B4%80%EC%83%9D%EB%8F%84%EB%AA%A8%EC%A7%91%EC%9A%94%EA%B0%95.pdf?alt=media&token=b0d42ed4-0949-4c14-a41f-758bc966762a'
    ];
    List<String> itemsTitle = [
      '2022학년도(82기)육군사관생도모집요강',
      '2022학년도(제82기) 육군사관생도 선발시험 세부시행계획'
    ];
    pdfItems = PdfItems(items: items, itemsTitle: itemsTitle);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(10),
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8),
                    itemCount: pdfItems.itemsTitle.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                          leading: Thumbnail(
                            dataResolver: () async {
                              Uint8List _documentBytes;
                              _documentBytes = await getPdfBytes(pdfItems.items[index]);
                              print("after");
                              print(_documentBytes);
                              return _documentBytes;
                            },
                            mimeType: 'application/pdf',
                            widgetSize: 150,
                          ),
                          title: Text(pdfItems.itemsTitle[index]),
                          trailing: Wrap(
                            spacing: 12, // space between two icons
                            children: <Widget>[
                              IconButton(
                                  icon: Icon(Icons.search),
                                  onPressed: () {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => PdfViewingPage(pdfItem: pdfItems.items[index], title: pdfItems.itemsTitle[index])));
                                  }),
                              IconButton(
                                icon: Icon(Icons.copy),
                                onPressed: () {},
                              )
                            ],
                          ));
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                        color: Colors.black12,
                        height: 10,
                        thickness: 5,
                        indent: 20,
                        endIndent: 20,
                      );
                    }),
              ), // Padding
            )));
  }
}