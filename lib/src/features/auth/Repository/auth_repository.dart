import 'package:flutter/material.dart';
import 'package:vizzhy/src/core/injection/injection.dart';
import 'package:vizzhy/src/data/remote/api_client.dart';
import 'package:vizzhy/src/features/auth/models/login_model.dart';
import 'package:vizzhy/src/features/conversation/presentation/services/error_handler.dart';

///This is a AuthRepository class used to handle all network request related to the Authentication feature

class AuthRepository {
  ///Instance of the ApiClient
  final apiClient = getIt<ApiClient>();

  ///Function that handles API request related to login process need to pass userName and password in the string format
  Future<LoginModel> login(String userName, String password) async {
    try {
      Map<String, dynamic> body = {
        "data": {"userName": userName.trim(), "password": password.trim()}
      };
      final response =
          await apiClient.postRequest("customer/login", request: body);

      // return response;
      final res = response.fold((l) {
        debugPrint('left in login : $l');
        ErrorHandle.error(l.message);
        return LoginModel.toEmpty();
      }, (r) {
        Map<String, dynamic>? result = (r.data as Map<String, dynamic>?);
        debugPrint(
            "*************************************** \n $result *************************");
        if (r.success == false && result == null) {
          result = result ?? {};
          result['isCredWrongOnAuth'] = true;
        }

        return result == null
            ? LoginModel.toEmpty()
            : LoginModel.fromJson(result);
      });
      return res;
    } catch (e) {
      debugPrint('$e');
      debugPrint('$e');
      return Future.error(e);
    }
  }

  ///This function handles API request related to forgot password functionality
  Future<dynamic> forgotPassword(String email) async {
    try {
      Map<String, dynamic> body = {
        'data': {'emailId': email}
      };

      final response = await ApiClient.client
          .postRequest('customer/forgot/password', request: body);
      return response;
    } catch (e) {
      return Future.error(e);
    }
  }
}
