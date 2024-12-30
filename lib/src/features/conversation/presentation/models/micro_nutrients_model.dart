class MicronutrientsModel {
  final String micronutrientName;
  final String unit;
  final double? value;
  final double goal;
  final double percentage;
  final String range;

  MicronutrientsModel({
    required this.micronutrientName,
    required this.unit,
    this.value,
    required this.goal,
    required this.percentage,
    required this.range,
  });

  factory MicronutrientsModel.fromJson(Map<String, dynamic> json) {
    return MicronutrientsModel(
        micronutrientName: json['micronutrients'] as String,
        unit: json['unit'] as String? ?? '',
        value: (json['value'] as num?)?.toDouble() ?? 0,
        goal: (json['goal'] as num?)?.toDouble() ?? 0,
        percentage: (json['percentage'] as num?)?.toDouble() ?? 0,
        range: json['range'] as String? ?? '');
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['unit'] = unit;
    data['value'] = value;
    data['goal'] = goal;
    data['percentage'] = percentage;
    data['range'] = range;
    return data;
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

  // Computed property to format `value`
  String get formattedValue => value?.toStringAsFixed(2) ?? '0.00';

  // Computed property to format `goal`
  String get formattedGoal => goal == 0 ? '-' : _formatNumber(goal);

  // Computed property to format `percentage`
  String get formattedPercentage => percentage.toStringAsFixed(2);
}

class MineralsAndTraceElementsModel {
  Map<String, MicronutrientsModel>? micronutrients;

  MineralsAndTraceElementsModel({this.micronutrients});

  MineralsAndTraceElementsModel.fromJson(Map<String, dynamic> json) {
    micronutrients = {};
    json.forEach((key, value) {
      micronutrients![key] = MicronutrientsModel.fromJson(value);
    });
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    micronutrients?.forEach((key, value) {
      data[key] = value.toJson();
    });
    return data;
  }
}
