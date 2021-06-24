import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    pdfItems = PdfItems(items: items, itemsTitle: itemsTitle);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.all(10),
      child: ListView.separated(
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
          itemCount: pdfItems.itemsTitle.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
                leading: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => PdfViewingPage(pdfItem: pdfItems.items[index], title: pdfItems.itemsTitle[index])));
                  },
                  child: Thumbnail(
                    dataResolver: () async {
                      return getPdfBytes(pdfItems.items[index]);
                    },
                    mimeType: 'application/pdf',
                    widgetSize: 50,
                  ),
                ),
                title: Text(pdfItems.itemsTitle[index], overflow: TextOverflow.ellipsis),
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
            return Container(height: 5, width: 0);
            /*const Divider(
              color: Colors.black12,
              height: 10,
              thickness: 5,
              indent: 20,
              endIndent: 20,
            );
            */
          }),
    ));
  }
}
