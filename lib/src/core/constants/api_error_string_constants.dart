class AppApiErrorStrings {
  /// Socket Exception
  static var connectionError =
      "You are not connected to the internet. Please try again";

  /// when api statuscode is >=500
  static var serverError =
      "Server Error unable to process. Please try in sometime.";

  /// Bad Request from client(App) side
  /// 400
  static const String badRequestError =
      'Bad Request, please contact Developer Team\n or try again after some time...';

  /// 401
  static const String unAuthrizedError =
      'You are not Autherized to make this Request';

  /// 403
  /// forbidden
  static const String forbiddenError = 'You are forbid to make request';

  /// 404
  static const String notFoundError =
      'server not found, unable to make request';

  /// something went wrong
  /// unknown error
  static const String somethingWentWrong = 'Something Went wrong...';
}
