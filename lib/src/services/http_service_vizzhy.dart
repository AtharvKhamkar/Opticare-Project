import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vizzhy/src/services/vizzhy_firebase_service.dart';
import '../presentation/widgets/custom_toast_util.dart';
import '../data/models/cached_error_model.dart'; // Your ErrorLoggerService class

/// use this class to Call Api via HTTP request.
/// need to pass base url in contructor params
/// Supported Operations : GET, POST, DELETE
/// update this class for more operation support
class VizzhyHttpServices {
  /// Base url for the api
  final String baseUrl;
  final VizzhyFirebaseServices _errorLogger = VizzhyFirebaseServices();

  // List to cache errors locally
  final List<CachedErrorModel> _localErrorCache = [];

  /// constructor for vizzhy Http services class
  VizzhyHttpServices({required this.baseUrl});

  /// GET Request
  /// will provide dcoded json if status code is 200
  Future<dynamic> get(String endpoint, {Map<String, String>? headers}) async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl$endpoint'), headers: headers);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Failed to load data. Status code: ${response.statusCode} ,body :${response.body}, url hit : ${response.request?.url}');
      }
    } catch (error, stackTrace) {
      await _handleError(error, stackTrace);
      return null;
    }
  }

  /// POST Request
  /// will encode your body and send to api call
  /// return respose when status code is either 200 or 201
  Future<dynamic> post(String endpoint,
      {required Map<String, dynamic> body,
      Map<String, String>? headers}) async {
    try {
      debugPrint(
          "calling post request in http service  :$endpoint \n headers : $headers");
      final response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: headers ?? {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );
      debugPrint(
          'response of post request in vizzhy http service : ${response.body} ${response.statusCode}');
      if (response.statusCode == 201 || response.statusCode == 200) {
        debugPrint('Entered in the if status code condition --------->');
        debugPrint(
            'returned value from VizzhyHttpService post -------------> ${jsonDecode(response.body).toString()}');
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Failed to post data. Status code: ${response.statusCode},body :${response.body}');
      }
    } catch (error, stackTrace) {
      debugPrint("error in post request of http vizzhy service :$error");
      VizzhyFirebaseServices().logErrorToFirestore(CachedErrorModel(
          errorMessage: '$error',
          errorStack: '$stackTrace',
          timestamp: DateTime.now()));
      await _handleError(error, stackTrace);
      return null;
    }
  }

  /// DELETE Request
  Future<Map?> delete(
    String endpoint, {
    Map<String, String>? headers,
  }) async {
    try {
      final url = Uri.parse('$baseUrl$endpoint');
      debugPrint(
          "while calling deauth, baseurl : $url \nthis is headers :$headers");

      final response = await http.delete(
        url,
        headers: headers,
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map;
      } else {
        CustomToastUtil.showToast(
            message: '${response.statusCode}, \n ${response.body}',
            prefixIcon: Icons.error_outline,
            textColor: Colors.black,
            backgroundColor: Colors.redAccent);
        throw Exception(
            'Failed to delete data. Status code: ${response.statusCode},body :${response.body}');
      }
    } catch (error, stackTrace) {
      await _handleError(error, stackTrace);
      return null;
    }
  }

  // Handles logging of errors and caching them locally if needed
  Future<void> _handleError(dynamic error, StackTrace stackTrace) async {
    final cachedError = CachedErrorModel(
      errorMessage: error.toString(),
      errorStack: stackTrace.toString(),
      timestamp: DateTime.now(),
    );

    // Attempt to log error to Firebase
    _logErrorToFirebase(cachedError);
    _localErrorCache.add(cachedError);
  }

  // Logs error to Firebase and returns success/failure
  void _logErrorToFirebase(CachedErrorModel error) {
    try {
      _errorLogger.logErrorToFirestore(error);
    } catch (e) {
      debugPrint("Failed to log error to Firebase: $e");
    }
  }

  // Resend cached errors to Firebase
  // void _resendCachedErrors() {
  //   for (var error in _localErrorCache) {
  //     _logErrorToFirebase(error);
  //     _localErrorCache
  //         .remove(error); // Remove from cache once successfully logged
  //   }
  // }
}
