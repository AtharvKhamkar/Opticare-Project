import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vizzhy/src/features/auth/models/login_model.dart';
import 'package:vizzhy/src/features/profile/models/customer_details_model.dart';

/// Local Storage for the app
/// used GetStorage
class AppStorage {
  static final _storage = GetStorage("vizzhy");
  static final _onboardingStorage = GetStorage("vizzhy_onboarding");

  /// erase All data from storage
  /// and send user to Login page
  static void logout() async {
    Get.offAllNamed('/login');
    await _storage.erase();

    setIsNewUser(true);
    setIsLoggedOut(true);
  }

  /// set if this is new user
  static void setIsNewUser(bool data) {
    _onboardingStorage.write(AppStorageKey.isNew, data);
  }

  /// check and return true if current logined user is New user
  static bool isNewUser() {
    return _onboardingStorage.read(AppStorageKey.isNew) ?? true;
  }

  /// set onboarding storage to is logged out
  static void setIsLoggedOut(bool data) {
    _onboardingStorage.write(AppStorageKey.isLoggedOut, data);
  }

  /// check whether onboarding storage is loggedout
  static bool isLoggedOut() {
    return _onboardingStorage.read(AppStorageKey.isLoggedOut) ?? false;
  }

  /// vizzhy-storage
  static void setIsLogIn(bool data) {
    _onboardingStorage.write(AppStorageKey.isLoggedOut, false);
    _storage.write(AppStorageKey.loggedIn, data);
  }

  /// retrive is user logged in from vizzhy local storage
  static bool isLoggedIn() {
    return _storage.read(AppStorageKey.loggedIn) ?? false;
  }

  /// set app key
  static void setAppKey(String data) {
    _storage.write(AppStorageKey.appKey, data);
  }

  /// get app key
  static String getAppKey() {
    return _storage.read(AppStorageKey.appKey) ?? "";
  }

  /// set access token to Local Storage
  static void setAccessToken(String data) {
    _storage.write(AppStorageKey.accessToken, data);
  }

  /// get access token from Local Storage
  static String getAccessToken() {
    return _storage.read(AppStorageKey.accessToken);
  }

  /// set refresh token to Local Storage
  static void setRefreshToken(String data) {
    _storage.write(AppStorageKey.refreshToken, data);
  }

  /// get refresh token from Local Storage
  static String getRefreshToken() {
    return _storage.read(AppStorageKey.refreshToken);
  }

  /// set user details in Local STorage
  static void setUserLoginDetails(LoginModel data) {
    _storage.write(
      AppStorageKey.loginDetails,
      jsonEncode(
        data.toJson(),
      ),
    );
  }

  /// get user Details from Local Storage
  static LoginModel getUserLoginDetails() {
    return LoginModel.fromJson(
      jsonDecode(
        _storage.read(AppStorageKey.loginDetails),
      ),
    );
  }

  /// set user profile details to Local Storage
  static void setUserProfileDetails(CustomerProfileModel data) {
    _storage.write(
      AppStorageKey.profileDetails,
      jsonEncode(
        data.toJson(),
      ),
    );
  }

  /// get user Profile detials from Local storage
  static CustomerProfileModel getUserProfileDetails() {
    return CustomerProfileModel.fromJson(
      jsonDecode(
        _storage.read(AppStorageKey.profileDetails),
      ),
    );
  }

  /// set user ID to Local Storage
  static void setUserId(dynamic data) {
    _storage.write(AppStorageKey.userId, data);
  }

  /// get user Id from Local Storage
  static String getUserId() {
    var uId = "${_storage.read(AppStorageKey.userId)}";
    return uId;
  }

  /// set old customer id to Local Storage
  static void setOldUserId(dynamic data) {
    _storage.write(AppStorageKey.oldUserId, data);
  }

  /// get old customerId from local storage
  static String getOldUserId() {
    var uId = '${_storage.read(AppStorageKey.oldUserId)}';
    return uId;
  }

  /// set assistanceId to Local Storage
  static void setAssistanceId(dynamic data) {
    _storage.write(AppStorageKey.assistanceId, data);
  }

  /// get assistanceId from Local Storage
  static String getAssistanceId() {
    var uId = "${_storage.read(AppStorageKey.assistanceId)}";
    return uId;
  }

  /// set is remember Password bool value in Local Storage
  static void setIsRememberPassword(bool data) {
    _storage.write(AppStorageKey.isRememberPassword, data);
  }

  /// get isRemeber Password from Local Storage
  static bool getRememberPasswordStatus() {
    return _storage.read(AppStorageKey.isRememberPassword) ?? false;
  }

  /// save User Login Credential to Local Storage
  static void saveUserCredentials(String userName, String password) {
    Map<String, dynamic> body = {'userName': userName, 'password': password};
    _storage.write(AppStorageKey.userCredentials, body);
  }

  /// Get user login credential from Local Storage
  static Map<String, dynamic>? getUserCredentials() {
    return _storage.read(AppStorageKey.userCredentials);
  }
}

/// Local Storage Keys
class AppStorageKey {
  /// Login key
  static const String loggedIn = "login";

  /// app key
  static const String appKey = "app_key";

  ///
  static const String assistanceId = "assistance_id";

  ///
  static const String accessToken = "access_token";

  ///
  static const String refreshToken = "refresh_token";

  ///
  static const String loginDetails = "login_details";

  ///
  static const String profileDetails = "profile_details";

  ///
  static const String userId = "user_id";

  ///
  static const String oldUserId = 'old_user_id';

  ///
  static const String isNew = "is_new";

  ///
  static const String isLoggedOut = "is_logged_out";

  ///
  static const String isRememberPassword = "is_remember_password";

  ///
  static const String userCredentials = "user_credentials";
}
