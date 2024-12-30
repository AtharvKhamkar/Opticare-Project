import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:terra_flutter_bridge/models/enums.dart';
import 'package:terra_flutter_bridge/terra_flutter_bridge.dart';
import 'package:vizzhy/src/core/constants/constants.dart';
import 'package:vizzhy/src/data/local_storage/app_storage.dart';
import 'package:vizzhy/src/presentation/widgets/custom_toast_util.dart';
import 'package:vizzhy/src/data/models/cached_error_model.dart';
import 'package:vizzhy/src/features/try_terra/list_of_subscription_model.dart';
import 'package:vizzhy/src/features/try_terra/repository/iot_repository.dart';
import 'package:vizzhy/src/services/http_service_vizzhy.dart';
import 'package:vizzhy/src/services/vizzhy_firebase_service.dart';
import 'package:vizzhy/src/services/vizzhy_terra_service.dart';

import '../../../../../flavors.dart';

/// class to use TerraSDk in flutter
class TryTerraController extends GetxController {
  //to print log
  final Logger _logger = Logger();
  // to call apis
  final Dio _dio = Dio();

  /// to get the list of subscription of user
  Map<String, String?> connections = {};

  /// show loading on the page
  bool isLoading = false;
  final IotRepository _iotRepository = IotRepository();

  /// it will show toggle on/Off on screen for APPLE
  var isAppleHealthConnected = false.obs;

  /// it will show toggle on/Off on screen
  var isSamsungHealthConnected = false.obs;

  /// fetch confidential TERRA ID from .env files
  final terraDevId = (F.appFlavor == Flavor.prod)
      ? EnvFileVariableNames.terraProdId
      : (F.appFlavor == Flavor.stag)
          ? EnvFileVariableNames.terraStagId
          : EnvFileVariableNames.terraDevId;

  /// fetch confidential TERRA ApiKey from .env files
  final terraApiKey = (F.appFlavor == Flavor.prod)
      ? EnvFileVariableNames.terraProdApiKey
      : (F.appFlavor == Flavor.stag)
          ? EnvFileVariableNames.terraStagApiKey
          : EnvFileVariableNames.terraDevApiKey;

  TextEditingController idTextEditingController = TextEditingController();

  /// store logs of events ans how in error log page
  var logsList = [].obs;

  /// assign customer id
  /// when given to  init function from UI
  late final String vizzhyCustomerId;

  /// this function should called before page is loaded and when controller is initializing
  Future<void> init(String customerId) async {
    try {
      // logsList.clear();
      vizzhyCustomerId = customerId;
      isLoading = true;
      update();

      await TerraFlutter.initTerra(
        terraDevId,
        customerId,
      );

      // get active users on trytera
      if (F.appFlavor != Flavor.prod) {
        getListOfUsersFromtryTerra().then((users) {
          if (users != null && users.length >= 55) {
            if (users.isNotEmpty) {
              deAuthUserFromtryTerra(userID: users.last.userId);
            }
          }
        });
      }
      checkAppleAndSamsungAndGetData();

      isLoading = false;
      update();
    } catch (e) {
      debugPrint("error in terra controler : $e");
    }
  }

  void checkAppleAndSamsungAndGetData() async {
    // get user id from local storage
    final customerId = AppStorage.getUserId();
    // fetch connected connection for this user
    List<TryTerraUser>? thisConsumerTerraConnectionsList =
        await getListOfConnectionOfThisCustomer();

    if (thisConsumerTerraConnectionsList != null) {
      // toggle button ON/OFF depending on user data connection availble or not in Terra servere
      checkApple(thisConsumerTerraConnectionsList, refId: customerId);
      checkSamsung(thisConsumerTerraConnectionsList, refId: customerId);
    }
  }

  /// get List Of Connection Of This Customer
  Future<List<TryTerraUser>?> getListOfConnectionOfThisCustomer() async {
    return await VizzhyTerraServices.getUserInfoByReferenceId(vizzhyCustomerId,
        devId: terraDevId, apikey: terraApiKey);
  }

