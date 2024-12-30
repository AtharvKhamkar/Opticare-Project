class MacronutrientModel {
  final String
      macronutrientName; // Changed to lower camel case for naming conventions
  final double? consumed;
  final double goal;
  final double percentage;
  final String range;

  MacronutrientModel({
    required this.macronutrientName,
    this.consumed,
    required this.goal,
    required this.percentage,
    required this.range,
  });

  factory MacronutrientModel.fromJson(Map<String, dynamic> json) {
    return MacronutrientModel(
      macronutrientName: json['macronutrients'] as String? ?? '',
      consumed: (json['consumed'] as num?)?.toDouble() ?? 0,
      goal: (json['goal'] as num?)?.toDouble() ?? 0,
      percentage: (json['percentage'] as num?)?.toDouble() ?? 0,
      range: json['range'] as String? ?? '',
    );
  }

  String _formatNumber(double number) {
    if (number == number.toInt()) {
      // If the number is a whole number, show it as an integer
      return number.toInt().toString();
    } else {
      // Otherwise, round to 2 decimal places
      return number.toStringAsFixed(2);
    }
  }

  // Computed property to return formatted consumed value
  String get formattedConsumed => consumed?.toStringAsFixed(2) ?? '0.00';

  // Computed property to return formatted goal value
  String get formattedGoal => goal == 0 ? '-' : _formatNumber(goal);

  // Computed property to return formatted percentage value
  String get formattedPercentage => percentage.toStringAsFixed(2);
}

class MacronutrientModelData {
  final List<MacronutrientModel> macronutrientModels;

  MacronutrientModelData({
    required this.macronutrientModels,
  });

  factory MacronutrientModelData.fromJson(Map<String, dynamic> json) {
    return MacronutrientModelData(
      macronutrientModels: (json['macronutrients'] as List<dynamic>?)
              ?.map((item) =>
                  MacronutrientModel.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
