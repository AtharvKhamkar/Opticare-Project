import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vizzhy/src/core/constants/constants.dart';
import 'package:vizzhy/src/features/conversation/presentation/controller/meal_input_controller.dart';
import 'package:vizzhy/src/features/insights/widgets/food_log_box.dart';
import 'package:vizzhy/src/features/insights/widgets/micro_macro_list_widget_by_meal/macronutrients_list_widget.dart';
import 'package:vizzhy/src/features/insights/widgets/micro_macro_list_widget_by_meal/micronutrients_list_widget.dart';
import 'package:vizzhy/src/features/insights/widgets/view_foodlog_bydate_insight_widget.dart';
import 'package:vizzhy/src/presentation/widgets/custom_app_bar.dart';

///This screen is used to display single meal and micronutrients & macronutrients of the single meal
class MealInsightsScreen extends StatefulWidget {
  ///Passes Meal Name
  final String? text;

  ///Passed meal time
  final String time;

  ///Passed meal type
  final String mealType;

  ///passed meal quantity
  final String quantity;

  ///passed meal unit
  final String unit;

  ///passed meal calories
  final String calories;

  ///passed meal date
  final String mealDate;

  ///passed cmiDetailsId (Unique id for the meals)
  final String cmiDetailsId;

  ///Constructor of the MealInsightsScreen
  const MealInsightsScreen(
      {super.key,
      this.text,
      required this.time,
      required this.mealType,
      required this.quantity,
      required this.unit,
      required this.calories,
      required this.cmiDetailsId,
      required this.mealDate});

  @override
  State<MealInsightsScreen> createState() => _MealInsightsScreenState();
}

