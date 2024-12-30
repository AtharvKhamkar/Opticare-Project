class ApiResponseModel {
  final bool? success;
  final ApiErrorModel? error;
  final dynamic data;

  ApiResponseModel({
    this.success,
    this.error,
    this.data,
  });

  // Factory constructor to create an instance from JSON
  factory ApiResponseModel.fromJson(Map<String, dynamic> json) {
    return ApiResponseModel(
      success: json['success'] as bool? ?? false,
      error:
          ApiErrorModel.fromJson(json['error'] as Map<String, dynamic>? ?? {}),
      data: json['data'],
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'error': error,
      'data': data,
    };
  }

  @override
  String toString() {
    return 'ApiResponseModel(success: $success, error: $error, data: $data)';
  }
}

class ApiErrorModel {
  int? code;
  String? message;

  ApiErrorModel({
    this.code,
    this.message,
  });

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) => ApiErrorModel(
        code: json["code"],
        message: json["message"] ?? "",
      );

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
    };
  }

  @override
  String toString() {
    return 'Code : $code ,Error Message : $message';
  }
}
