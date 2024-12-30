class PostMealResponse {
  final bool success;
  final String? error;
  final PostMealData data;

  PostMealResponse({
    required this.success,
    this.error,
    required this.data,
  });

  factory PostMealResponse.fromJson(Map<String, dynamic> json) {
    return PostMealResponse(
      success: json['success'],
      error: json['error'],
      data: PostMealData.fromJson(json['data']),
    );
  }
}

class PostMealData {
  final bool isAdded;
  final String customerMealInputId;

  PostMealData({
    required this.isAdded,
    required this.customerMealInputId,
  });

  factory PostMealData.fromJson(Map<String, dynamic> json) {
    return PostMealData(
      isAdded: json['isAdded'],
      customerMealInputId: json['customerMealInputId'],
    );
  }
}
