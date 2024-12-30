// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vizzhy/src/core/constants/Colors/app_colors.dart';
import 'package:vizzhy/src/core/constants/fonts/text_styles.dart';
import 'package:vizzhy/src/features/appointments/models/appointment_model.dart';
import 'package:vizzhy/src/presentation/widgets/custom_button.dart';
import 'package:vizzhy/src/presentation/widgets/custom_toast_util.dart';
import 'package:vizzhy/src/presentation/widgets/zoom_web_view_page.dart';

///This widget is used to display information of the  single appointment.
class AppointmentInfoTile extends StatelessWidget {
  final String status;
  // final String doctorName;
  // final String appointmentFromDate;
  // final String appointmentToDate;
  // final String? meetingUrl;
  final bool canJoin;
  final bool disableJoinButton;
  final Appointment appointment;

  const AppointmentInfoTile(
      {super.key,
      required this.status,
      // required this.doctorName,
      // required this.appointmentFromDate,
      // required this.appointmentToDate,
      // required this.meetingUrl,
      required this.appointment,
      required this.canJoin,
      this.disableJoinButton = false});

  /// create a zoom web url
  /// with meet id and password
  /// launch in webview
  ///
  String getZoomWebUrl() {
    return 'https://zoom.us/wc/${appointment.meetingId}/join?prefer=1&un=${base64Encode(utf8.encode(appointment.customerName))}&pwd=${appointment.meetingPassword}';
  }

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = appointment.fromDate.toLocal();
    DateTime toTime = appointment.toDate.toLocal();

    //formatted date into MMM D, yy
    String formattedDate = DateFormat('EEEE, MMMM d').format(dateTime);

    //formatted time as 10:00 AM
    String formattedFromTime = DateFormat('h:mm a').format(dateTime);
    String formattedToTime = DateFormat('h:mm a').format(toTime);

    String doctorName = appointment.userName;

    // String meetingUrl = appointment.meetingUrl ?? '';

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.appointmentTileColor,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Dr. $doctorName', style: TextStyles.textFieldHintText2),
                  const Text('Nutritionist', style: TextStyles.headLine3)
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                    border: Border.all(color: AppColors.primaryColorLight)),
                child: Center(
                  child: Text(
                    status,
                    style: TextStyles.textFieldHintText2,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: Get.height * 0.01,
          ),
          const Divider(
            thickness: 0.15,
          ),
          SizedBox(
            height: Get.height * 0.025,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(6),
              ),
              color: AppColors.primaryColor.withOpacity(0.2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/profile/appointment.svg',
                        height: 20,
                        width: 20,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        formattedDate,
                        style: TextStyles.headLine4
                            .copyWith(fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/profile/time.svg',
                        height: 20,
                        width: 20,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      SizedBox(
                        width: Get.width * 0.25,
                        child: Text(
                          '$formattedFromTime - $formattedToTime',
                          style: TextStyles.headLine4
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: Get.height * 0.03,
          ),
          canJoin
              ? CustomFormButton(
                  innerText: 'Join',
                  onPressed: () {
                    if (disableJoinButton && canJoin) {
                      String zoomweburl = getZoomWebUrl();

                      Get.to(
                        ZoomWebViewPage(
                            meetingUrl: zoomweburl,
                            meetTitle: appointment.title),
                      );
                    } else {
                      CustomToastUtil.showToast(
                          message:
                              'This meeting will active 5 minutes before.');
                    }
                  },
                  height: Get.height * 0.045,
                  verticalPadding: 5,
                  borderRadius: 20,
                  borderColor: disableJoinButton
                      ? AppColors.primaryColor
                      : AppColors.grayAppointmentTileColor,
                  backgroundColor: disableJoinButton
                      ? AppColors.primaryColor
                      : AppColors.grayAppointmentTileColor)
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}
