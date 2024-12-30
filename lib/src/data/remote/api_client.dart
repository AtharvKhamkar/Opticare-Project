import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:fpdart/fpdart.dart';
import 'package:vizzhy/src/data/local_storage/app_storage.dart';
import 'package:vizzhy/src/core/injection/injection.dart';
import 'package:vizzhy/src/utils/failure.dart';
import 'package:vizzhy/src/features/conversation/presentation/services/error_handler.dart';
import 'package:vizzhy/src/utils/api_response_model.dart';

import 'package:vizzhy/src/core/global/app_config_abstract.dart';

/// choose type of server to call
enum ServerTypes {
  /// login
  login,

  ///
  onboarding,

  ///
  appointment,

  ///
  reports,

  ///
  careplan,

  ///
  customer,

  ///
  meals,

  ///
  iot,

  ///
  vfs,

  ///
  conversation,
}

/// give instance of api Client to call Api
class ApiClient {
  static final ApiClient _instance = ApiClient._internal();

  ///
  factory ApiClient() {
    return _instance;
  }

  ApiClient._internal() {
    _initialize();
  }

  final Dio _dio = Dio();

  /// give instance of app config
  /// which contains base url
  AppConfig appConfig = getIt<AppConfig>();

  void _initialize() {
    // Determine which configuration to use

    _dio.options = BaseOptions(
      responseType: ResponseType.json,
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          options.headers.addAll(_headers(_serverTypes));
          return handler.next(options);
        },
        onError: (e, handler) async {
          if (e.response != null &&
              e.response?.statusCode == 401 &&
              e.response!.realUri.toString().contains('refresh-token')) {
            AppStorage.logout();
            ErrorHandle.error('Session expired');
          } else if (e.response != null &&
              e.response?.statusCode == 401 &&
              !e.response!.realUri.toString().contains('refresh-token')) {
            final result = await accessToken();
            debugPrint('New access token fetched from interceptor $result');
            if (result) {
              e.requestOptions.headers['x-access-token'] =
                  AppStorage.getAccessToken();
              return handler.resolve(await _dio.fetch(e.requestOptions));
            } else {
              return handler.next(e);
            }
          }
          return handler.next(e);
        },
      ),
    );
  }

  //Interceptor logic
  ApiClient._() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          options.headers.addAll(_headers(_serverTypes));
          return handler.next(options);
        },
        onError: (e, handler) async {
          if (e.response != null &&
              e.response?.statusCode == 401 &&
              e.response!.realUri.toString().contains('refresh-token')) {
            AppStorage.logout();
            ErrorHandle.error('Session expired');
          } else if (e.response != null &&
              e.response?.statusCode == 401 &&
              !e.response!.realUri.toString().contains('refresh-token')) {
            final result = await accessToken();
            debugPrint('New access token fetched from interceptor $result');
            if (result) {
              e.requestOptions.headers['x-access-token'] =
                  AppStorage.getAccessToken();
              return handler.resolve(await _dio.fetch(e.requestOptions));
            } else {
              return handler.next(e);
            }
          }
          return handler.next(e);
        },
      ),
    );
  }

  ///
  static final ApiClient _client = ApiClient._();

  /// get global instance of api client
  static ApiClient get client => _client;
  ServerTypes _serverTypes = ServerTypes.login;

  //Headers
  Map<String, String> _headers(ServerTypes type) {
    Map<String, String> map = {};

    map['accept'] = "application/json";
    map['content-type'] = "application/json";
    if (AppStorage.isLoggedIn()) {
      map['x-access-token'] = AppStorage.getAccessToken();
    }

    switch (type) {
      case ServerTypes.login:
        map['x-api-key'] = appConfig.loginServiceApiKey;
      case ServerTypes.onboarding:
        map['x-api-key'] = appConfig.onboardingServiceApiKey;
      case ServerTypes.appointment:
        map['x-api-key'] = appConfig.appointmentServiceApiKey;
      case ServerTypes.reports:
        map['x-api-key'] = appConfig.labReportServiceApiKey;
      case ServerTypes.careplan:
        map['x-api-key'] = appConfig.carePlanServiceApiKey;
      case ServerTypes.customer:
        map['x-api-key'] = appConfig.customerService;
      case ServerTypes.meals:
        map['x-api-key'] = appConfig.mealsService;
      case ServerTypes.iot:
        map['x-api-key'] = appConfig.iotServiceKey;
      case ServerTypes.vfs:
        map['x-api-key'] = '';
      case ServerTypes.conversation:
        map['x-api-key'] = appConfig.conversationServiceApiKey;
    }

    return map;
  }

  /// Timeout of 60 secs
  Duration get timeout {
    return const Duration(seconds: 60);
  }

  /// get request id as per platform
  /// with prefix of platform name
  /// with suffix millisecondsSinceEpoch
  Map<String, String> get requestId {
    return {
      "requestId":
          "${kIsWeb ? "WEB" : Platform.isAndroid ? "ANDROID" : "IOS"}_${DateTime.now().millisecondsSinceEpoch}"
    };
  }

  BaseOptions _getOptions(ServerTypes serverType) {
    switch (serverType) {
      case ServerTypes.login:
        return BaseOptions(
            baseUrl: appConfig.LOGIN_BASE_URL,
            headers: _headers(serverType),
            connectTimeout: timeout,
            responseType: ResponseType.json);

      case ServerTypes.onboarding:
        return BaseOptions(
            baseUrl: appConfig.ONBOARDING_BASE_URL,
            headers: _headers(serverType),
            connectTimeout: timeout,
            responseType: ResponseType.json);

      case ServerTypes.appointment:
        return BaseOptions(
            baseUrl: appConfig.APPOINTMENT_BASE_URL,
            headers: _headers(serverType),
            connectTimeout: timeout,
            responseType: ResponseType.json);

      case ServerTypes.reports:
        return BaseOptions(
            baseUrl: appConfig.REPORTS_BASE_URL,
            headers: _headers(serverType),
            connectTimeout: timeout,
            responseType: ResponseType.json);

      case ServerTypes.careplan:
        return BaseOptions(
            baseUrl: appConfig.CARE_PLAN_BASE_URL,
            headers: _headers(serverType),
            connectTimeout: timeout,
            responseType: ResponseType.json);

      case ServerTypes.customer:
        return BaseOptions(
            baseUrl: appConfig.CUSTOMER_SERVICE_BASE_URL,
            headers: _headers(serverType),
            connectTimeout: timeout,
            responseType: ResponseType.json);

      case ServerTypes.meals:
        return BaseOptions(
            baseUrl: appConfig.MEALS_SERVICE_BASE_URL,
            headers: _headers(serverType),
            connectTimeout: timeout,
            responseType: ResponseType.json);
      case ServerTypes.iot:
        return BaseOptions(
            baseUrl: appConfig.IOT_BASE_URL,
            headers: _headers(serverType),
            connectTimeout: timeout,
            responseType: ResponseType.json);
      case ServerTypes.vfs:
        return BaseOptions(
            baseUrl: appConfig.VFS_BASE_URL,
            connectTimeout: timeout,
            responseType: ResponseType.json);
      case ServerTypes.conversation:
        return BaseOptions(
            baseUrl: appConfig.CONVERSATION_BASE_URL,
            headers: _headers(serverType),
            connectTimeout: timeout,
            responseType: ResponseType.json);
    }
  }

  ///GET request
  ///return either response
  /// success will contain DATA
  /// where as failure will contain exceptions
  Future<Either<Failure, ApiResponseModel>> getRequest(String endpoint,
      {ServerTypes serverType = ServerTypes.login,
      List<String> excludeHeader = const [],
      Map<String, dynamic>? additionalQueryParams}) async {
    try {
      _serverTypes = serverType;
      _dio.options = _getOptions(serverType);
      _dio.options.headers
          .removeWhere((key, value) => excludeHeader.contains(key));

      final queryParams = {
        ...requestId,
        if (additionalQueryParams != null) ...additionalQueryParams
      };

      debugPrint(endpoint);
      debugPrint('$queryParams');

      final response = await _dio.get(endpoint, queryParameters: queryParams);

      _log(response.requestOptions.uri.toString());
      _log(response.statusCode);
      _log(jsonEncode(response.data));
      return Right(ApiResponseModel.fromJson(response.data));
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return response.data;
      // } else {
      //   return Future.error(
      //       "${response.data['error']['code'] - response.data['error']['message']}");
      // }
    } catch (e) {
      _log(e);
      return Left(await _handleError(e));
    }
  }

  /// POST request
  ///return either response
  /// success will contain DATA
  /// where as failure will contain exceptions
  Future<Either<Failure, ApiResponseModel>> postRequest(String endpoint,
      {Map<String, dynamic> request = const {},
      ServerTypes serverType = ServerTypes.login,
      Map<String, dynamic>? additionalQueryParams}) async {
    try {
      debugPrint('Before server types');
      _serverTypes = serverType;
      _dio.options = _getOptions(serverType);
      debugPrint('After server types');
      final queryParams = {
        ...requestId,
        if (additionalQueryParams != null) ...additionalQueryParams
      };

      debugPrint('before post request');

      final response = await _dio.post(endpoint,
          data: jsonEncode(request), queryParameters: queryParams);

      _log(request.toString());
      _log(response.realUri.toString());
      _log(response.statusCode);
      _log(jsonEncode(response.data));

      Map body = response.data;

      debugPrint(
          "------------- After Post Request : \n ${response.statusCode} $body \n ---------------");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(ApiResponseModel.fromJson(body as Map<String, dynamic>));
      } else {
        //   return Left(ApiResponseModel.fromJson(body as Map<String, dynamic>));
        debugPrint(
            "in dioclient post request statusCode  :${response.statusCode} , body : ${response.data}");
        return Left(VizzhySomethingWentWrongFailure(
            message: 'unexpected statuscode : ${response.statusCode}'));
      }
    } on PlatformException catch (e) {
      debugPrint('$e');
      return Left(await _handleError(e));
    } catch (e) {
      debugPrint('caught in api_client : $e');
      _log(request.toString());
      _log(e);
      return Left(await _handleError(e));
    }
  }

  ///PATCH
  /// Need to pass endpoints
  ///eg. login, register, user
  Future<Either<Failure, ApiResponseModel>> patchRequest(String endpoint,
      {Map<String, dynamic> request = const {},
      ServerTypes serverType = ServerTypes.login,
      Map<String, dynamic>? additionalQueryParams}) async {
    try {
      _serverTypes = serverType;
      _dio.options = _getOptions(serverType);
      final queryParams = {
        ...requestId,
        if (additionalQueryParams != null) ...additionalQueryParams
      };

      final response = await _dio.patch(endpoint,
          data: jsonEncode(request), queryParameters: queryParams);

      _log(request.toString());
      _log(response.realUri.toString());
      _log(response.statusCode);
      _log(jsonEncode(response.data));

      Map body = response.data;

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(ApiResponseModel.fromJson(body as Map<String, dynamic>));
      } else {
        debugPrint(
            "in dioclient patch request statusCode  :${response.statusCode} , body : ${response.data}");
        return Left(VizzhySomethingWentWrongFailure(
            message: 'unexpected statuscode : ${response.statusCode}'));
      }
    } on PlatformException catch (e) {
      debugPrint('$e');
      return Left(await _handleError(e));
    } catch (e) {
      debugPrint('caught in api_client : $e');
      _log(request.toString());
      _log(e);
      return Left(await _handleError(e));
    }
  }

  ///DELETE
  /// Need to pass endpoints
  /// eg. login, register, user
  Future<Either<Failure, ApiResponseModel>> deleteRequest(String endpoint,
      {Map<String, dynamic> request = const {},
      ServerTypes serverType = ServerTypes.login,
      Map<String, dynamic>? additionalQueryParams}) async {
    try {
      _serverTypes = serverType;
      _dio.options = _getOptions(serverType);
      final queryParams = {
        ...requestId,
        if (additionalQueryParams != null) ...additionalQueryParams
      };

      final response = await _dio.delete(
        endpoint,
        data: jsonEncode(request),
        queryParameters: queryParams,
      );

      _log(response.realUri.toString());
      _log(response.statusCode);
      _log(jsonEncode(response.data));

      Map body = (response.data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(ApiResponseModel.fromJson(body as Map<String, dynamic>));
      } else {
        return Left(VizzhySomethingWentWrongFailure(
            message: 'unexpected statuscode : ${response.statusCode}'));
      }
    } on PlatformException catch (e) {
      debugPrint('$e');
      return Left(await _handleError(e));
    } catch (e) {
      debugPrint('caught in api_client : $e');
      _log(request.toString());
      _log(e);
      return Left(await _handleError(e));
    }
  }

  /// dio.request()
  Future<dynamic> request(String endpoint,
      {Map<String, dynamic> request = const {},
      Map<String, dynamic> header = const {},
      ServerTypes serverType = ServerTypes.login,
      String method = "POST",
      Map<String, dynamic>? additionalQueryParams}) async {
    try {
      _serverTypes = serverType;
      _dio.options = _getOptions(serverType);
      _dio.options.method = method;
      _dio.options.headers = header;
      final queryParams = {
        ...requestId,
        if (additionalQueryParams != null) ...additionalQueryParams
      };

      final response = await _dio.request(endpoint,
          data: jsonEncode(request), queryParameters: queryParams);

      _log(response.realUri.toString());
      _log(response.statusCode);
      _log(jsonEncode(response.data));

      Map body = (response.data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return body;
      } else {
        return Future.error(
            "${body['error']['code'] - body['error']['message']}");
      }
    } catch (e) {
      _log(e);
      return await _handleError(e);
    }
  }

  /// Multipart request
  /// used to send media files
  /// such as images
  Future<dynamic> multipartRequest(String endpoint,
      {Map<String, dynamic> request = const {},
      Map<String, String> files = const {},
      ServerTypes serverType = ServerTypes.reports}) async {
    try {
      _serverTypes = serverType;
      _dio.options = _getOptions(serverType);

      var multipartFile = <String, MultipartFile>{};

      for (var item in files.entries) {
        multipartFile[item.key] = await MultipartFile.fromFile(item.value,
            filename: item.value.split("/").last);
      }

      FormData formData = FormData.fromMap({...request, ...multipartFile});
      debugPrint('response : $formData');

      final response =
          await _dio.post(endpoint, data: formData, queryParameters: requestId);
      debugPrint('response : ${response.data}');
      _log(response.realUri.toString());
      _log(response.statusCode);
      _log(jsonEncode(response.data));

      Map body = response.data;

      if (response.statusCode == 200 || response.statusCode == 201) {
        return body;
      } else {
        return Future.error(
            '${body['error']['code']} - ${body['error']['message']}');
      }
    } catch (e) {
      _log(e);
      return await _handleError(e);
    }
  }

  /// get and store access token to local storage
  /// and use whenever neccassary
  Future<bool> accessToken() async {
    try {
      Map<String, dynamic> body = {
        'data': {'refreshToken': AppStorage.getRefreshToken()}
      };

      _serverTypes = ServerTypes.login;
      _dio.options = _getOptions(ServerTypes.login);
      final response = await _dio.post('customer/refresh/token',
          queryParameters: requestId, data: jsonEncode(body));

      if (response.statusCode == 200 || response.statusCode == 201) {
        bool isSuccess = response.data['success'];
        if (isSuccess) {
          AppStorage.setAccessToken(
              response.data['data']['tokens']['accessToken']);
          AppStorage.setRefreshToken(
              response.data['data']['tokens']['refreshToken']);
        }
        return isSuccess;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  void _log(dynamic message) {
    if (kDebugMode) {
      log("Network Log => $message");
    }
  }

  Future<Failure> _handleError(dynamic error) async {
    if (error is DioException) {
      if (error.response == null) {
        if (error.error is SocketException) {
          return VizzhyNoInternetFailure();
        }
        debugPrint("error response is null : ${error.error.runtimeType}");
        return VizzhyServerErrorFailure();
      }
      switch (error.response?.statusCode ?? 0) {
        case 422:
          return error.response!.data;
        // case 502:
        // case 503:
        // case 504:
        case 404:
          return VizzhyNotFoundErrorFailure();
        case 400:
          return VizzhyBadRequestFailure();
        case >= 500:
          return VizzhyServerErrorFailure();

        default:
          return VizzhySomethingWentWrongFailure();
      }
    }
    return VizzhySomethingWentWrongFailure();
  }
}
