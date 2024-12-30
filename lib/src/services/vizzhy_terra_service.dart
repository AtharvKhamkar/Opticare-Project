import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:terra_flutter_bridge/models/enums.dart';
import 'package:terra_flutter_bridge/terra_flutter_bridge.dart';
import 'package:vizzhy/src/features/try_terra/list_of_subscription_model.dart';
import 'package:vizzhy/src/presentation/widgets/custom_toast_util.dart';
import 'package:vizzhy/src/data/models/cached_error_model.dart';
import 'package:vizzhy/src/services/http_service_vizzhy.dart';
import 'package:vizzhy/src/services/vizzhy_firebase_service.dart';

/// using terra_flutter_bridge package
/// this service class provide method calling of TERRA sdk
class VizzhyTerraServices {
  /// get ativity from terra health
  static void getActiity(
      Connection connection, DateTime startDate, DateTime endDate,
      {bool toWebhook = true}) {
    try {
      TerraFlutter.getActivity(connection, startDate, endDate,
              toWebhook: toWebhook)
          .then((result) {
        VizzhyFirebaseServices()
            .logDataToFirestore({"getActivity data ": result?.data});
      });
    } catch (e) {
      Logger().d("cannot fetched data of getActivity \n $e");
    }
  }

  ///  getAthlete from terra health
  static void getAthlete(Connection connection, {bool toWebhook = true}) {
    try {
      TerraFlutter.getAthlete(connection, toWebhook: toWebhook).then((result) {
        VizzhyFirebaseServices()
            .logDataToFirestore({"getAthlete data ": result?.data});
      });
    } catch (e) {
      Logger().d("cannot fetched data of getAthlete \n $e");
    }
  }

  /// getBodyData from terra health
  static void getBodyData(
      Connection connection, DateTime startDate, DateTime endDate,
      {bool toWebhook = true}) {
    try {
      TerraFlutter.getBody(connection, startDate, endDate, toWebhook: toWebhook)
          .then((result) {
        VizzhyFirebaseServices()
            .logDataToFirestore({"getBody data ": result?.data});
      });
    } catch (e) {
      Logger().d("cannot fetched data of getBodyData \n $e");
    }
  }

  /// getDaily data from terra health
  static void getDaily(
      Connection connection, DateTime startDate, DateTime endDate,
      {bool toWebhook = true}) {
    try {
      TerraFlutter.getDaily(connection, startDate, endDate,
              toWebhook: toWebhook)
          .then((result) {
        VizzhyFirebaseServices().logDataToFirestore(
            {'connection ': connection.name, 'getDaily data': result?.data});
        Logger().d(
            " fetched data of ${connection.name} getDaily \n ${result?.data}");
      });
    } catch (e) {
      Logger().d("cannot fetched data of getDaily \n $e");
    }
  }

  /// getMenstruation data from terra health
  static void getMenstruation(
      Connection connection, DateTime startDate, DateTime endDate,
      {bool toWebhook = true}) {
    try {
      TerraFlutter.getMenstruation(connection, startDate, endDate,
              toWebhook: toWebhook)
          .then((result) {
        VizzhyFirebaseServices()
            .logDataToFirestore({"getMenstruation data ": result?.data});
      });
    } catch (e) {
      Logger().d("cannot fetched data of getMenstruation \n $e");
    }
  }

  /// getNutrition from terra health
  static void getNutrition(
      Connection connection, DateTime startDate, DateTime endDate,
      {bool toWebhook = true}) {
    try {
      TerraFlutter.getNutrition(connection, startDate, endDate,
              toWebhook: toWebhook)
          .then((result) {
        VizzhyFirebaseServices()
            .logDataToFirestore({"getNutrition data ": result?.data});
      });
    } catch (e) {
      Logger().d("cannot fetched data of getNutrition \n $e");
    }
  }

  /// getSleep from terra health
  static void getSleep(
      Connection connection, DateTime startDate, DateTime endDate,
      {bool toWebhook = true}) {
    try {
      TerraFlutter.getSleep(connection, startDate, endDate,
              toWebhook: toWebhook)
          .then((result) {
        VizzhyFirebaseServices()
            .logDataToFirestore({"getSleep data ": result?.data});
      });
    } catch (e) {
      Logger().d("cannot fetched data of getSleep \n $e");
    }
  }

  /// getPlannedWorkouts from terra health
  static void getPlannedWorkouts(
    Connection connection,
  ) {
    try {
      TerraFlutter.getPlannedWorkouts(connection).then((result) {
        VizzhyFirebaseServices()
            .logDataToFirestore({"getPlannedWorkouts data ": result?.data});
      });
    } catch (e) {
      Logger().d("cannot fetched data of getPlannedWorkouts \n $e");
    }
  }

  /// get user info/details from terra server using userId i.e Connection ID
  /// here userID is connection id
  /// which we get from TERRA after successfull connection
  static void getUserInfoByUserId(String userID,
      {required String devId, required String apikey}) {
    try {
      if (userID.trim().isEmpty) {
        CustomToastUtil.showToast(
            message: 'UserId is empty, cant fetch health data');
        return;
      }
      final response =
          VizzhyHttpServices(baseUrl: 'https://api.tryterra.co').get(
        '/v2/userInfo?user_id=$userID',
        headers: {
          "accept": "application/json",
          "dev-id": devId,
          "x-api-key": apikey
        },
      );

      VizzhyFirebaseServices().logDataToFirestore(response);
    } catch (e) {
      Logger().d("cannot fetched data of getUserInfo \n $e");
    }
  }

