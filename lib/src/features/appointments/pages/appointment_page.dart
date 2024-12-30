import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vizzhy/src/core/constants/Colors/app_colors.dart';
import 'package:vizzhy/src/core/constants/fonts/text_styles.dart';
import 'package:vizzhy/src/features/appointments/controllers/appointments_controller.dart';
import 'package:vizzhy/src/features/appointments/models/appointment_model.dart';
import 'package:vizzhy/src/features/appointments/widgets/appointment_info_tile.dart';
import 'package:vizzhy/src/presentation/widgets/custom_app_bar.dart';
import 'package:vizzhy/src/presentation/widgets/custom_confirmation_dialog.dart';
import 'package:vizzhy/src/presentation/widgets/custom_toggle_button.dart';
import 'package:vizzhy/src/utils/app_util.dart';

///This is a appointment main page
class AppointmentsPage extends StatefulWidget {
  ///Constructor of the Appointment page
  const AppointmentsPage({super.key});

  @override
  State<AppointmentsPage> createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage> {
  ///
  final bool isAppointmentValue = true;

  @override
  void initState() {
    super.initState();
    requestAudioVideoPermission();
  }

  Future<void> requestAudioVideoPermission() async {
    if (!(await Permission.audio.isGranted)) {
      await Permission.microphone.request();
    } else if (await Permission.audio.isPermanentlyDenied) {
      Get.dialog(CustomConfirmationDialog(
          message:
              'Audio Permission denied permanently\n we recommand allowing permission \n for smooth expeirence',
          onConfirm: () {
            openAppSettings(); // Open app settings to grant permission
            Get.back();
          }));
    } else {
      debugPrint("permission audio granted");
    }
    if (!(await Permission.camera.isGranted)) {
      await Permission.camera.request();
    } else if (await Permission.camera.isPermanentlyDenied) {
      Get.dialog(CustomConfirmationDialog(
          message:
              'Camera Permission denied permanently\n we recommand allowing permission \n for smooth expeirence',
          onConfirm: () {
            openAppSettings(); // Open app settings to grant permission
            Get.back();
          }));
    } else {
      debugPrint("permission camera granted");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackgroundColor,
      appBar: const CustomAppBar(title: "Appointments"),
      body: GetBuilder<AppointmentsController>(
        builder: (controller) {
          return controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator.adaptive(
                    backgroundColor: Colors.white,
                  ),
                )
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: Get.height * 0.04,
                        child: TextField(
                          style: TextStyles.headLine3,
                          textAlignVertical: TextAlignVertical.center,
                          onChanged: (value) =>
                              controller.searchQuery.value = value,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.appointmentTileColor,
                            prefixIcon: const Icon(Icons.search),
                            hintText: 'Search',
                            hintStyle: TextStyles.headLine3,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none),
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 4),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            CustomToggleButton(
                              label: 'All',
                              isSelected: controller.selectedIndex.value == 0,
                              onTap: () => controller.updateSelectedIndex(0),
                            ),
                            CustomToggleButton(
                              label: 'Upcoming',
                              isSelected: controller.selectedIndex.value == 1,
                              onTap: () => controller.updateSelectedIndex(1),
                            ),
                            CustomToggleButton(
                                label: 'Completed',
                                isSelected: controller.selectedIndex.value == 2,
                                onTap: () => controller.updateSelectedIndex(2)),
                            CustomToggleButton(
                                label: 'Cancelled',
                                isSelected: controller.selectedIndex.value == 3,
                                onTap: () => controller.updateSelectedIndex(3)),
                          ],
                        ),
                      ),
                      SizedBox(height: Get.height * 0.02),
                      Expanded(
                        child: Obx(
                          () {
                            if (controller.selectedIndex.value == 0) {
                              return AllAppointmentSection(
                                  controller: controller);
                            } else if (controller.selectedIndex.value == 1) {
                              return UpcomingAppointmentSection(
                                  controller: controller);
                            } else if (controller.selectedIndex.value == 2) {
                              return completedAppointmentSection(
                                controller: controller,
                              );
                            } else if (controller.selectedIndex.value == 3) {
                              return cancelledAppointmentSection(
                                  controller: controller);
                            } else {
                              return const SizedBox();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}

///This is class that represent All appointment section
class AllAppointmentSection extends StatelessWidget {
  ///Need to pass AppointmentController
  final AppointmentsController controller;

  ///Constructor of the Allappointment section
  const AllAppointmentSection({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    bool canJoinMeeting(
        {required String fromDateString, required DateTime toDateTime}) {
      //parse fromDateString to the UTC
      final fromDateUtc = DateTime.parse(fromDateString).toUtc();

      //Convert fromDateUtc to local time
      final fromDateLocal = fromDateUtc.toLocal();

      final now = DateTime.now();

      final fiveMinutesBefore =
          fromDateLocal.subtract(const Duration(minutes: 5));

      return now.isAfter(fiveMinutesBefore) &&
          now.isBefore(toDateTime.toLocal());
    }

    return Obx(
      () {
        if (controller.filteredAllAppointments.isEmpty) {
          return SizedBox(
            height: Get.height * 0.5,
            child: const Center(
              child: Text(
                'No appointment scheduled',
                style: TextStyles.headLine2,
              ),
            ),
          );
        } else {
          return RefreshIndicator(
            onRefresh: () async {
              await controller.fetchAppointments();
            },
            child: ListView.builder(
              itemCount: controller.filteredAllAppointments.length,
              itemBuilder: (context, index) {
                Appointment appointment =
                    controller.filteredAllAppointments[index];
                bool isDisableJoinButton = canJoinMeeting(
                    toDateTime: appointment.toDate,
                    fromDateString: appointment.fromDate.toString());
                String statusText;
                if (appointment.isReschedule &&
                    appointment.status == 'ACTIVE') {
                  statusText = 'Rescheduled';
                } else if (appointment.status == 'ACTIVE') {
                  statusText = 'Upcoming';
                } else if (appointment.status == 'COMPLETED') {
                  statusText = 'Completed';
                } else if (appointment.status == 'DELETE') {
                  statusText = 'Cancelled';
                } else {
                  statusText = '    '; // Fallback for unhandled statuses
                }
                return AppointmentInfoTile(
                  canJoin: appointment.status == 'ACTIVE' ? true : false,
                  disableJoinButton: isDisableJoinButton,
                  // doctorName: appointment.userName,
                  // appointmentFromDate: appointment.fromDate.toString(),
                  // appointmentToDate: appointment.toDate.toString(),
                  // meetingUrl: appointment.meetingUrl,
                  appointment: appointment,
                  status: statusText,
                );
              },
            ),
          );
        }
      },
    );
  }
}

///This is class that represent All appointment section
class UpcomingAppointmentSection extends StatelessWidget {
  ///Need to pass appointment controller
  final AppointmentsController controller;

  ///constructor of the upcoming appointment
  const UpcomingAppointmentSection({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    bool canJoinMeeting(
        {required DateTime toDate, required String fromDateString}) {
      //parse fromDateString to the UTC
      final fromDateUtc = DateTime.parse(fromDateString).toUtc();

      //Convert fromDateUtc to local time
      final fromDateLocal = fromDateUtc.toLocal();

      final now = DateTime.now();

      final tenMinutesBefore =
          fromDateLocal.subtract(const Duration(minutes: 5));

      return now.isAfter(tenMinutesBefore) && now.isBefore(toDate.toLocal());
    }

    return Obx(
      () {
        if (controller.filteredUpcomingAppointments.isEmpty) {
          return SizedBox(
            height: Get.height * 0.5,
            child: const Center(
              child: Text(
                'No appointment scheduled',
                style: TextStyles.headLine2,
              ),
            ),
          );
        } else {
          return RefreshIndicator(
            onRefresh: () async {
              controller.fetchAppointments();
            },
            child: ListView.builder(
              itemCount: controller.upcomingAppointments.length,
              itemBuilder: (context, index) {
                Appointment appointment =
                    controller.upcomingAppointments[index];
                bool isDisableJoinButton = canJoinMeeting(
                    toDate: appointment.toDate,
                    fromDateString: appointment.fromDate.toString());

                String statusText;
                if (appointment.isReschedule &&
                    appointment.status == 'ACTIVE') {
                  statusText = 'Rescheduled';
                } else {
                  statusText = 'Upcoming';
                }
                return AppointmentInfoTile(
                  canJoin: true,
                  disableJoinButton: isDisableJoinButton,
                  appointment: appointment,
                  status: statusText,
                );
              },
            ),
          );
        }
      },
    );
  }
}

///This is class that represent All appointment section
// ignore: camel_case_types
class completedAppointmentSection extends StatelessWidget {
  ///Need to pass appointmentcontroller
  final AppointmentsController controller;

  ///Constructor for the completedAppointmentSection
  const completedAppointmentSection({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.filteredCompletedAppointments.isEmpty) {
          return SizedBox(
            height: Get.height * 0.3,
            child: const Center(
              child: Text(
                'No completed appointments',
                style: TextStyles.headLine2,
              ),
            ),
          );
        } else {
          return RefreshIndicator(
            onRefresh: () async {
              controller.fetchAppointments();
            },
            child: ListView.builder(
              itemCount: controller.filteredCompletedAppointments.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                Appointment appointment =
                    controller.filteredCompletedAppointments[index];
                return AppointmentInfoTile(
                  canJoin: false,
                  appointment: appointment,
                  status: AppUtil.capitalizeFirstLetter(appointment.status) ??
                      appointment.status.toLowerCase(),
                );
              },
            ),
          );
        }
      },
    );
  }
}

///This is class that represent All appointment section
// ignore: camel_case_types
class cancelledAppointmentSection extends StatelessWidget {
  ///Need to pass appointment controller
  final AppointmentsController controller;

  ///Constructor of the cancelledAppointmentSection
  const cancelledAppointmentSection({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.filteredCancelledAppointments.isEmpty) {
          return const Center(
            child: Text(
              'No cancelled appointment',
              style: TextStyles.headLine2,
            ),
          );
        } else {
          return RefreshIndicator(
            onRefresh: () async {
              controller.fetchAppointments();
            },
            child: ListView.builder(
              itemCount: controller.filteredCancelledAppointments.length,
              itemBuilder: (context, index) {
                Appointment appointment =
                    controller.filteredCancelledAppointments[index];
                return AppointmentInfoTile(
                    canJoin: false,
                    appointment: appointment,
                    status: appointment.status == 'DELETE' ? 'Cancelled' : ' ');
              },
            ),
          );
        }
      },
    );
  }
}
