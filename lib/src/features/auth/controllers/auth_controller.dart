import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vizzhy/src/core/global/app_dialog_handler.dart';
import 'package:vizzhy/src/data/local_storage/app_storage.dart';
import 'package:vizzhy/src/features/auth/Repository/auth_repository.dart';
import 'package:vizzhy/src/features/conversation/presentation/services/error_handler.dart';
import 'package:vizzhy/src/presentation/widgets/custom_toast_util.dart';

///AuthController  is used to manage the state of the Auth feature
class AuthController extends GetxController with StateMixin<dynamic> {
  final _authRepo = AuthRepository();

  ///TextEditingController for the username field
  final userNameController = TextEditingController();

  ///TextEditingController for the password field
  final passwordController = TextEditingController();

  ///TextEditingController for the forgot password field
  final forgotPasswordController = TextEditingController();

  //Booleans
  ///Used to track loading state of the controller
  var isLoading = false.obs;

  ///Used to check data is present or not
  var hasData = false.obs;

  //String
  ///Used to save errorMessage in the controler;
  var errorEmailMessage = "".obs;

  ///Used to save password errorMessages
  var errorPasswordMessage = "".obs;

  @override
  void onInit() {
    if (kDebugMode) {
      userNameController.text = "";
      passwordController.text = "";
    }
    super.onInit();
  }

  ///Reset funtion to reset the TextEditingControllers
  void reset() {
    userNameController.clear();
    passwordController.clear();
  }

  ///Function used for login process
  void login() async {
    if (isLoading.value) return;
    isLoading(true);
    update();

    _authRepo.login(userNameController.text, passwordController.text).then(
        (result) {
      debugPrint('result in auth controll : $result');
      isLoading(false);
      if (!result.isEmpty && !result.isCredWrongOnAuth) {
        AppStorage.setUserLoginDetails(result);
        AppStorage.setAccessToken(result.accessToken);
        AppStorage.setRefreshToken(result.refreshToken);
        AppStorage.setUserId(result.customerId);
        AppStorage.setOldUserId(result.oldCustomerId);
        AppStorage.setIsLogIn(true);
        AppStorage.setIsNewUser(false);
        reset();
        Get.offAllNamed('/conversation');
      } else if (!result.isEmpty && result.isCredWrongOnAuth) {
        CustomToastUtil.showFailureToast(message: 'Credential was wrong');
      } else {
        AppDialogHandler.accessDeniedDialog();
      }
      update();
    }, onError: (e) {
      isLoading(false);
      ErrorHandle.error("$e");
      update();
    });
  }

  ///Function used for forgot password functionality
  void forgotPassword() {
    if (isLoading.value) return;
    isLoading(true);
    update();

    _authRepo.forgotPassword(forgotPasswordController.text).then((value) {
      isLoading(false);
      if (value['success']) {
        Get.toNamed('/otp-verification');
        update();
      }
      // else {
      //   final model = Failure.fromJson(value['error']);
      //   ErrorHandle.error(model.toString());
      // }
      // else {
      //   final model = Failure.fromJson(value['error']);
      //   ErrorHandle.error(model.toString());
      // }
      update();
    }, onError: (e) {
      isLoading(false);
      ErrorHandle.error('$e');
      update();
    });
  }
}

///AuthBinding used to initialize the controller before Splash screen
class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(
      () => AuthController(),
      fenix: true,
    );
  }
}
