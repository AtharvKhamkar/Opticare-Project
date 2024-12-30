import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vizzhy/src/features/appointments/models/appointment_model.dart';
import 'package:vizzhy/src/features/appointments/repository/appointments_repository.dart';

///AppointmentController is used to manage the state of the Appointment feature
class AppointmentsController extends GetxController with StateMixin<dynamic> {
  final _appointmentRepo = AppointmentsRepository();

  ///Loader to handle loading state of the appointment controller
  var isLoading = false.obs;

  ///variable to store flag of My Appointment
  var isMyAppointment = true.obs;

  ///variable to store the error message if some error occurs
  var errorMessage = ''.obs;

  ///variable to store page number
  var page = 1.obs;

  ///variable to store limit of the appointment per request
  var limit = 100.obs;

  ///variable to store flag is selected ot not
  var selectedIndex = 0.obs;

  ///List of upcoming appointments
  var upcomingAppointments = <Appointment>[].obs;

  ///List of campleted appointment
  var completedAppointments = <Appointment>[].obs;

  ///List of cancelled appointment
  var cancelledAppointments = <Appointment>[].obs;

  ///List of all appointment
  var allAppointments = <Appointment>[].obs;

  //filtered appointment list

  //new
  ///List of filtered upcoming appointments as per the query
  var filteredUpcomingAppointments = <Appointment>[].obs;

  ///List of filteredCompletedAppointments as per the query
  var filteredCompletedAppointments = <Appointment>[].obs;

  ///List of filteredCancelledAppointments as per the query
  var filteredCancelledAppointments = <Appointment>[].obs;

  ///List of filteredAllAppointments as per the query
  var filteredAllAppointments = <Appointment>[].obs;

  ///Text query which used while searching perticular appointment
  var searchQuery = ''.obs;

  @override
  void onInit() {
    fetchAppointments();
    ever(searchQuery, (_) => filteredAppointments(searchQuery.value));
    super.onInit();
  }

  /// Reset function to reset appointment controller to its initial value
  void reset() {
    completedAppointments.clear();
    cancelledAppointments.clear();
    completedAppointments.clear();
    cancelledAppointments.clear();
    upcomingAppointments.clear();
    allAppointments.clear();
    allAppointments.clear();
    isLoading(false);
    errorMessage('');
  }

  ///Functinon used to fetch all types of the appointments
  Future<void> fetchAppointments() async {
    reset();
    isLoading(true);

    final result =
        await _appointmentRepo.getAppointments(page.value, limit.value);
    // .then(
    //   (value) {
    debugPrint('$result');
    isLoading(false);
    if (result != null) {
      updateAppointments(result);
      filteredCompletedAppointments.assignAll(completedAppointments);
      filteredCancelledAppointments.assignAll(cancelledAppointments);
      filteredUpcomingAppointments.assignAll(upcomingAppointments);
      filteredAllAppointments.assignAll(allAppointments);
    }
    update();
    //   },
    //   onError: (e) {
    //     isLoading(false);
    //     ErrorHandle.error('$e');
    //     update();
    //   },
    // );

    //   },
    //   onError: (e) {
    //     isLoading(false);
    //     ErrorHandle.error('$e');
    //     update();
    //   },
    // );
  }

  ///Update default appointment list with the parsed appointment list according to the appointment time
  void updateAppointments(Map<String, dynamic> appointmentLists) {
    upcomingAppointments.value =
        _parseAppointments(appointmentLists['upcomingAppointments'])
            .reversed
            .toList();
    completedAppointments.value =
        _parseAppointments(appointmentLists['completedAppointments']);
    cancelledAppointments.value =
        _parseAppointments(appointmentLists['cancelledAppointments'])
            .reversed
            .toList();

    // Combine all appointments
    allAppointments
      ..clear()
      ..addAll(upcomingAppointments)
      ..addAll(completedAppointments)
      ..addAll(cancelledAppointments);

    // Combine all appointments
    allAppointments
      ..clear()
      ..addAll(upcomingAppointments)
      ..addAll(completedAppointments)
      ..addAll(cancelledAppointments);
  }

  ///function to parse appointments and sort to get latest appointments
  List<Appointment> _parseAppointments(List<dynamic> appointmentsJson) {
    final appointments =
        appointmentsJson.map((json) => Appointment.fromJson(json)).toList();
    appointments.sort((a, b) => b.fromDate.compareTo(a.fromDate));

    return appointments;
  }

  ///Function is used to toggle section between my appointment & new apponintment
  void toggleView() {
    isMyAppointment(!isMyAppointment.value);
    update();
  }

  ///Function used to handle search functionality in the appointment just need to pass query as an argument.
  void filteredAppointments(String query) {
    if (query == '') {
      filteredUpcomingAppointments.assignAll(upcomingAppointments);
      filteredCompletedAppointments.assignAll(completedAppointments);
      filteredCancelledAppointments.assignAll(cancelledAppointments);
      filteredAllAppointments.assignAll(allAppointments);
      filteredCompletedAppointments.assignAll(completedAppointments);
      filteredCancelledAppointments.assignAll(cancelledAppointments);
      filteredAllAppointments.assignAll(allAppointments);
    } else {
      ///filter Completed appointment
      filteredCompletedAppointments.assignAll(
        completedAppointments.where(
          (app) {
            return app.title.toLowerCase().contains(query.toLowerCase()) ||
                app.userName.toLowerCase().contains(query.toLowerCase());
          },
        ).toList(),
      );

      ///filter Cancelled appointments
      filteredCancelledAppointments.assignAll(
        cancelledAppointments.where(
          (app) {
            return app.title.toLowerCase().contains(query.toLowerCase()) ||
                app.userName.toLowerCase().contains(query.toLowerCase());
          },
        ).toList(),
      );

      ///filter upcoming appointments
      filteredUpcomingAppointments.assignAll(
        upcomingAppointments.where(
          (app) {
            return app.title.toLowerCase().contains(query.toLowerCase()) ||
                app.userName.toLowerCase().contains(query.toLowerCase());
          },
        ).toList(),
      );
      filteredAllAppointments.assignAll(
        allAppointments.where((app) {
          return app.title.toLowerCase().contains(query.toLowerCase()) ||
              app.userName.toLowerCase().contains(query.toLowerCase());
        }).toList(),
      );
      filteredAllAppointments.assignAll(
        allAppointments.where((app) {
          return app.title.toLowerCase().contains(query.toLowerCase()) ||
              app.userName.toLowerCase().contains(query.toLowerCase());
        }).toList(),
      );
    }
    update();
  }

  ///Function used to handle section in the appointment page updates section
  void updateSelectedIndex(int index) {
    selectedIndex(index);
    update();
  }
}

///Appointment binding used to initialize the controller before Appointmnet page
class AppointmentsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppointmentsController>(() => AppointmentsController(),
        fenix: true);
  }
}
