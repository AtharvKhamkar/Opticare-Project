import 'package:flutter/material.dart';
import 'package:vizzhy/src/core/injection/injection.dart';
import 'package:vizzhy/src/data/remote/api_client.dart';
import 'package:vizzhy/src/features/conversation/presentation/services/error_handler.dart';

///This is a AppointmentRepository class used to handle all network request related to the appoointment feature
class AppointmentsRepository {
  ///Instance of the apiClient
  final apiClient = getIt<ApiClient>();

  ///Function that handles API request to get all types of appointment need to pass page and limit
  Future<dynamic> getAppointments(int page, int limit) async {
    final query = {'page': page.toString(), 'limit': limit.toString()};
    try {
      final response = await apiClient.getRequest('book/customer/appointment',
          additionalQueryParams: query, serverType: ServerTypes.appointment);

      // return response;
      final result = response.fold((l) {
        ErrorHandle.error(l.message);
        return null;
      }, (r) {
        return r.data;
      });
      return result;
    } catch (e) {
      debugPrint('Got error while fetching appointments');
      debugPrint(e.toString());
      return Future.error(e);
    }
  }
}
