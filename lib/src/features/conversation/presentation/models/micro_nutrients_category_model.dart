import 'package:vizzhy/src/features/conversation/presentation/models/micro_nutrients_model.dart';

class MicronutrientsCategoryModel {
  final String categoryName;
  final Map<String, MicronutrientsModel> micronutrients;

  MicronutrientsCategoryModel({
    required this.categoryName,
    required this.micronutrients,
  });

  factory MicronutrientsCategoryModel.fromJson(
      String categoryName, Map<String, dynamic> json) {
    final micronutrients = json.map((key, value) {
      return MapEntry(
          key,
          MicronutrientsModel.fromJson({
            'micronutrients': key,
            ...value,
          }));
    });
    return MicronutrientsCategoryModel(
      categoryName: categoryName,
      micronutrients: micronutrients,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    micronutrients.forEach((key, value) {
      data[key] = value.toJson();
    });
    return {
      categoryName: data,
    };
  }
}
