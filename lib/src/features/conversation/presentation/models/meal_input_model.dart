class MealInput {
  final String customerMealInputId;
  final String mealInput;
  final String timeZone;
  final String addedBy;
  final DateTime createdAt;

  MealInput({
    required this.customerMealInputId,
    required this.mealInput,
    required this.timeZone,
    required this.addedBy,
    required this.createdAt,
  });

  factory MealInput.fromJson(Map<String, dynamic> json) {
    return MealInput(
      customerMealInputId: json['customerMealInputId'],
      mealInput: json['mealInput'],
      timeZone: json['timeZone'],
      addedBy: json['addedBy'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