  /// this function will  fetch data if connection is already exists
  ///  and turn on toggle button for APPLE Health
  void checkApple(List<TryTerraUser> users, {required String refId}) {
    TryTerraUser? appleData = users.firstWhereOrNull(
        (userProviderList) => userProviderList.provider == 'APPLE');
    if (appleData != null) {
      isAppleHealthConnected(true);
      update();
      fetchAllData(Connection.appleHealth.name, refId: refId);
    }
  }

  /// this function will  fetch data if connection is already exists
  ///  and turn on toggle button for Samsung Health
  void checkSamsung(List<TryTerraUser> users, {required String refId}) {
    TryTerraUser? appleData = users.firstWhereOrNull(
        (userProviderList) => userProviderList.provider == 'SAMSUNG');
    if (appleData != null) {
      isSamsungHealthConnected(true);
      update();
      fetchAllData(Connection.samsung.name, refId: refId);
    }
  }

  /// to fetch Connection ID of TerraDashboard
  Future<String?> getUserId(Connection conn) async {
    return (await TerraFlutter.getUserId(conn))?.userId;
  }

  /// this function should be called when user want to disconnect Connection from Terra
  Future<void> deAuthUserConnectionFromTryTerra(
      {required Connection connection, required String customerId}) async {
    final userInfo = await VizzhyTerraServices.getUserInfoByReferenceId(
        customerId,
        devId: terraDevId,
        apikey: terraApiKey);
    TryTerraUser? user;
    if (userInfo != null && userInfo.isNotEmpty) {
      user = userInfo.firstWhereOrNull((data) =>
          connection.name.toLowerCase().contains(data.provider.toLowerCase()));
    }
    final val = await deAuthUserFromtryTerra(userID: user?.userId ?? '');
    if (val) {
      if (connection.name.toLowerCase().contains('apple')) {
        isAppleHealthConnected(false);
      }
      if (connection.name.toLowerCase().contains('samsung')) {
        isSamsungHealthConnected(false);
      }
      CustomToastUtil.showToast(
          message: 'Disconnected ${connection.name} Successfully',
          prefixIcon: Icons.check,
          textColor: Colors.black,
          borderColor: Colors.green,
          backgroundColor: Colors.greenAccent);
    } else {
      CustomToastUtil.showToast(
          message: 'unable to Disconnect with  ${connection.name} ',
          prefixIcon: Icons.error_outline,
          textColor: Colors.black,
          borderColor: Colors.red,
          backgroundColor: Colors.redAccent);
    }
    update();
  }

  /// call Terra api to disconnect user Connections
  Future<bool> deAuthUserFromtryTerra(
      {Connection? connection, String userID = ''}) async {
    try {
      final userId = connection != null
          ? (await TerraFlutter.getUserId(connection))?.userId ?? ''
          : userID;
      if (userId.trim().isNotEmpty) {
        debugPrint("user id before deauthing connection :--$userId--");
        final res =
            await VizzhyHttpServices(baseUrl: 'https://api.tryterra.co').delete(
          '/v2/auth/deauthenticateUser?user_id=$userId',
          headers: {
            "accept": "application/json",
            "dev-id": terraDevId,
            "x-api-key": terraApiKey,
          },
        );

        if (res == null) {
          return false;
        }
        debugPrint("result of deauth user in deAuthUserFromtryTerra :$res");
        return true;
      } else {
        CustomToastUtil.showToast(message: 'UserId is Empty,Please Try later!');
        return false;
      }
    } catch (e, s) {
      debugPrint("Error while deauthing userconnection :$e");
      VizzhyFirebaseServices().logErrorToFirestore(CachedErrorModel(
          errorMessage: '$e', errorStack: '$s', timestamp: DateTime.now()));
      return false;
    }
  }

