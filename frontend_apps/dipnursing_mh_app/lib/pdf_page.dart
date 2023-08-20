import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';


String url = 'https://school-app-images.s3.eu-north-1.amazonaws.com/static/';

class PdfViewerPage extends StatefulWidget {
  final String filePath;
  final String fileName;
  const PdfViewerPage({super.key,required this.filePath,required this.fileName});
  
  @override
  // ignore: library_private_types_in_public_api
  _PdfViewerPageState createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        title: Text(widget.fileName),
      ),
      body: SfPdfViewer.network(url+widget.filePath)
    );
  }
}
