import 'package:flutter/material.dart';
import 'package:vizzhy/src/core/injection/injection.dart';
import 'package:vizzhy/src/data/remote/api_client.dart';
import 'package:vizzhy/src/features/conversation/presentation/services/error_handler.dart';
import 'package:vizzhy/src/features/reports/models/pdf_model.dart';
import 'package:vizzhy/src/utils/failure.dart';

///This is a ReportsRepository class used to handle all network request related to the reports feature

class ReportsRepository {
  ///Instance of the ApiClient
  final apiClient = getIt<ApiClient>();

  ///Function that handles API request to get vizzhy reports need to customerId as an argument
  Future<List<PdfModel>?> getVizzhyReports(String customerId) async {
    try {
      final response = await apiClient.getRequest(
          'reports/admin/internal/report/details/$customerId',
          serverType: ServerTypes.reports);
      return response.fold((l) {
        ErrorHandle.error(l.message);
        return null;
      }, (r) {
        final reports = (r.data as List)
            .map((e) => PdfModel.fromJson(e))
            .toList()
            .reversed
            .toList();

        return reports;
      });
    } catch (e) {
      ErrorHandle.error(VizzhySomethingWentWrongFailure());
      debugPrint("error caught in getVizzhy reports :$e");
      return null;
    }
  }

  ///Function that handles API request to get external reports.
  Future<List<PdfModel>?> getExternalReports() async {
    try {
      final response = await apiClient.getRequest(
          'reports/customer/external/report/details',
          serverType: ServerTypes.reports);
      return response.fold((l) {
        ErrorHandle.error(l.message);
        return null;
      }, (r) {
        final reports = (r.data as List)
            .map((e) => PdfModel.fromJson(e))
            .toList()
            .reversed
            .toList();

        return reports;
      });
    } catch (e) {
      ErrorHandle.error(VizzhySomethingWentWrongFailure());
      debugPrint("error caught in get external reports : $e");
      return null;
    }
  }

  ///Function that handles API request to upload external reports.
  Future<dynamic> uploadReports(dynamic byte) async {
    debugPrint(byte.runtimeType.toString());
    debugPrint(byte.runtimeType.toString());
    try {
      Map<String, String> file = {
        "file": byte,
      };

      final response = await apiClient.multipartRequest(
          'reports/customer/external/report/upload',
          files: file,
          serverType: ServerTypes.reports);
      return response;
    } catch (e) {
      return Future.error(e);
    }
  }
}