  /// get All Subscribed Connection List from Terra Server
  Future<List<TryTerraUser>?> getListOfUsersFromtryTerra() async {
    try {
      final res = await VizzhyHttpServices(baseUrl: 'https://api.tryterra.co')
          .get('/v2/subscriptions', headers: {
        "accept": "application/json",
        "dev-id": terraDevId,
        "x-api-key": terraApiKey,
      });

      if (res == null) {
        return null;
      }

      final result = TryTerraUserResponse.fromJson(res);
      debugPrint(',model conv succ : total user : ${result.users.length} ');

      // Count occurrences of each referenceId
      Map<String, int> referenceIdCounts = {};

      for (var user in result.users) {
        referenceIdCounts[user.referenceId] =
            (referenceIdCounts[user.referenceId] ?? 0) + 1;
      }

      // Convert to list of maps for easier visualization
      List<Map<String, dynamic>> value = referenceIdCounts.entries
          .map((entry) => {'referenceId': entry.key, 'count': entry.value})
          .toList();

      // if(value.isEmpty){
      //   return null;
      // }

      // debugPrint("we got url : $url");
      // Print the result
      debugPrint(
          'count of user with same ref id : total ref :${value.length} $value');
      // VizzhyFirebaseServices().logErrorToFirestore(CachedErrorModel(
      //     errorMessage: 'No error',
      //     errorStack: 'data : ${result.users.map((e) => e.toJson())}',
      //     timestamp: DateTime.now()));
      debugPrint("result of connected users  :$res");
      return result.users;
    } catch (e, s) {
      debugPrint("error in list of users in tryterra : $e , $s");
    }
    return null;
  }

  /// make connection thorugh sdk
  Future<void> initializeConnecton(
      BuildContext context, Connection connection, String customerId) async {
    try {
      debugPrint(
          "Calling init connection with tryterra for : ${connection.name}");

      // final totalconnectionByThisUsers =
      //     await getListOfConnectionOfThisCustomer();
      // // if user have already connected with 2 device
      // // then dont allow for further connection
      // if (totalconnectionByThisUsers != null &&
      //     totalconnectionByThisUsers.length > 1) {
      //   Get.dialog(CustomConfirmationDialog(
      //       message:
      //           'You have already reached your Limit\n Kinldy disconnect other devices.\n or Contact Vizzhy Customer Support',
      //       onConfirm: () {
      //         Get.back();
      //       }));

      //   return;
      // }
      String? token = await generateAuthToken();

      if (token == null) {
        CustomToastUtil.showToast(message: 'Please Try later!');
        return;
      }

      // get active users on trytera
      if (F.appFlavor != Flavor.prod) {
        final users = await getListOfUsersFromtryTerra();
        if (users != null && users.length >= 55) {
          if (users.isNotEmpty) {
            await deAuthUserFromtryTerra(userID: users.last.userId);
          }
        }
      }
// initialize Terra SDK with Flutter App
      final initMessage =
          await TerraFlutter.initConnection(connection, token, true, []);

      debugPrint(
          'tryterra init conn response  => success : ${initMessage?.success} , err : ${initMessage?.error}');

      // Delete in Production
      logsList.add({
        'name': 'TryTerra initConnection',
        'ConnectionName': connection.name,
        'success': initMessage?.success ?? false,
        'error': initMessage?.error ?? 'No Error',
        'timeStamp_in_UTC': DateTime.now().toUtc().toIso8601String()
      });

      debugPrint('connection.name : ${connection.name}');

      final String userId = (await getUserId(connection)) ?? '';

      logsList.add({
        'name': ' in initializeConnecton func in controller',
        'ConnectionName': connection.name,
        'success': userId.isEmpty ? false : true,
        userId.isEmpty ? 'error' : 'data': 'userId : $userId',
        'timeStamp_in_UTC': DateTime.now().toUtc().toIso8601String()
      });

      debugPrint("got user id after connection : -->$userId<--}");

      if (userId.isNotEmpty) {
        if (connection.name.toLowerCase().contains('apple')) {
          isAppleHealthConnected(true);
        }
        if (connection.name.toLowerCase().contains('samsung')) {
          isSamsungHealthConnected(true);
        }
        update();
      }

      if (userId.isNotEmpty && initMessage?.success == true) {
        CustomToastUtil.showToast(
          message: "Connection Successful",
          prefixIcon: Icons.check,
          textColor: Colors.black,
          borderColor: Colors.green,
          backgroundColor: Colors.greenAccent,
        );
      } else {
        CustomToastUtil.showToast(message: initMessage?.error);
      }
    } catch (err) {
      debugPrint('Error in try-terra controller initConn : $err');
      logsList.add({
        'name': 'cached error in initializeConnecton func in controller',
        'ConnectionName': connection.name,
        'success': false,
        'error': 'Error : $err',
        'timeStamp_in_UTC': DateTime.now().toUtc().toIso8601String()
      });
      CustomToastUtil.showFailureToast(
          message: 'something went wrong while initializing Terra');
    }
  }

