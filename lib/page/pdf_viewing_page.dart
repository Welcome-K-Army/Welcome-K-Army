import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewingPage extends StatefulWidget {
  @override
  PdfViewingPageState createState() => PdfViewingPageState();
}

class PdfViewingPageState extends State<PdfViewingPage> {
  String url = 'http://ebooks.syncfusion.com/downloads/flutter-succinctly/flutter-succinctly.pdf';
  PdfViewerController _pdfViewerController;
  PdfTextSearchResult _searchResult;
  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    _searchResult = PdfTextSearchResult();
    super.initState();
  }
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
    return Scaffold(
        appBar: AppBar(
          title: Text('Syncfusion Flutter PDF Viewer'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () async {
                _searchResult = await _pdfViewerController.searchText('the', searchOption: TextSearchOption.caseSensitive);
                print('Total instance count: ${_searchResult.totalInstanceCount}');
              },
            ),
          ],
        ),
        body: Container(
            height: size.height,
            width: size.width,
            child: SfPdfViewer.network(
              url,
              controller: _pdfViewerController,
              enableDoubleTapZooming: true,
              enableTextSelection: true,
            )));
  }
}
