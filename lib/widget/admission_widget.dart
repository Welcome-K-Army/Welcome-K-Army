import 'dart:io';
import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import '../model/pdf_items.dart';
import '../page/pdf_viewing_page.dart';

class AdmissionWidget extends StatefulWidget {
  @override
  AdmissionWidgetState createState() => AdmissionWidgetState();
}

class AdmissionWidgetState extends State<AdmissionWidget> {
  PdfItems pdfItems;

  @override
  void initState() {
    List<String> items = [
      'https://www.kma.ac.kr:461/sites/kma/2022%ED%95%99%EB%85%84%EB%8F%84(82%EA%B8%B0)%EC%9C%A1%EA%B5%B0%EC%82%AC%EA%B4%80%EC%83%9D%EB%8F%84%EB%AA%A8%EC%A7%91%EC%9A%94%EA%B0%95.pdf',
      'https://www.kma.ac.kr:461/sites/kma/2022%ED%95%99%EB%85%84%EB%8F%84(%EC%A0%9C82%EA%B8%B0)%20%EC%9C%A1%EA%B5%B0%EC%82%AC%EA%B4%80%EC%83%9D%EB%8F%84%20%EC%84%A0%EB%B0%9C%EC%8B%9C%ED%97%98%20%EC%84%B8%EB%B6%80%EC%8B%9C%ED%96%89%EA%B3%84%ED%9A%8D.pdf',
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
                                onPressed: _createPDF,
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

  Future<void> _createPDF() async {
    //Create a new PDF document
    PdfDocument document = PdfDocument();

    //Add a new page and draw text
    document.pages.add().graphics.drawString('Hello World!', PdfStandardFont(PdfFontFamily.helvetica, 20), brush: PdfSolidBrush(PdfColor(0, 0, 0)), bounds: Rect.fromLTWH(0, 0, 500, 50));

    //Save the document
    List<int> bytes = document.save();
    final directory = await getExternalStorageDirectory();
    final path = directory.path;
    File file = File('$path/Output.pdf');
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open('$path/Output.pdf');

    //Dispose the document
    document.dispose();
  }
}
