import 'package:Army/global.dart';
import 'package:flutter/material.dart';

import 'package:Army/model/home/pdf_item.dart';
import 'package:Army/widget/home/pdf_viewing_widget.dart';
import 'package:Army/services/firebaseUtil.dart';

class AdmissionWidget extends StatefulWidget {
  String name;
  AdmissionWidget(this.name);

  @override
  AdmissionWidgetState createState() => AdmissionWidgetState(name);
}

class AdmissionWidgetState extends State<AdmissionWidget> {
  String name;
  bool loading = true;
  AdmissionWidgetState(this.name);
  List<PdfItem> pdfItems = [];
  List<String> schoolAdmissionItems = [];
  List<String> schools = ["육군사관학교", "해군사관학교", "공군사관학교", "국군간호사관학교", "육군3사관학교"];
  List<List<String>> schoolAdmissionItemTitleList = [
    ["2022년도 육군사관학교 모집요강"],
    ["2022학년도 해군사관학교 모집요강"],
    ["2022년도 공군사관학교 모집요강"],
    ["2022년도 국군간호사관학교 모집요강"],
    ["2022년도 육군3사관학교 모집요강", "2023년도 육군3사관학교 모집요강"]
  ];

  ///Get the PDF document as bytes.
  Future loadUrl(String title, String path, String filetype) async {
    String temp = "$path/admission/$title.$filetype";
    final url = await FireStoreUtils().getFileUrl("$path/admission/$title.$filetype");
    return url;
  }

  loadUrlList() {
    int index = schools.indexOf(name);
    for (int i = 0; i < schoolAdmissionItemTitleList[index].length; i++) {
      loadUrl(schoolAdmissionItemTitleList[index][i], 'images', 'png')
          .then((pngUrl) {
        loadUrl(schoolAdmissionItemTitleList[index][i], 'pdf', 'pdf')
            .then((pdfUrl) {
          schoolAdmissionItems.add(pngUrl);
          pdfItems.add(PdfItem(url: pdfUrl, title: schoolAdmissionItemTitleList[index][i]));
          if (i == schoolAdmissionItemTitleList[index].length - 1)
            setState(() {
              loading = false;
            });
        });
      });
    }
  }

  @override
  void initState() {
    loadUrlList();
    super.initState();
  }

  void viewPdf(BuildContext context, index) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) =>
            PdfViewingWidget(pdfItem: pdfItems[index])));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: loading
        ? Center(child: CircularProgressIndicator())
        : ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        itemCount: pdfItems.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
              padding: EdgeInsets.all(10.0),
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(children: <Widget>[
                    Padding(
                        padding: EdgeInsets.all(10.0),
                        child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      PdfViewingWidget(pdfItem: pdfItems[index])));
                            },
                            child: Image.network(schoolAdmissionItems[index], height:300))),
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
        })
    );
  }
}
