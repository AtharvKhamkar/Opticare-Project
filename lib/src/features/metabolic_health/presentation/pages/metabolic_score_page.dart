// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:vizzhy/src/core/constants/Colors/app_colors.dart';
import 'package:vizzhy/src/core/constants/fonts/text_styles.dart';
import 'package:vizzhy/src/features/metabolic_health/presentation/model/metabolic_model.dart';
import 'package:vizzhy/src/presentation/widgets/custom_app_bar.dart';
import 'package:vizzhy/src/features/metabolic_health/presentation/controller/metabolic_controller.dart';

class MetabolicScorePage extends StatelessWidget {
  const MetabolicScorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MetabolicController>(builder: (controller) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const CustomAppBar(title: "Metabolic Health Information"),
        body: Center(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              final height = constraints.maxHeight;
              return Stack(
                children: [
                  Image.asset(
                    'assets/images/profile/metabolic_health.jpg',
                    fit: BoxFit.cover,
                    width: width,
                    height: height,
                  ),
                  Positioned(
                    top: height * 0.04,
                    left: width * 0.5,
                    child: ScoreWidget(
                      scoreData: controller.brainScore.value,
                      assetPath: 'assets/images/profile/brain.svg',
                    ),
                  ),
                  Positioned(
                    top: height * 0.35,
                    left: width * 0.5,
                    child: ScoreWidget(
                      scoreData: controller.heartScore.value,
                      assetPath: 'assets/images/profile/heart.svg',
                    ),
                  ),
                  Positioned(
                    top: height * 0.41,
                    left: width * 0.4,
                    child: ScoreWidget(
                      scoreData: controller.liverScore.value,
                      assetPath: 'assets/images/profile/liver.svg',
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      );
    });
  }
}

class ScoreWidget extends StatelessWidget {
  final MetabolicScoreModel? scoreData;
  final String assetPath;

  const ScoreWidget({
    super.key,
    required this.scoreData,
    required this.assetPath,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) => SizedBox(
                  height: 200,
                  width: 300,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                    child: AlertDialog(
                      backgroundColor:
                          AppColors.grayAppointmentTileColor.withOpacity(0.1),
                      title: Text(
                        scoreData?.categoryName ?? 'No Category',
                        style: const TextStyle(color: Colors.white),
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Score  : ${scoreData?.score}',
                            style: const TextStyle(color: Colors.white),
                          ),
                          Text(
                            scoreData?.scoreRanges
                                    .map((e) => e.range)
                                    .join(',') ??
                                'No Data',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ));
      },
      child: Card(
        color: Colors.transparent,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.transparent.withOpacity(0.1),
                borderRadius: const BorderRadius.all(
                  Radius.circular(35),
                ),
                border: Border.all(width: 2, color: Colors.white),
              ),
              height: 35,
              width: 35,
              padding: const EdgeInsets.all(4),
              child: SvgPicture.asset(assetPath),
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              '${scoreData?.score ?? 0}',
              style: TextStyles.defaultText,
            )
          ],
        ),
      ),
    );
  }
}