class _MealInsightsScreenState extends State<MealInsightsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final MealInputController controller = MealInputController().initialized
      ? Get.find()
      : Get.put(MealInputController());

  void getMacroData() {
    controller.fetchBigDetails(
        date: widget.mealDate, cmiDetailsId: widget.cmiDetailsId);
  }

  void getMicroData() {
    controller.fetchSmallDetails(
        date: widget.mealDate, cmiDetailsId: widget.cmiDetailsId);
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    Future.delayed(Durations.medium4, getMacroData);
    _tabController.addListener(() {
      if (_tabController.index == 0) {
        getMacroData();
      } else {
        getMicroData();
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackgroundColor,
      appBar: const CustomAppBar(title: 'Meal Insights'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Column(
          children: [
            FoodLogBox(
              text: widget.text,
              time: widget.time,
              mealType: widget.mealType,
              quantity: widget.quantity,
              unit: widget.unit,
              calories: widget.calories,
              cmiDetailsId: widget.cmiDetailsId,
              mealDate: widget.mealDate,
              mealController: controller,
            ),
            // Expanded(
            //   child: ListView(
            //     children: [
            //       Text(
            //         'Macronutrients',
            //         style: TextStyles.headLine5
            //             .copyWith(fontSize: 15, fontWeight: FontWeight.w600),
            //       ),
            //       const SizedBox(
            //         height: 20,
            //       ),
            //       Container(
            //         padding: const EdgeInsets.symmetric(vertical: 14),
            //         decoration: const BoxDecoration(
            //           color: AppColors.darkTileColor,
            //           borderRadius: BorderRadius.all(
            //             Radius.circular(10),
            //           ),
            //         ),
            //         child: FutureBuilder(
            //           future: controller.fetchMacroNutrientsByMeal(
            //               widget.mealDate, widget.cmiDetailsId),
            //           builder: (context, snapshot) {
            //             if (snapshot.connectionState ==
            //                 ConnectionState.waiting) {
            //               return const Center(
            //                 child: CircularProgressIndicator.adaptive(
            //                   backgroundColor: Colors.white,
            //                 ),
            //               );
            //             } else if (controller.macroNutrientsByMeal.isEmpty &&
            //                 !controller.isMacroLoader.value) {
            //               return const Center(
            //                 child: Text(
            //                   'No macronutrients data found',
            //                   style: TextStyles.defaultText,
            //                 ),
            //               );
            //             } else {
            //               return Obx(
            //                 () {
            //                   return ListView.builder(
            //                     itemCount:
            //                         controller.macroNutrientsByMeal.length,
            //                     shrinkWrap: true,
            //                     physics: const NeverScrollableScrollPhysics(),
            //                     padding: EdgeInsets.zero,
            //                     itemBuilder: (context, index) {
            //                       final nutrient =
            //                           controller.macroNutrientsByMeal[index];
            //                       return NutrientTile(
            //                         title: nutrient.macronutrientName,
            //                         value: nutrient.consumed,
            //                         goal: nutrient.goal,
            //                         color: getColorByRange(nutrient.range),
            //                         isLast: index ==
            //                             controller.macroNutrientsByMeal.length -
            //                                 1,
            //                       );
            //                     },
            //                   );
            //                 },
            //               );
            //             }
            //           },
            //         ),
            //       ),
            //       const SizedBox(
            //         height: 20,
            //       ),
            //       Text(
            //         'Micronutrients',
            //         style: TextStyles.headLine5
            //             .copyWith(fontSize: 15, fontWeight: FontWeight.w600),
            //       ),
            //       const SizedBox(
            //         height: 20,
            //       ),
            //       Container(
            //         padding: const EdgeInsets.symmetric(vertical: 14),
            //         decoration: const BoxDecoration(
            //           color: AppColors.darkTileColor,
            //           borderRadius: BorderRadius.all(
            //             Radius.circular(10),
            //           ),
            //         ),
            //         child: FutureBuilder(
            //           future: controller.fetchMicroNutrientsByMeal(
            //               widget.mealDate, widget.cmiDetailsId),
            //           builder: (context, snapshot) {
            //             if (snapshot.connectionState ==
            //                 ConnectionState.waiting) {
            //               return const Center(
            //                 child: CircularProgressIndicator.adaptive(
            //                   backgroundColor: Colors.white,
            //                 ),
            //               );
            //             } else if (controller.micronutrientsByMeal.isEmpty &&
            //                 !controller.isMicroLoader.value) {
            //               return const Center(
            //                 child: Text(
            //                   'No micronutrients data found',
            //                   style: TextStyles.defaultText,
            //                 ),
            //               );
            //             } else {
            //               return Obx(
            //                 () {
            //                   return ListView.builder(
            //                     itemCount:
            //                         controller.micronutrientsByMeal.length,
            //                     shrinkWrap: true,
            //                     physics: const NeverScrollableScrollPhysics(),
            //                     padding: EdgeInsets.zero,
            //                     itemBuilder: (context, index) {
            //                       final nutrient =
            //                           controller.micronutrientsByMeal[index];
            //                       return NutrientTile(
            //                         title: nutrient.micronutrientName
            //                             .toCapitalCase(),
            //                         value: nutrient.value,
            //                         goal: nutrient.goal,
            //                         color: getColorByRange(nutrient.range),
            //                         unit: nutrient.unit,
            //                         isLast: index ==
            //                             controller.micronutrientsByMeal.length -
            //                                 1,
            //                       );
            //                     },
            //                   );
            //                 },
            //               );
            //             }
            //           },
            //         ),
            //       ),
            //     ],
            //   ),
            // )
            TabBar(
              controller: _tabController,
              indicatorColor: AppColors.primaryColor,
              labelColor: AppColors.primaryColor,
              unselectedLabelColor: Colors.grey,
              isScrollable: false,
              tabs: const [
                Tab(text: 'Macronutrients'),
                Tab(text: 'Micronutrients'),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  MacronutrientsListWidgetByMeal(),
                  MicronutrientsListWidgetByMeal(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
              ),
              child: RangeColorWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
