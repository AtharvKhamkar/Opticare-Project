class UpdateMealModel {
  String? foodName;
  String? cmiDetailsId;

  UpdateMealModel({this.foodName, this.cmiDetailsId});

  @override
  String toString() {
    return 'UpdateMealModel(foodName: $foodName, cmiDetailsId: $cmiDetailsId)';
  }

  factory UpdateMealModel.fromJson(Map<String, dynamic> json) {
    return UpdateMealModel(
      foodName: json['foodName'] as String?,
      cmiDetailsId: json['cmiDetailsId'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'foodName': foodName,
        'cmiDetailsId': cmiDetailsId,
      };
}
