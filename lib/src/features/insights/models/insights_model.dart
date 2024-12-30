///Modal class for type checking single Insight response.
class Insight {
  ///Unique Insight Id
  final String carePlanInsightId;

  ///title of the insight
  final String title;

  ///main content of the insight
  final String insights;

  ///date on which insight is approved
  final DateTime date;

  ///Constructor of the insight
  Insight({
    required this.carePlanInsightId,
    required this.title,
    required this.insights,
    required this.date,
  });

  ///Factory function
  factory Insight.fromJson(Map<String, dynamic> json) {
    return Insight(
      carePlanInsightId: json['carePlanInsightId'],
      title: json['title'],
      insights: json['insights'],
      date: DateTime.parse(json['date']),
    );
  }
}
