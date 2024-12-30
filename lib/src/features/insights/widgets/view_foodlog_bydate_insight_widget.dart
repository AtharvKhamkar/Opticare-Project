import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vizzhy/src/core/constants/constants.dart';
import 'package:vizzhy/src/features/conversation/presentation/controller/meal_input_controller.dart';
import 'package:vizzhy/src/features/insights/widgets/micro_macro_list_widget_bydate/macronutrients_list_widget.dart';
import 'package:vizzhy/src/features/insights/widgets/micro_macro_list_widget_bydate/micronutrients_list_widget.dart';
import 'package:vizzhy/src/presentation/widgets/custom_app_bar.dart';

///
/// Displays micro and macro nutrients by a particular date
class ViewFoodlogBydateInsightWidget extends StatefulWidget {
  /// Date should be in YYYY-MM-DD format
  final String date;

  ///
  const ViewFoodlogBydateInsightWidget({super.key, required this.date});

  @override
  State<ViewFoodlogBydateInsightWidget> createState() =>
      _ViewFoodlogBydateInsightWidgetState();
}

class _ViewFoodlogBydateInsightWidgetState
    extends State<ViewFoodlogBydateInsightWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final mealController = Get.find<MealInputController>();

  String get date => widget.date;

  void getMacroData() {
    debugPrint('Passed date to the fetchBigDetails is $date');
    mealController.fetchBigDetails(date: date);
  }

  void getMicroData() {
    mealController.fetchSmallDetails(date: date);
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
      appBar: const CustomAppBar(
        title: "Insights",
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              DateFormat(DateFormat.YEAR_MONTH_DAY)
                  .format(DateTime.parse(date)),
              style: TextStyles.TileText,
            ),
            const SizedBox(height: 10),
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
                  MacronutrientsListWidgetByDate(),
                  MicronutrientsListWidgetByDate(),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
              child: RangeColorWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

/// return list of widget stating legends for range
class RangeColorWidget extends StatelessWidget {
  /// range with color
  final List<Map<String, dynamic>> ranges = [
    {"name": "Sufficient", "color": const Color(0xFFFB923C)},
    {"name": "Insufficient", "color": const Color(0xFFF78486)},
    {"name": "Excellent", "color": const Color(0xFF26AC6B)},
    {"name": "Toxic", "color": const Color(0xFFED0004)},
    {"name": 'Alert/High', "color": const Color(0xFFED0004).withOpacity(0.7)},
  ];

  ///
  RangeColorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      // spacing: 12.0, // Horizontal spacing between elements
      // runSpacing: 8.0, // Vertical spacing between rows (when wrapped)
      // alignment: WrapAlignment.start,
      children: List.generate(
        ranges.length,
        (index) {
          final range = ranges[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Color indicator
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: range["color"],
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),

                // Range name
                Text(
                  range["name"],
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