  /// get app user info form Terra Server
  /// it return all connection which user has connected to TERRA
  /// here reference ID is CustomerID
  /// customer_id can get retrive from success login response
  static Future<List<TryTerraUser>?> getUserInfoByReferenceId(String refId,
      {required String devId, required String apikey}) async {
    try {
      if (refId.trim().isEmpty) {
        CustomToastUtil.showToast(
            message: 'RefID is empty, cant fetch health data');
      }
      final response =
          await VizzhyHttpServices(baseUrl: 'https://api.tryterra.co').get(
        '/v2/userInfo?reference_id=$refId',
        headers: {
          "accept": "application/json",
          "dev-id": devId,
          "x-api-key": apikey
        },
      );

      debugPrint("response of getuserInfo byrefID : $response");

      VizzhyFirebaseServices().logDataToFirestore(response);
      return TryTerraUserResponse.fromJson(response).users;
    } catch (e, s) {
      Logger().d("cannot fetched data of getUserInfo by refId \n $e");
      VizzhyFirebaseServices().logErrorToFirestore(CachedErrorModel(
          errorMessage: '$e', errorStack: '$s', timestamp: DateTime.now()));
    }
    return null;
  }

  /// return WebUrl of Terra session
  /// open url in web browser of the device
  /// in this session TERRA website will be open
  /// In this session user can connect or Disconnect to Health devies or APP
  static Future<Map<String, dynamic>?> getWidgetSessionUrl(
      {required String devId,
      required String apiKey,
      required List<String> connectionsList,
      required String refId}) async {
    /*
    success response
    {
  "expires_in": 900,
  "session_id": "cc0e1b75-34d2-43be-aff4-ba6c736f75c8",
  "status": "success",
  "url": "https://widget.tryterra.co/session/cc0e1b75-34d2-43be-aff4-ba6c736f75c8"
}
     */
    try {
      final payload = {
        "reference_id": refId,
        // "GARMIN,WITHINGS,FITBIT,GOOGLE,OURA,WAHOO,PELOTON,ZWIFT,TRAININGPEAKS,FREESTYLELIBRE,DEXCOM,COROS,HUAWEI,OMRON,RENPHO,POLAR,SUUNTO,EIGHT,APPLE,CONCEPT2,WHOOP,IFIT,TEMPO,CRONOMETER,FATSECRET,NUTRACHECK,UNDERARMOUR",
        "language": "en",
        'show_disconnect': true,
        'auth_success_redirect_url': 'https://vizzhy.in/success.html',
        'auth_failure_redirect_url': 'https://vizzhy.in/failed.html',
      };

      if (connectionsList.isNotEmpty) {
        payload.addAll({"providers": connectionsList.join(',')});
      }
      debugPrint("paylaod for getwidget session url : $payload");
      final response =
          await VizzhyHttpServices(baseUrl: 'https://api.tryterra.co')
              .post('/v2/auth/generateWidgetSession',
                  headers: {
                    "accept": "application/json",
                    "dev-id": devId,
                    "content-type": "application/json",
                    "x-api-key": apiKey
                  },
                  body: payload);

      if (response == null) {
        CustomToastUtil.showToast(
            message: 'Failed to create widget session',
            backgroundColor: Colors.red);
      }
      VizzhyFirebaseServices().logDataToFirestore(response);
      return response;
    } catch (e, s) {
      VizzhyFirebaseServices().logErrorToFirestore(CachedErrorModel(
          errorMessage: '$e', errorStack: '$s', timestamp: DateTime.now()));
      Logger().d("cannot fetched data of getUserInfo \n $e");
    }
    return null;
  }

  /// this function will return List of Names of Connection on Terra
  /// which is allowed to connect with Vizzhy
  /// on the Enviornment
  /// 'https://api.tryterra.co/v2/integrations/detailed?sdk=false'
  Future<List<String>> getListOfTerraConnectionNames({
    required String devId,
    required String apiKey,
  }) async {
    try {
      if (devId.trim().isEmpty || apiKey.trim().isEmpty) {
        debugPrint(
            "dev id or APi key is empty in getListOfTerraConnectionNames");
        CustomToastUtil.showToast(
            message:
                'Terra dev ID Or APikey is empty, cant fetch connections List');
        return [];
      }

      List<String> providers = [];
      final Map<String, dynamic>? response =
          await VizzhyHttpServices(baseUrl: 'https://api.tryterra.co').get(
        '/v2/integrations/detailed?sdk=false',
        headers: {
          "accept": "application/json",
          "dev-id": devId,
          "x-api-key": apiKey
        },
      );
      debugPrint("response of getListOfTerraConnectionNames : $response");
      if (response != null) {
        if (response['status'] == 'success' && response['providers'] != null) {
          providers.addAll((response['providers'] as List<dynamic>?)
                  ?.where((e) => e != null && e['provider'] != null)
                  .map((e) => e!['provider']) ??
              []);
        }
      }
      return providers;
    } catch (e, s) {
      Logger().d(
          "cannot fetched connection List of this enviornment from Terra \n $e");
      VizzhyFirebaseServices().logErrorToFirestore(CachedErrorModel(
          errorMessage: '$e', errorStack: '$s', timestamp: DateTime.now()));
      return [];
    }
  }
}
