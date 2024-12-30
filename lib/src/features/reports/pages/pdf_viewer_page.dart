// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:vizzhy/src/core/constants/Colors/app_colors.dart';
import 'package:vizzhy/src/presentation/widgets/custom_app_bar.dart';

///Page is used to view any reports on full screen.
class PdfViewerPage extends StatelessWidget {
  final String url;
  final String fileName;
  const PdfViewerPage({
    super.key,
    required this.url,
    required this.fileName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackgroundColor,
      appBar: CustomAppBar(title: fileName),
      body: SfPdfViewer.network(url),
    );
  }
}