  /// scan CGM data via NFC
  /// using Terra SDK
  Future<void> getCGMData(String customerId) async {
    await TerraFlutter.initTerra(terraDevId, customerId);

    final message = await TerraFlutter.readGlucoseData();
    _logger.d('scanned data of CGM : $message');
    logsList.add({
      'name': 'Scanned CGM',
      'ConnectionName': 'CGM',
      'success': message == null ? false : true,
      message == null ? 'error' : 'data': message ?? 'Data Not found in scan',
      'timeStamp_in_UTC': DateTime.now().toUtc().toIso8601String()
    });

    VizzhyFirebaseServices().logDataToFirestore(
        {'scanned NFC cgm data': message, 'timestamp': DateTime.now()});
    if (message == null) {
      CustomToastUtil.showToast(message: "Scan was not successfull");

      VizzhyFirebaseServices().logErrorToFirestore(CachedErrorModel(
          errorMessage: 'CGM Scan unsuccessful',
          errorStack: '',
          timestamp: DateTime.now()));
      return;
    }
    final cgmJson = jsonDecode(message);
    if (cgmJson == null) {
      logsList.add({
        'name': 'Scanned CGM data process',
        'ConnectionName': 'CGM',
        'success': cgmJson == null ? false : true,
        cgmJson == null ? 'error' : 'data':
            cgmJson ?? 'Data can not be processed,as data is null',
        'timeStamp_in_UTC': DateTime.now().toUtc().toIso8601String()
      });
      VizzhyFirebaseServices().logErrorToFirestore(CachedErrorModel(
          errorMessage: 'could not process scanned data',
          errorStack: 'decoded result was null. scanned result was :$message',
          timestamp: DateTime.now()));

      CustomToastUtil.showToast(
          message: "could not process data, as data was null");
      return;
    }

    final data = {
      "checksum": "",
      "data": {
        "cgmDeviceId": cgmJson["serial_number"],
        "deviceState": cgmJson["sensor_state"],
        "activationDate": (DateTime.tryParse((cgmJson["device_data"]
                        as Map<String, dynamic>?)?["activation_timestamp"] ??
                    '')
                ?.toUtc()
                .toIso8601String()) ??
            '',
        "cgmData":
            (cgmJson['data'] as Map<String, dynamic>?)?['blood_glucose_samples']
                .map((sample) {
          return {
            "glucoseReading": sample['blood_glucose_mg_per_dL'],
            "glucoseUom": "mg/dL",
            "glucoseWarning": "",
            "readingDateTime":
                DateTime.parse(sample["timestamp"]).toUtc().toIso8601String()
          };
        }).toList()
      }
    };

    VizzhyFirebaseServices().logDataToFirestore({
      'scanned NFC cgm data after processed':
          'this data is going to api backend :\n $data',
      'timestamp': DateTime.now()
    });
    final result = await _iotRepository.postCGMData(data);
    result.fold(
      (l) {
        // if(l is AppNotFoundErrorFailure){
        CustomToastUtil.showToast(
          message: "Failed to send data from CGM \n ${l.message}",
          prefixIcon: Icons.error_outline,
          textColor: Colors.white,
          borderColor: Colors.redAccent,
          backgroundColor: Colors.redAccent,
        );
      },
      (r) {
        CustomToastUtil.showToast(
          message: "Data sent successfully",
          prefixIcon: Icons.check,
          textColor: Colors.black,
          borderColor: Colors.green,
          backgroundColor: Colors.greenAccent,
        );
      },
    );
  }

  ///
  String convertToDesiredFormat(String isoDate) {
    final DateTime parsedDate = DateTime.parse(isoDate);
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return formatter.format(parsedDate);
  }

