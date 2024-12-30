import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vizzhy/src/features/metabolic_health/presentation/model/metabolic_model.dart';
import 'package:vizzhy/src/features/metabolic_health/repository/metabolic_repository.dart';

///MetabolicController is used to manage the state of the Metabolic Health feature
class MetabolicController extends GetxController with StateMixin<dynamic> {
  final _metabolicRepo = MetabolicRepository();

  ///Loader is used to handle loading state of the controller
  var isLoading = false.obs;

  ///Used to track error message in the controller
  var errorMessage = true.obs;

  ///variable used to store metabolic health score
  Rx<MetabolicScoreModel?> brainScore = MetabolicScoreModel.toEmpty().obs;

  ///variable used to store metabolic health score
  Rx<MetabolicScoreModel?> heartScore = MetabolicScoreModel.toEmpty().obs;

  ///variable used to store metabolic health score
  Rx<MetabolicScoreModel?> liverScore = MetabolicScoreModel.toEmpty().obs;

  ///variables used to hold MetabolicScoreModel
  var metabolicScoresList = <MetabolicScoreModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchMetabolicScore();
  }

  ///Function is used to fetch metabolic score
  Future<void> fetchMetabolicScore() async {
    metabolicScoresList.clear();
    if (isLoading.value) return;
    isLoading(true);
    update();

    final result = await _metabolicRepo.getMetabolicHealthScore();
    debugPrint('$result');

    isLoading(false);

    if (result != null && (result as List<MetabolicScoreModel>).isNotEmpty) {
      metabolicScoresList.value = result;
      heartScore.value = metabolicScoresList.length < 12
          ? MetabolicScoreModel.toEmpty()
          : metabolicScoresList[11];
      brainScore.value = metabolicScoresList.length < 8
          ? MetabolicScoreModel.toEmpty()
          : metabolicScoresList[7];
      liverScore.value = metabolicScoresList.length < 4
          ? MetabolicScoreModel.toEmpty()
          : metabolicScoresList[3];
    }
    update();
  }
}

///MetabolicScoreBindings used to initialize the controller before Metabolic Score Page
class MetabolicScoreBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MetabolicController>(() => MetabolicController(), fenix: true);
  }
}
