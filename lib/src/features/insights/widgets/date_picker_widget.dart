// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:vizzhy/src/core/constants/Colors/app_colors.dart';

class DatePickerWidget extends StatelessWidget {
  final Function(DateTime) onDateSelected;

  const DatePickerWidget({
    super.key,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    DateTime? _tempSelectedDate;
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.grayTileColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: SfDateRangePicker(
        showActionButtons: true,
        view: DateRangePickerView.month,
        selectionColor: Colors.purple,
        todayHighlightColor: Colors.purple,
        backgroundColor: Colors.transparent,
        selectionShape: DateRangePickerSelectionShape.circle,
        showNavigationArrow: true,
        showTodayButton: true,
        navigationDirection: DateRangePickerNavigationDirection.horizontal,
        selectionTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        maxDate: DateTime.now(),
        monthViewSettings: const DateRangePickerMonthViewSettings(
          showTrailingAndLeadingDates: true,
          viewHeaderStyle: DateRangePickerViewHeaderStyle(
            backgroundColor: Colors.transparent,
            textStyle: TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          firstDayOfWeek: 1,
        ),
        headerStyle: const DateRangePickerHeaderStyle(
          backgroundColor: Colors.transparent,
          textAlign: TextAlign.left,
          textStyle: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.normal,
          ),
        ),
        monthCellStyle: const DateRangePickerMonthCellStyle(
          textStyle: TextStyle(color: Colors.white),
          todayTextStyle: TextStyle(color: Colors.white),
          leadingDatesTextStyle: TextStyle(color: Colors.grey),
          trailingDatesTextStyle: TextStyle(color: Colors.grey),
        ),
        yearCellStyle: const DateRangePickerYearCellStyle(
          textStyle: TextStyle(color: Colors.white),
          todayTextStyle: TextStyle(color: Colors.white),
        ),
        onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
          if (args.value is DateTime) {
            _tempSelectedDate = args.value;
          }
        },
        onCancel: () {
          Navigator.pop(context);
        },
        onSubmit: (Object? value) {
          if (_tempSelectedDate != null) {
            onDateSelected(_tempSelectedDate!);
          }
          Navigator.pop(context);
        },
      ),
    );
  }
}
