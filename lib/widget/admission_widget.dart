import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class AdmissionWidget extends StatefulWidget {
  @override
  AdmissionWidgetState createState() => AdmissionWidgetState();
}

class AdmissionWidgetState extends State<AdmissionWidget> {
    @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: SfPdfViewer.network(
                'http://ebooks.syncfusion.com/downloads/flutter-succinctly/flutter-succinctly.pdf')));
  }
}
  