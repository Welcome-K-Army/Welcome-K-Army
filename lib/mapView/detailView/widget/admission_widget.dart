import 'package:flutter/material.dart';
import '../page/pdf_viewing_page.dart';


class AdmissionWidget extends StatefulWidget {
  String pdfurl;

  AdmissionWidget(this.pdfurl, {Key key}) : super(key: key);

  @override
  AdmissionWidgetState createState() => AdmissionWidgetState();
}

class AdmissionWidgetState extends State<AdmissionWidget> {
  @override
  Widget build(BuildContext context) {
    List<String> pdfurl_ = widget.pdfurl;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
            height: size.height,
            width: size.width,
            child: IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => PdfViewingPage(pdfurl_)));
                })));
  }
}
