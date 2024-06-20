import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:pdfx/pdfx.dart';

class AssetsPdfScreen extends StatefulWidget {
  const AssetsPdfScreen({super.key});

  @override
  State<AssetsPdfScreen> createState() => _AssetsPdfScreenState();
}

class _AssetsPdfScreenState extends State<AssetsPdfScreen> {
  static const int _initialPage = 1;
  late PdfController _pdfController;

  @override
  void initState() {
    _pdfController = PdfController(
      document: PdfDocument.openAsset('assets/demo.pdf'),
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
        title: const Text("Load pdf from assets"),
      ),
      body: PdfView(
        scrollDirection: Axis.vertical,
        builders: PdfViewBuilders<DefaultBuilderOptions>(
          options: const DefaultBuilderOptions(),
          documentLoaderBuilder: (_) =>
              const Center(child: CircularProgressIndicator()),
          pageLoaderBuilder: (_) =>
              const Center(child: CircularProgressIndicator()),
          pageBuilder: _pageBuilder,
        ),
        controller: _pdfController,
      ),
    );
  }
}

PhotoViewGalleryPageOptions _pageBuilder(
  BuildContext context,
  Future<PdfPageImage> pageImage,
  int index,
  PdfDocument document,
) {
  return PhotoViewGalleryPageOptions(
    imageProvider: PdfPageImageProvider(
      pageImage,
      index,
      document.id,
    ),
    minScale: PhotoViewComputedScale.contained * 1,
    maxScale: PhotoViewComputedScale.contained * 2,
    initialScale: PhotoViewComputedScale.contained * 1.0,
    heroAttributes: PhotoViewHeroAttributes(tag: '${document.id}-$index'),
  );
}