  /// generate AUTH Token for TERRA
  Future<String?> generateAuthToken() async {
    final response = await _dio.post(
      'https://api.tryterra.co/v2/auth/generateAuthToken',
      options: Options(
        headers: {
          'accept': 'application/json',
          'dev-id': terraDevId,
          'x-api-key': terraApiKey,
        },
      ),
    );

    if (response.statusCode == 200) {
      final data = response.data;
      debugPrint(" gen auth token  :$data");
      return data['token'];
    } else {
      return null;
    }
  }

  /// fetch data such as sleep,steps,heart rate etc..
  void fetchAllData(String connectionString, {required String refId}) {
    Connection? connection = switch (connectionString) {
      'appleHealth' => Connection.appleHealth,
      'freestyleLibre' => Connection.freestyleLibre,
      'googleFit' => Connection.googleFit,
      'samsung' => Connection.samsung,
      _ => null
    };
    if (connection == null) return;
    final startDate = DateTime.now().subtract(const Duration(days: 7));
    final endDate = DateTime.now();
    try {
      VizzhyTerraServices.getActiity(connection, startDate, endDate);
      VizzhyTerraServices.getAthlete(connection);

      VizzhyTerraServices.getBodyData(connection, startDate, endDate);

      VizzhyTerraServices.getDaily(connection, startDate, endDate);

      VizzhyTerraServices.getMenstruation(connection, startDate, endDate);

      VizzhyTerraServices.getNutrition(connection, startDate, endDate);

      VizzhyTerraServices.getSleep(connection, startDate, endDate);

      VizzhyTerraServices.getPlannedWorkouts(connection);

      VizzhyTerraServices.getUserInfoByReferenceId(refId,
          devId: terraDevId, apikey: terraApiKey);
    } catch (e, s) {
      debugPrint("erorr caught while fetching data from health apps : $e");
      logsList.add({
        'name': 'Error while fething health data from tryterra',
        'ConnectionName': 'fetchAllData in tryterra controller',
        'success': false,
        'error': '$e',
        'timeStamp_in_UTC': DateTime.now().toUtc().toIso8601String()
      });
      VizzhyFirebaseServices().logErrorToFirestore(CachedErrorModel(
          errorMessage: '$e', errorStack: '$s', timestamp: DateTime.now()));
    }
  }

  /// get widget session web url
  Future<Map<String, dynamic>?> getWidgetUrl(String customerID,
      {required List<String> connectionsList}) async {
    try {
      return await VizzhyTerraServices.getWidgetSessionUrl(
          devId: terraDevId,
          apiKey: terraApiKey,
          refId: customerID,
          connectionsList: connectionsList);
    } catch (e, s) {
      logsList.add({
        'name': 'get widget session ',
        'ConnectionName': 'other devices  by vizzhy',
        'success': false,
        'error': '$e',
        'timeStamp_in_UTC': DateTime.now().toUtc().toIso8601String()
      });
      VizzhyFirebaseServices().logErrorToFirestore(CachedErrorModel(
          errorMessage: '$e', errorStack: '$s', timestamp: DateTime.now()));
      debugPrint("error while fetching url of widget sesion : $e, $s");
      return null;
    }
  }

  /// fetch List of Connection name from Terra services class
  Future<List<String>> getListOfTerraConnectionNamesFromTerraServices() async {
    try {
      return VizzhyTerraServices().getListOfTerraConnectionNames(
        devId: terraDevId,
        apiKey: terraApiKey,
      );
    } catch (e, s) {
      debugPrint(
          "Failed to fetch List of Connection names from Terra services : $e ,staktrace :$s");
      logsList.add({
        'name': 'get List Of Terra ConnectionNames From TerraServices  ',
        'ConnectionName': 'in try terra controller func',
        'success': false,
        'error': '$e',
        'timeStamp_in_UTC': DateTime.now().toUtc().toIso8601String()
      });
      VizzhyFirebaseServices().logErrorToFirestore(CachedErrorModel(
          errorMessage: '$e', errorStack: '$s', timestamp: DateTime.now()));
      return [];
    }
  }
}
