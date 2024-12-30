import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vizzhy/src/data/local_storage/app_storage.dart';
import 'package:vizzhy/src/features/insights/Repository/insights_repository.dart';

import "../models/insights_model.dart";

///This InsightsController used to handle Insights state.
class InsightsController extends GetxController with StateMixin<dynamic> {
  final _insightRepo = InsightsRepository();

  ///selected date on calender
  var selectedDate = DateTime.now().obs;

  ///Array to hold Insights
  var insights = <Insight>[].obs;

  ///Loader for insights
  var isLoading = false.obs;

  ///To check care plan selected or not
  var isCarePlan = true.obs;

  ///Variable to store any error while API calls
  var errorMessage = ''.obs;

  ///Page need to be passed to API
  var page = 1.obs;

  ///Get userId from AppStorage
  var userId = AppStorage.getUserId();

  ///Track which section is selected on History Page
  var selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchInsights(selectedDate.value);
  }

  ///Funtion used to fetch insights per day need to pass day as an argument
  Future<void> fetchInsights(DateTime date) async {
    insights.clear();
    if (isLoading.value) return;
    errorMessage('');
    isLoading(true);
    update();

    String formattedTime = DateFormat('yyyy-MM-dd').format(date);

    final result = await _insightRepo.getInsights(
        userId, formattedTime, formattedTime, page.toString());
    isLoading(false);
    if (result != null) {
      insights.value = result;
    }
    update();
    isLoading(false);
  }

  ///Function used to update selected date & after selecting date insights of that day are fetched
  void updateSelectedDate(DateTime date) {
    selectedDate(date);
    fetchInsights(date);
  }

  ///Function used to handle toggle functionality between the section.
  void updateSelectedIndex(int index) {
    selectedIndex(index);
    update();
  }

  ///Function used to check is care plan is selected or not
  void toggleView() {
    isCarePlan(!isCarePlan.value);
    update();
  }
}

///Binding class used to initialize controller before loading History page
class InsightsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InsightsController>(() => InsightsController(), fenix: true);
  }
}
