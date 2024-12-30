// ignore_for_file: public_member_api_docs

///MetabolicScoreModel is used to parse metabolic score response
class MetabolicScoreModel {
  final String categoryId;
  final String categoryName;
  final int totalFeedbackValue;
  final int totalQuestions;
  final String scoreLogic;
  final double score;
  final String range;
  final List<ScoreRange> scoreRanges;
  final DateTime lastModifiedOn;

  MetabolicScoreModel({
    required this.categoryId,
    required this.categoryName,
    required this.totalFeedbackValue,
    required this.totalQuestions,
    required this.scoreLogic,
    required this.score,
    required this.range,
    required this.scoreRanges,
    required this.lastModifiedOn,
  });

  factory MetabolicScoreModel.fromJson(Map<String, dynamic> json) {
    return MetabolicScoreModel(
      categoryId: json['categoryId'] ?? '',
      categoryName: json['categoryName'] ?? '',
      totalFeedbackValue: json['totalFeedbackValue'] ?? 0,
      totalQuestions: json['totalQuestions'] ?? 0,
      scoreLogic: json['scoreLogic'] ?? '',
      score: json['score'].toDouble(),
      range: json['range'] ?? '',
      scoreRanges: (json['scoreRanges'] as List)
          .map((item) => ScoreRange.fromJson(item))
          .toList(),
      lastModifiedOn: DateTime.parse(json['lastModifiedOn'] ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'categoryName': categoryName,
      'totalFeedbackValue': totalFeedbackValue,
      'totalQuestions': totalQuestions,
      'scoreLogic': scoreLogic,
      'score': score,
      'range': range,
      'scoreRanges': scoreRanges.map((item) => item.toJson()).toList(),
      'lastModifiedOn': lastModifiedOn.toIso8601String(),
    };
  }

  // Method to create an empty instance
  static MetabolicScoreModel toEmpty() {
    return MetabolicScoreModel(
      categoryId: '',
      categoryName: '',
      totalFeedbackValue: 0,
      totalQuestions: 0,
      scoreLogic: '',
      score: 0.0,
      range: '',
      scoreRanges: [],
      lastModifiedOn: DateTime.now(),
    );
  }

  // Method to check if the model is empty
  bool isEmpty() {
    return categoryId.isEmpty &&
        categoryName.isEmpty &&
        totalFeedbackValue == 0 &&
        totalQuestions == 0 &&
        scoreLogic.isEmpty &&
        score == 0.0 &&
        range.isEmpty &&
        scoreRanges.isEmpty &&
        lastModifiedOn.isBefore(
            DateTime.now().subtract(const Duration(days: 1))); // Example check
  }
}

class ScoreRange {
  final double max;
  final double min;
  final String range;

  ScoreRange({
    required this.max,
    required this.min,
    required this.range,
  });

  factory ScoreRange.fromJson(Map<String, dynamic> json) {
    return ScoreRange(
      max: json['max'].toDouble(),
      min: json['min'].toDouble(),
      range: json['range'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'max': max,
      'min': min,
      'range': range,
    };
  }
}
