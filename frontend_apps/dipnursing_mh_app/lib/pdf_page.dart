import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';


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
  bool _isDownloading = false; // Track the downloading state

  void _startDownload() async {
    // Implement your download logic here
    // For example, you can use the 'http' package to download the PDF file
    setState(() {
      _isDownloading = true;
    });

    // Download logic here...

    setState(() {
      _isDownloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.fileName),
      ),
      body: Stack(
        children: [
          const PDF(
            enableSwipe: true,
            swipeHorizontal: true,
            autoSpacing: false,
            pageFling: false,
          ).cachedFromUrl(
            url + widget.filePath,
            maxAgeCacheObject: const Duration(minutes:30),
            placeholder: (progress) => Center(child: Text('$progress %')),
            errorWidget: (error) => Center(child: Text(error.toString())),
          ),
          // ---------- showcase download button ~show reward add before download ----------------
          // Align(
          //     alignment: Alignment.bottomRight,
          //     child: Padding(
          //     padding: const EdgeInsets.all(16.0),
          //     child: ElevatedButton.icon(
          //       onPressed: _isDownloading ? null : _startDownload,
          //       icon: _isDownloading
          //           ? const CircularProgressIndicator() // Show loading indicator if downloading
          //           : const Icon(Icons.download), // Download icon
          //       label: const Text('Download'), // Empty label
          //       style: ElevatedButton.styleFrom(
          //         padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
