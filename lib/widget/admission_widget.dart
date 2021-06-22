import 'package:flutter/material.dart';

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
    pdfItems.items = [
      'https://firebasestorage.googleapis.com/v0/b/login-project-afa09.appspot.com/o/pdf%2F2022%ED%95%99%EB%85%84%EB%8F%84(82%EA%B8%B0)%EC%9C%A1%EA%B5%B0%EC%82%AC%EA%B4%80%EC%83%9D%EB%8F%84%EB%AA%A8%EC%A7%91%EC%9A%94%EA%B0%95.pdf?alt=media&token=b0d42ed4-0949-4c14-a41f-758bc966762a',
      'https://firebasestorage.googleapis.com/v0/b/login-project-afa09.appspot.com/o/pdf%2F2022%ED%95%99%EB%85%84%EB%8F%84(%EC%A0%9C82%EA%B8%B0)%20%EC%9C%A1%EA%B5%B0%EC%82%AC%EA%B4%80%EC%83%9D%EB%8F%84%20%EC%84%A0%EB%B0%9C%EC%8B%9C%ED%97%98%20%EC%84%B8%EB%B6%80%EC%8B%9C%ED%96%89%EA%B3%84%ED%9A%8D.pdf?alt=media&token=f2d67e3d-d6ef-4ebc-93f5-0b86d225c447'
    ];
    pdfItems.itemsTitle = [
      '2022학년도(82기)육군사관생도모집요강',
      '2022학년도(제82기) 육군사관생도 선발시험 세부시행계획'
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: pdfItems.items.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
                title: Text(pdfItems.itemsTitle[index]),
                trailing: Wrap(
                  spacing: 12, // space between two icons
                  children: <Widget>[
                    IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => PdfViewingPage(pdfItems.items[index])));
                        })
                  ],
                ));
          }),
    );
  }
}
