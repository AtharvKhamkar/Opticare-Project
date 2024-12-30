import 'package:get/get.dart';

///This class is used to store all validation related function in an application
class AppValidatorUtil {
  ///function used to validate email is correct or not
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter email ID';
    } else if (value.isEmail == false) {
      return 'Please enter valid email ID';
    }
    return null;
  }

  ///function used to check field is empty or not
  static String? validateEmpty({String? value, required String message}) {
    if (value == null || value.isEmpty) {
      return 'Please enter your $message';
    }
    return null;
  }
}
