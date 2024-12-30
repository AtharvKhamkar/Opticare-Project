///ProfileModel to handle & check profile details of the user
class ProfileModel {
  final String uniqueCustomerId;
  final String firstName;
  final String lastName;
  final String gender;
  final String dateOfBirth;
  final String email;
  final String phone;
  final String address;
  final String assistanceId;

  ProfileModel(
      {required this.uniqueCustomerId,
      required this.firstName,
      required this.lastName,
      required this.gender,
      required this.dateOfBirth,
      required this.email,
      required this.phone,
      required this.address,
      required this.assistanceId});

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    final contact = json['contact'] ?? {};
    final address = json['address'] ?? {};

    return ProfileModel(
      uniqueCustomerId: json['uniqueCustomerId'] ?? '', // Parse the new field
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      gender: json['gender'] ?? '',
      dateOfBirth: json['dateOfBirth'] ?? '',
      email: json['emailId'] ?? '',
      phone: '${contact['countryCode'] ?? ''} ${contact['phoneNumber'] ?? ''}',
      address:
          '${address['addressLine1'] ?? ''}, ${address['addressLine2'] ?? ''}, ${address['city'] ?? ''}, ${address['state'] ?? ''}, ${address['country'] ?? ''}, ${address['postalCode'] ?? ''}',
      assistanceId: json['assistanceId'] ?? '',
    );
  }
}
