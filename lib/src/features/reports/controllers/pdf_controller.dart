import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vizzhy/src/data/local_storage/app_storage.dart';

// import 'package:vizzhy/src/core/global/error_model.dart';
import 'package:vizzhy/src/utils/app_util.dart';
import 'package:vizzhy/src/presentation/widgets/custom_toast_util.dart';
import 'package:vizzhy/src/features/conversation/presentation/services/error_handler.dart';
import 'package:vizzhy/src/features/reports/Repository/reports_repository.dart';
import 'package:vizzhy/src/features/reports/pages/image_viewer_page.dart';
import 'package:vizzhy/src/features/reports/pages/pdf_viewer_page.dart';

import '../models/pdf_model.dart';

///PdfController is used to manage the state of the Reports Upload feature
class PdfController extends GetxController with StateMixin<dynamic> {
  final _pdfRepo = ReportsRepository();

  ///List of vizzhyReports(Internal Reports)
  var vizzhyReports = <PdfModel>[].obs;

  ///List of the external Reports
  var externalReports = <PdfModel>[].obs;

  ///variable used to track vizzhy reports or not
  var isVizzhyReports = true.obs;

  ///Loader to handle loading state of the PdfController
  var isLoading = false.obs;

  ///variable to store the error message if some error occurs
  var errorMessage = ''.obs;

  ///Variable used to store userId from the GetStorage
  var userId = AppStorage.getUserId();

  ///Variable used to store index of sections(Vizzhy or External)
  var selectedIndex = 0.obs;

  ///Function used to fetch vizzhy repors & external reports
  Future<void> fetchReports() async {
    if (isLoading.value) return;
    isLoading(true);
    errorMessage('');
    update();

    final value = await _pdfRepo.getVizzhyReports(userId);
    // .then((value) {
    if (value != null) {
      vizzhyReports(value);
    }
    update();

    final result = await _pdfRepo.getExternalReports();
    // .then((value) {
    if (result != null) {
      externalReports(result);
    }
    update();

    isLoading(false);
  }

  ///Function used to download reports need to pass reports url & file name.
  Future<void> downloadPdf(String url, String fileName) async {
    final dio = Dio();

    try {
      final response = await dio.get<List<int>>(
        url,
        options: Options(responseType: ResponseType.bytes),
      );

      if (response.statusCode == 200) {
        final directory = await getDownloadDirectory();
        if (directory != null) {
          final filePath =
              await saveFile(directory, fileName, response.data!, url);
          showDownloadSuccess(filePath);
        } else {
          // final model = Failure.fromJson(value['error']);
          ErrorHandle.error('Download Directory not found');
        }
      }
    } catch (e) {
      ErrorHandle.error('$e');
    }
  }

  ///Function is used to view reports in an app, need to pass reports url & filename
  Future<void> previewPdf(String url, String fileName) async {
    String fileExtension = url.split('.').last.toLowerCase();

    switch (fileExtension) {
      case 'pdf':
        openPdfViewer(url, fileName);
        break;
      case 'jpg':
      case 'jpeg':
      case 'png':
        openImageViewer(url, fileName);
        break;
      default:
        showUnsupportedFileError();
    }
  }

  ///Function is used to upload reports as a external reports
  Future<void> uploadPdf() async {
    if (isLoading.value) return;
    isLoading(true);
    errorMessage('');
    update();

    final pickedFile = await AppUtil()
        .chooseFile(type: FileType.custom, allowedExtensions: ['pdf']);
    debugPrint('Log from controller function $pickedFile?.path');

    if (pickedFile != null) {
      try {
        final uploadResponse = await _pdfRepo.uploadReports(pickedFile.path);
        if (uploadResponse['success']) {
          CustomToastUtil.showToast(
              message: 'Report Uploaded Successfully',
              prefixIcon: Icons.check,
              textColor: Colors.black,
              borderColor: Colors.green,
              backgroundColor: Colors.greenAccent);
          final fetchResponse = await _pdfRepo.getExternalReports();
          if (fetchResponse != null) {
            externalReports(fetchResponse);
          }
        }
        update();
      } finally {
        isLoading(false);
        update();
      }
    } else {
      ErrorHandle.error('No file was picked');
      update();
      isLoading(false);
    }
  }

  ///Util functions for download and preview reports
  Future<Directory?> getDownloadDirectory() async {
    if (Platform.isAndroid) {
      return Directory('/storage/emulated/0/Download');
    } else if (Platform.isIOS) {
      return getApplicationDocumentsDirectory();
    } else {
      return getApplicationDocumentsDirectory();
    }
  }

  ///Util function to save downloaded file locally & return downloaded file path
  Future<String> saveFile(
      Directory directory, String fileName, List<int> bytes, String url) async {
    debugPrint(fileName);
    final nameWithoutExtension = fileName.split('.').first;
    debugPrint(nameWithoutExtension);
    final extension = url.split('.').last;
    debugPrint(extension);
    String newFileName = '$nameWithoutExtension.$extension';
    File file = File('${directory.path}/$newFileName');
    int fileCounter = 0;

    while (file.existsSync()) {
      fileCounter == 0
          ? newFileName = '$nameWithoutExtension.$extension'
          : newFileName = '$nameWithoutExtension($fileCounter).$extension';

      file = File('${directory.path}/$newFileName');
      fileCounter++;
    }

    await file.writeAsBytes(bytes);
    return file.path;
  }

  ///Function that represent downloading snackbar & directory path in which the file is being saved
  void showDownloadSuccess(String filePath) {
    Get.snackbar('Downloading...', 'saved in $filePath');
  }

  ///Function redirect to PdfViewerPage for previewing PDF
  void openPdfViewer(String url, String fileName) {
    Get.to(() => PdfViewerPage(url: url, fileName: fileName));
  }

  ///Function redirect to ImageViewerPage for previewing image
  void openImageViewer(String url, String fileName) {
    Get.to(() => ImageViewerPage(fileName: fileName, url: url));
  }

  ///function represents upsupoorted file error if user tries to upload file rather than .pdf file
  void showUnsupportedFileError() {
    Get.snackbar(
        'Unsupported file', 'This file type is not supported for preview.');
  }

  ///function is used to toggle section between vizzhy & external reports
  void toggleView() {
    isVizzhyReports(!isVizzhyReports.value);
    update();
  }

  ///function used to update selected selction
  void updateSelectedIndex(int index) {
    selectedIndex(index);
    update();
  }
}

///Pdfbinding used to initialize the controller before Reports page
class PdfBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PdfController>(() => PdfController(), fenix: true);
  }
}
