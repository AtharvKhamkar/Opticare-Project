// ignore_for_file: public_member_api_docs
///LoginModel is used to check data type is correct or not of the Login Process response
class LoginModel {
  final String accessToken;
  final String refreshToken;
  final String customerId;
  final String emailId;
  final String firstName;
  final String middleName;
  final String lastName;
  final String status;
  final DateTime lastPasswordChange;
  final DateTime lastLoginDate;
  final String oldCustomerId;

  bool isCredWrongOnAuth;

  LoginModel({
    required this.oldCustomerId,
    required this.accessToken,
    required this.refreshToken,
    required this.customerId,
    required this.emailId,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.status,
    required this.lastPasswordChange,
    required this.lastLoginDate,
    this.isCredWrongOnAuth = false,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    final token = json['token'] ?? {};
    final customerDetails = json['customerDetails'] ?? {};

    return LoginModel(
      accessToken: token['accessToken'] ?? '',
      refreshToken: token['refreshToken'] ?? '',
      customerId: customerDetails['customerId'] ?? '',
      emailId: customerDetails['emailId'] ?? '',
      firstName: customerDetails['firstName'] ?? '',
      middleName: customerDetails['middleName'] ?? '',
      lastName: customerDetails['lastName'] ?? '',
      status: customerDetails['status'] ?? '',
      oldCustomerId: customerDetails['oldCustomerId'] ?? '',
      lastPasswordChange:
          DateTime.tryParse(customerDetails['lastPasswordChange'] ?? '') ??
              DateTime(1970, 1, 1),
      lastLoginDate:
          DateTime.tryParse(customerDetails['lastLoginDate'] ?? '') ??
              DateTime(1970, 1, 1),
      isCredWrongOnAuth: json['isCredWrongOnAuth'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': {
        'accessToken': accessToken,
        'refreshToken': refreshToken,
      },
      'customerDetails': {
        'customerId': customerId,
        'emailId': emailId,
        'firstName': firstName,
        'middleName': middleName,
        'lastName': lastName,
        'status': status,
        'oldCustomerId': oldCustomerId,
        'lastPasswordChange': lastPasswordChange.toIso8601String(),
        'lastLoginDate': lastLoginDate.toIso8601String(),
      },
    };
  }

  // toEmpty function
  static LoginModel toEmpty() {
    return LoginModel(
      oldCustomerId: '',
      accessToken: '',
      refreshToken: '',
      customerId: '',
      emailId: '',
      firstName: '',
      middleName: '',
      lastName: '',
      status: '',
      lastPasswordChange: DateTime(1970, 1, 1),
      lastLoginDate: DateTime(1970, 1, 1),
      isCredWrongOnAuth: false,
    );
  }

  // isEmpty getter
  bool get isEmpty {
    return accessToken.isEmpty &&
        refreshToken.isEmpty &&
        customerId.isEmpty &&
        emailId.isEmpty &&
        firstName.isEmpty &&
        middleName.isEmpty &&
        lastName.isEmpty &&
        status.isEmpty &&
        oldCustomerId.isEmpty &&
        lastPasswordChange.isAtSameMomentAs(DateTime(1970, 1, 1)) &&
        lastLoginDate.isAtSameMomentAs(DateTime(1970, 1, 1)) &&
        !isCredWrongOnAuth;
  }

  @override
  String toString() {
    return 'LoginModel('
        'accessToken: $accessToken, '
        'refreshToken: $refreshToken, '
        'customerId: $customerId, '
        'emailId: $emailId, '
        'firstName: $firstName, '
        'middleName: $middleName, '
        'lastName: $lastName, '
        'status: $status, '
        'oldCustomerId: $oldCustomerId, '
        'lastPasswordChange: $lastPasswordChange, '
        'lastLoginDate: $lastLoginDate, '
        'isCredWrongOnAuth: $isCredWrongOnAuth'
        ')';
  }
}
