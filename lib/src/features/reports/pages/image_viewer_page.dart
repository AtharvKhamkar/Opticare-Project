// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:vizzhy/src/core/constants/Colors/app_colors.dart';
import 'package:vizzhy/src/presentation/widgets/custom_app_bar.dart';

///Page is used to display Png or jpg reports file
class ImageViewerPage extends StatelessWidget {
  final String fileName;
  final String url;
  const ImageViewerPage({
    super.key,
    required this.fileName,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackgroundColor,
      appBar: CustomAppBar(title: fileName),
      body: Center(
        child: Image.network(
          url,
          fit: BoxFit.contain,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}
