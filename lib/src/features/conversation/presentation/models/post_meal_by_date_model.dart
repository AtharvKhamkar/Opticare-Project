class PostMealByDateModel {
  bool? isAdded;
  List<InsertedId>? insertedIds;

  PostMealByDateModel({this.isAdded, this.insertedIds});

  @override
  String toString() {
    return 'PostMealByDateModel(isAdded: $isAdded, insertedIds: $insertedIds)';
  }

  factory PostMealByDateModel.fromJson(Map<String, dynamic> json) {
    return PostMealByDateModel(
      isAdded: json['isAdded'] as bool?,
      insertedIds: (json['insertedIds'] as List<dynamic>?)
          ?.map((e) => InsertedId.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'isAdded': isAdded,
        'insertedIds': insertedIds?.map((e) => e.toJson()).toList(),
      };
}

class InsertedId {
  String? foodName;
  String? cmiDetailsId;

  InsertedId({this.foodName, this.cmiDetailsId});

  @override
  String toString() {
    return 'InsertedId(foodName: $foodName, cmiDetailsId: $cmiDetailsId)';
  }

  factory InsertedId.fromJson(Map<String, dynamic> json) => InsertedId(
        foodName: json['foodName'] as String?,
        cmiDetailsId: json['cmiDetailsId'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'foodName': foodName,
        'cmiDetailsId': cmiDetailsId,
      };
}
