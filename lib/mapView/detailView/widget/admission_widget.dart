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

class AdmissionWidget extends StatefulWidget {
  @override
  AdmissionWidgetState createState() => AdmissionWidgetState();
}

class AdmissionWidgetState extends State<AdmissionWidget> {
  List<PdfItem> pdfItems = [];

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
    List<String> items = [
      'https://s23.q4cdn.com/202968100/files/doc_downloads/test.pdf',
      'https://s23.q4cdn.com/202968100/files/doc_downloads/test.pdf',
    ];
    List<String> itemsTitle = [
      '2022학년도(82기)육군사관생도모집요강',
      '2022학년도(제82기) 육군사관생도 선발시험 세부시행계획'
    ];
    for (int index = 0; index < items.length; index++)
      pdfItems.add(PdfItem(url: items[index], title: itemsTitle[index]));
    super.initState();
  }

  void viewPdf(BuildContext context, index) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) =>
            PdfViewingWidget(pdfItem: pdfItems[index])));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 10,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              child: ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  itemCount: pdfItems.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                        onTap: () => viewPdf(context, index),
                        title: Text(pdfItems[index].title,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 15)),
                        trailing: IconButton(
                          icon: Icon(Icons.download),
                          onPressed: () {},
                        ));
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      color: Colors.black38,
                      thickness: 2,
                      indent: 10,
                      endIndent: 10,
                    );
                  }),
            )));
  }
}
