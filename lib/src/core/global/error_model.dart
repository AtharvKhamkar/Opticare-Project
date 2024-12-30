// ignore_for_file: public_member_api_docs
///This is generic class model to handle any failure response of the API
class ErrorModel {
  int code;
  String message;

  ErrorModel({
    required this.code,
    required this.message,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
        code: json["code"],
        message: json["message"] ?? "",
      );

  @override
  String toString() {
    return message;
  }
}
