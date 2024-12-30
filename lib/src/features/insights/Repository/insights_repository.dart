import 'package:vizzhy/src/core/injection/injection.dart';
import 'package:vizzhy/src/data/remote/api_client.dart';
import 'package:vizzhy/src/features/conversation/presentation/services/error_handler.dart';
import 'package:vizzhy/src/features/insights/models/insights_model.dart';

///This Insights reporsitory used to handle network request related to Insights
class InsightsRepository {
  ///Call ApiClient class
  final apiClient = getIt<ApiClient>();

  ///Function used to make request to Insights Endpoint & parse according to the Insights Model.
  Future<List<Insight>?> getInsights(
      String customerId, String fromDate, String toDate, String page) async {
    try {
      Map<String, dynamic> queryParameters = {
        'fromDate': fromDate,
        'toDate': toDate,
        'page': 1
      };

      final response = await apiClient.getRequest(
          'carePlan/insights/customer/list/$customerId',
          additionalQueryParams: queryParameters,
          serverType: ServerTypes.careplan);
      final result = response.fold(
        (l) {
          ErrorHandle.error(l.message);
        },
        (r) {
          return r.data == null
              ? <Insight>[]
              : (r.data as List)
                  .map((insightJson) => Insight.fromJson(insightJson))
                  .toList();
        },
      );
      return result;
    } catch (e) {
      return Future.error(e);
    }
  }
}
