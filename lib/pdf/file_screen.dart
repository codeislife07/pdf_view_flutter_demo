import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class FilePdfScreen extends StatefulWidget {
  String path;
  FilePdfScreen(this.path, {super.key});

  @override
  State<FilePdfScreen> createState() => _FilePdfScreenState();
}

class _FilePdfScreenState extends State<FilePdfScreen> {
  static const int _initialPage = 1;
  int _actualPageNumber = _initialPage, _allPagesCount = 0;
  late PdfControllerPinch _pdfController;

  @override
  void initState() {
    _pdfController = PdfControllerPinch(
      document: PdfDocument.openFile(widget.path),
      initialPage: _initialPage,
    );
    super.initState();
  }

  @override
  void dispose() {
    _pdfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Load pdf from File"),
      ),
      body: PdfViewPinch(
        controller: _pdfController,
        onDocumentLoaded: (document) {
          setState(() {
            _allPagesCount = document.pagesCount;
          });
        },
        onPageChanged: (page) {
          setState(() {
            _actualPageNumber = page;
          });
        },
      ),
    );
  }
}
