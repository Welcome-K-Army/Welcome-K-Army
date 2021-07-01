import 'package:Army/global.dart';
import 'package:Army/provider/pdf_provider.dart';
import 'package:flutter/material.dart';

import 'package:Army/model/home/pdf_item.dart';
import 'package:Army/widget/home/pdf_viewing_widget.dart';
import 'package:Army/services/firebaseUtil.dart';
import 'package:provider/provider.dart';

class AdmissionWidget extends StatefulWidget {
  String name;
  AdmissionWidget(this.name);

  @override
  AdmissionWidgetState createState() => AdmissionWidgetState(name);
}

class AdmissionWidgetState extends State<AdmissionWidget> {
  String name;
  AdmissionWidgetState(this.name);

  void viewPdf(BuildContext context, index) {
    final pdfProvider=Provider.of<PdfProvider>(context);
    int i = pdfProvider.schools.indexOf(name);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) =>
            PdfViewingWidget(pdfItem: pdfProvider.schoolAdmissionPdfItems[i][index])));
  }

  @override
  Widget build(BuildContext context) {
    final pdfProvider=Provider.of<PdfProvider>(context);
    int i = pdfProvider.schoolAdmission.indexOf(name);
    print(pdfProvider.schoolAdmissionPdfItems[i].asMap());
    return Container(
        child:  ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        itemCount: pdfProvider.schoolAdmissionPdfItems[i].length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
              padding: EdgeInsets.all(10.0),
              child: pdfProvider.admissionLoading
                  ? Center(child: CircularProgressIndicator())
                  : Card(
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
                                      PdfViewingWidget(pdfItem: pdfProvider.schoolAdmissionPdfItems[i][index])));
                            },
                            child: Image.network(pdfProvider.schoolAdmissionItems[i][index], height:300))),
                    Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: Text(pdfProvider.schoolAdmissionPdfItems[i][index].title,
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
