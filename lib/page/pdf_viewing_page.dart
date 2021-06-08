import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PdfViewingPage extends StatefulWidget {
  @override
  PdfViewingPageState createState() => PdfViewingPageState();
}

class PdfViewingPageState extends State<PdfViewingPage> {
  String url = 'http://ebooks.syncfusion.com/downloads/flutter-succinctly/flutter-succinctly.pdf';
  PdfViewerController _pdfViewerController;
  PdfTextSearchResult _searchResult;
  OverlayEntry _overlayEntry;

  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    _searchResult = PdfTextSearchResult();
    super.initState();
  }

  void _showContextMenu(BuildContext context, PdfTextSelectionChangedDetails details) {
    final OverlayState _overlayState = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: details.globalSelectedRegion.center.dy - 55,
        left: details.globalSelectedRegion.bottomLeft.dx,
        child: RaisedButton(
          onPressed: () {
            Clipboard.setData(ClipboardData(text: details.selectedText));
            print('Text copied to clipboard: ' + details.selectedText.toString());
            _pdfViewerController.clearSelection();
          },
          color: Colors.white,
          elevation: 10,
          child: Text('Copy', style: TextStyle(fontSize: 17)),
        ),
      ),
    );
    _overlayState.insert(_overlayEntry);
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
            Visibility(
              visible: _searchResult.hasResult,
              child: IconButton(
                icon: Icon(
                  Icons.clear,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    _searchResult.clear();
                  });
                },
              ),
            ),
            Visibility(
              visible: _searchResult.hasResult,
              child: IconButton(
                icon: Icon(
                  Icons.keyboard_arrow_up,
                  color: Colors.white,
                ),
                onPressed: () {
                  _searchResult.previousInstance();
                },
              ),
            ),
            Visibility(
              visible: _searchResult.hasResult,
              child: IconButton(
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.white,
                ),
                onPressed: () {
                  _searchResult.nextInstance();
                },
              ),
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
              onTextSelectionChanged: (PdfTextSelectionChangedDetails details) {
                if (details.selectedText == null && _overlayEntry != null) {
                  _overlayEntry.remove();
                  _overlayEntry = null;
                } else if (details.selectedText != null && _overlayEntry == null) {
                  _showContextMenu(context, details);
                }
              },
            )));
  }
}
