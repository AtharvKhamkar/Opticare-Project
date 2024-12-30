import 'package:flutter/material.dart';
import 'package:vizzhy/src/core/injection/injection.dart';
import 'package:vizzhy/src/data/remote/api_client.dart';
import 'package:vizzhy/src/features/conversation/presentation/services/error_handler.dart';
import 'package:vizzhy/src/features/metabolic_health/presentation/model/metabolic_model.dart';

///This is a MetabolicRepository class used to handle all network request related to the metabolic health feature

class MetabolicRepository {
  ///Instance of the ApiClient class
  final apiClient = getIt<ApiClient>();

  ///This function is used to handle API request to get metabolic score of the user
  Future<dynamic> getMetabolicHealthScore() async {
    try {
      final response = await apiClient.getRequest('metabolic/health/score',
          serverType: ServerTypes.customer);

      // return response;
      final result = response.fold((l) {
        ErrorHandle.error(l.message);
        return null;
      }, (r) {
        return r.data == null
            ? <MetabolicScoreModel>[]
            : (r.data['metabolicHealthScore']?[0]?['healthScore'] as List?)
                    ?.map(
                      (metaboliJson) => MetabolicScoreModel.fromJson(
                          (metaboliJson as Map<String, dynamic>?) ?? {}),
                    )
                    .toList() ??
                [];
      });
      return result;
    } catch (e) {
      debugPrint('Got error while fetching metabolic health');
      debugPrint(e.toString());
      return Future.error(e);
    }
  }
}
