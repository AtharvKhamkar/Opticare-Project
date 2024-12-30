// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vizzhy/src/core/constants/Colors/app_colors.dart';
import 'package:vizzhy/src/core/constants/fonts/text_styles.dart';

///This widget is used to display single past appointment
class PastAppointmentTile extends StatelessWidget {
  final String doctorName;
  final String appointmentDate;

  const PastAppointmentTile({
    super.key,
    required this.doctorName,
    required this.appointmentDate,
  });

  @override
  Widget build(BuildContext context) {
    String titleDateText = getTitleDateText(appointmentDate);

    DateTime dateTime = DateTime.parse(appointmentDate).toLocal();

    //formatted date into MMM D, yy
    String formattedDate = DateFormat('MMM d, y').format(dateTime);
    //formatted time as 10:00 AM
    String formattedTime = DateFormat('h:mm a').format(dateTime);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titleDateText,
          style: TextStyles.textFieldHintText,
        ),
        Container(
          decoration: const BoxDecoration(
            color: AppColors.appointmentTileColor,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          margin: const EdgeInsets.symmetric(vertical: 15),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dr.${doctorName.split(' ').first}',
                        style: TextStyles.textFieldHintText,
                      ),
                      const Text('Nutritionist',
                          style: TextStyles.textFieldHintText)
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(formattedDate, style: TextStyles.textFieldHintText),
                      Text(formattedTime, style: TextStyles.textFieldHintText)
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

//Utility function to get date as a title of tile

String getTitleDateText(String appointmentDate) {
  DateTime dateTime = DateTime.parse(appointmentDate);

  //formatted date as 'd MMMM y'
  String tileTitleDate = DateFormat('d MMMM y').format(dateTime);

  //Get today's date and yesturday's date
  DateTime today = DateTime.now();
  DateTime yesturday = today.subtract(
    const Duration(days: 1),
  );

  //deternmine the title date(Today, yesturday, or the actual date)
  if (isSameDate(dateTime, today)) {
    return 'Today';
  } else if (isSameDate(dateTime, yesturday)) {
    return 'Yesturday';
  } else {
    return tileTitleDate;
  }
}

bool isSameDate(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}
