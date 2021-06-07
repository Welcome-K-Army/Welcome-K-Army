import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class AdmissionWidget extends StatefulWidget {
  @override
  AdmissionWidgetState createState() => AdmissionWidgetState();
}

class AdmissionWidgetState extends State<AdmissionWidget> {
  /*  
  // Load document from the Asset
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(child: SfPdfViewer.asset('assets/flutter-succinctly.pdf')));
  }
  */

  /*
  // Load document from the File
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(child: SfPdfViewer.file(File('storage/emulated/0/Download/flutter-succinctly.pdf'))));
  }
  */

  /*
  // Load document from the Memory
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(child: SfPdfViewer.memory(bytes)));
  }
  */

  // Load document from the Network
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(body: Container(height: size.height, width: size.width, child: SfPdfViewer.network('http://ebooks.syncfusion.com/downloads/flutter-succinctly/flutter-succinctly.pdf', enableDoubleTapZooming: false)));
  }
}
