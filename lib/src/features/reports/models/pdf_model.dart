// ignore_for_file: public_member_api_docs

///PdfModel to handle & check single appointment response
class PdfModel {
  final String customerLabReportId;
  final String reportName;
  final String reportType;
  final String reportUrl;
  final String status;

  PdfModel({
    required this.customerLabReportId,
    required this.reportName,
    required this.reportType,
    required this.reportUrl,
    required this.status,
  });

  factory PdfModel.fromJson(Map<String, dynamic> json) {
    return PdfModel(
      customerLabReportId: json['customerLabReportId'] ?? '',
      reportName: json['reportName'] ?? '',
      reportType: json['reportType'] ?? '',
      reportUrl: json['reportUrl'] ?? '',
      status: json['status'] ?? '',
    );
  }
}
