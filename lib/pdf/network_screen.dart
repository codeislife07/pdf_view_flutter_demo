import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pdfx/pdfx.dart';

class NetworkScreen extends StatefulWidget {
  const NetworkScreen({super.key});

  @override
  State<NetworkScreen> createState() => _NetworkScreenState();
}

class _NetworkScreenState extends State<NetworkScreen> {
  static const int _initialPage = 2;
  int _actualPageNumber = _initialPage, _allPagesCount = 0;
  bool isSampleDoc = true;
  PdfControllerPinch? _pdfController;

  @override
  void initState() {
    super.initState();
    fetchFileFromInternet();
  }

  @override
  void dispose() {
    _pdfController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Load pdf from internet"),
      ),
      body: _pdfController == null
          ? Center(child: CircularProgressIndicator())
          : PdfViewPinch(
              controller: _pdfController!,
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

  void fetchFileFromInternet() async {
    var response =
        await get(Uri.parse("https://css4.pub/2015/icelandic/dictionary.pdf"));
    var bodyData = response.bodyBytes;
    _pdfController = PdfControllerPinch(
      document: PdfDocument.openData(bodyData),
      initialPage: _initialPage,
    );
    setState(() {});
  }
}
