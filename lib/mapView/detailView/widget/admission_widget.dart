import 'package:flutter/material.dart';
import '../page/pdf_viewing_page.dart';


class AdmissionWidget extends StatefulWidget {
  final List<String> informList;

  AdmissionWidget(this.informList, {Key key}) : super(key: key);

  @override
  AdmissionWidgetState createState() => AdmissionWidgetState();
}

class AdmissionWidgetState extends State<AdmissionWidget> {
  @override
  Widget build(BuildContext context) {
    List<String> informList_ = widget.informList;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
            height: size.height,
            width: size.width,
            child: IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => PdfViewingPage(informList_[5])));
                })));
  }
}
