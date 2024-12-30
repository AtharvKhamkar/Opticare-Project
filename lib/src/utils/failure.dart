import 'package:vizzhy/src/core/constants/api_error_string_constants.dart';

class Failure {
  final String message;
  final int? code;

  Failure({
    required this.message,
    this.code,
  });

  @override
  String toString() => 'Failure(message: $message, code: $code)';
}

// No Internet Failure
class VizzhyNoInternetFailure extends Failure {
  VizzhyNoInternetFailure({
    String? message,
    super.code,
  }) : super(
          message: message ?? AppApiErrorStrings.connectionError,
        );
}

// Bad Request Failure
class VizzhyBadRequestFailure extends Failure {
  VizzhyBadRequestFailure({
    String? message,
    super.code,
  }) : super(
          message: message ?? AppApiErrorStrings.badRequestError,
        );
}

// Server Error Failure
class VizzhyServerErrorFailure extends Failure {
  VizzhyServerErrorFailure({
    String? message,
    super.code,
  }) : super(
          message: message ?? AppApiErrorStrings.serverError,
        );
}

// Not Found Error Failure
class VizzhyNotFoundErrorFailure extends Failure {
  VizzhyNotFoundErrorFailure({
    String? message,
    super.code,
  }) : super(
          message: message ?? AppApiErrorStrings.notFoundError,
        );
}

// Forbidden Error Failure
class VizzhyForbiddenErrorFailure extends Failure {
  VizzhyForbiddenErrorFailure({
    String? message,
    super.code,
  }) : super(
          message: message ?? AppApiErrorStrings.forbiddenError,
        );
}

// Unauthorized Error Failure
class VizzhyUnauthorizedErrorFailure extends Failure {
  VizzhyUnauthorizedErrorFailure({
    String? message,
    super.code,
  }) : super(
          message: message ?? AppApiErrorStrings.unAuthrizedError,
        );
}

// Something Went Wrong Error Failure
class VizzhySomethingWentWrongFailure extends Failure {
  VizzhySomethingWentWrongFailure({
    String? message,
    super.code,
  }) : super(
          message: message ?? AppApiErrorStrings.somethingWentWrong,
        );
}

// import 'package:vizzhy/src/core/constants/api_error_string_constants.dart';

// class Failure {
//   final String message;
//   final int? code;

//   Failure({
//     required this.message,
//     this.code,
//   });

//   @override
//   String toString() => 'Failure(message: $message, code: $code)';
// }

// // No Internet Failure
// class VizzhyNoInternetFailure extends Failure {
//   VizzhyNoInternetFailure({
//     String? message,
//     super.code,
//   }) : super(
//           message: message ?? AppApiErrorStrings.connectionError,
//         );
// }

// // Bad Request Failure
// class VizzhyBadRequestFailure extends Failure {
//   VizzhyBadRequestFailure({
//     String? message,
//     super.code,
//   }) : super(
//           message: message ?? AppApiErrorStrings.badRequestError,
//         );
// }

// // Server Error Failure
// class VizzhyServerErrorFailure extends Failure {
//   VizzhyServerErrorFailure({
//     String? message,
//     super.code,
//   }) : super(
//           message: message ?? AppApiErrorStrings.serverError,
//         );
// }

// // Not Found Error Failure
// class VizzhyNotFoundErrorFailure extends Failure {
//   VizzhyNotFoundErrorFailure({
//     String? message,
//     super.code,
//   }) : super(
//           message: message ?? AppApiErrorStrings.notFoundError,
//         );
// }

// // Forbidden Error Failure
// class VizzhyForbiddenErrorFailure extends Failure {
//   VizzhyForbiddenErrorFailure({
//     String? message,
//     super.code,
//   }) : super(
//           message: message ?? AppApiErrorStrings.forbiddenError,
//         );
// }

// // Unauthorized Error Failure
// class VizzhyUnauthorizedErrorFailure extends Failure {
//   VizzhyUnauthorizedErrorFailure({
//     String? message,
//     super.code,
//   }) : super(
//           message: message ?? AppApiErrorStrings.unAuthrizedError,
//         );
// }

// // Something Went Wrong Error Failure
// class VizzhySomethingWentWrongFailure extends Failure {
//   VizzhySomethingWentWrongFailure({
//     String? message,
//     super.code,
//   }) : super(
//           message: message ?? AppApiErrorStrings.somethingWentWrong,
//         );
// }
