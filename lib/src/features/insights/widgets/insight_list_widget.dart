// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:vizzhy/src/core/constants/fonts/text_styles.dart';
import 'package:vizzhy/src/features/insights/models/insights_model.dart';
import 'package:vizzhy/src/features/insights/widgets/insight_tile.dart';

class InsightListWidget extends StatelessWidget {
  final bool isLoading;
  final List<Insight> insights;

  const InsightListWidget({
    super.key,
    required this.isLoading,
    required this.insights,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
          child: CircularProgressIndicator.adaptive(
        backgroundColor: Colors.white,
      ));
    }

    if (insights.isEmpty) {
      return const Center(
        child: Text(
          "No insights available for now",
          style: TextStyles.headLine2,
        ),
      );
    }
    return ListView.builder(
      itemCount: insights.length,
      itemBuilder: (context, index) {
        final insight = insights[index];
        return InsightTile(
          title: insight.title,
          insightDetails: insight.insights,
        );
      },
    );
  }
}
