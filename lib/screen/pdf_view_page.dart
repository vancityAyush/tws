import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFViewPage extends StatelessWidget {
  final String title, path;
  const PDFViewPage({this.title, this.path}) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0XFF2CB3BF),
        centerTitle: true,
        title: Text(
          title,
          style: TextStyle(
              fontSize: 22 * MediaQuery.of(context).textScaleFactor,
              color: Colors.white),
        ),
      ),
      body: SfPdfViewer.asset(path),
    );
  }
}
