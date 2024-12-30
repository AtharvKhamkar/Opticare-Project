import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';
import 'package:vizzhy/src/core/injection/injection.dart';
import 'package:vizzhy/src/data/models/cached_error_model.dart';
import 'package:vizzhy/src/presentation/widgets/custom_toast_util.dart';
import 'package:vizzhy/src/services/vizzhy_firebase_service.dart';
import 'package:vizzhy/src/utils/failure.dart';

import '../../../data/remote/api_client.dart';

class IotRepository {
  final Logger _logger = Logger();
  final apiClient = getIt<ApiClient>();

  Future<Either<Failure, Unit>> postCGMData(Map<String, dynamic> data) async {
    try {
      final response = await apiClient
          .postRequest('analytics/cgm/addCgmData',
              request: data, serverType: ServerTypes.iot)
          .onError((err, s) {
        CustomToastUtil.showToast(
            message: 'Failed to record cgm data on server',
            backgroundColor: Colors.red);
        VizzhyFirebaseServices().logErrorToFirestore(CachedErrorModel(
            errorMessage: '$err', errorStack: '$s', timestamp: DateTime.now()));

        return Left(Failure(message: err.toString()));
      });
      VizzhyFirebaseServices().logDataToFirestore(
          {'responseData': response, 'timestamp': DateTime.now()});
      return const Right(unit);
    } catch (e, s) {
      _logger.e(e, stackTrace: s);
      return Left(Failure(message: e.toString()));
    }
  }
}
