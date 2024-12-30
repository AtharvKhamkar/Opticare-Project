///This profile model can be used whenever we have to implement addresslinee 1 and addresline 2 and prefered language fields
class CustomerProfileModel {
  final String customerId;
  final String uniqueCustomerId;
  final String firstName;
  final String? middleName;
  final String lastName;
  final String gender;
  final String emailId;
  final String dateOfBirth;
  final Contact contact;
  final String ethnicity;
  final String marritalStatus;
  final String occupation;
  final Address address;
  final List<PreferredLanguage> preferredLanguage;
  final AdditionalInfo additionalInfo;
  final String status;

  CustomerProfileModel({
    required this.customerId,
    required this.uniqueCustomerId,
    required this.firstName,
    this.middleName,
    required this.lastName,
    required this.gender,
    required this.emailId,
    required this.dateOfBirth,
    required this.contact,
    required this.ethnicity,
    required this.marritalStatus,
    required this.occupation,
    required this.address,
    required this.preferredLanguage,
    required this.additionalInfo,
    required this.status,
  });

  factory CustomerProfileModel.fromJson(Map<String, dynamic> json) {
    return CustomerProfileModel(
      customerId: json['customerId'],
      uniqueCustomerId: json['uniqueCustomerId'],
      firstName: json['firstName'],
      middleName: json['middleName'],
      lastName: json['lastName'],
      gender: json['gender'],
      emailId: json['emailId'],
      dateOfBirth: json['dateOfBirth'],
      contact: Contact.fromJson(json['contact']),
      ethnicity: json['ethnicity'],
      marritalStatus: json['marritalStatus'],
      occupation: json['occupation'],
      address: Address.fromJson(json['address']),
      preferredLanguage: List<PreferredLanguage>.from(
          json['preferredLanguage'].map((x) => PreferredLanguage.fromJson(x))),
      additionalInfo: AdditionalInfo.fromJson(json['additionalInfo']),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customerId': customerId,
      'uniqueCustomerId': uniqueCustomerId,
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'gender': gender,
      'emailId': emailId,
      'dateOfBirth': dateOfBirth,
      'contact': contact.toJson(),
      'ethnicity': ethnicity,
      'marritalStatus': marritalStatus,
      'occupation': occupation,
      'address': address.toJson(),
      'preferredLanguage':
          List<dynamic>.from(preferredLanguage.map((x) => x.toJson())),
      'additionalInfo': additionalInfo.toJson(),
      'status': status,
    };
  }
}

class Contact {
  final String countryCode;
  final String phoneNumber;

  Contact({
    required this.countryCode,
    required this.phoneNumber,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      countryCode: json['countryCode'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'countryCode': countryCode,
      'phoneNumber': phoneNumber,
    };
  }
}

class Address {
  final String addressLine1;
  final String? addressLine2;
  final String city;
  final String state;
  final String country;
  final String postalCode;

  Address({
    required this.addressLine1,
    this.addressLine2,
    required this.city,
    required this.state,
    required this.country,
    required this.postalCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      addressLine1: json['addressLine1'],
      addressLine2: json['addressLine2'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      postalCode: json['postalCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'city': city,
      'state': state,
      'country': country,
      'postalCode': postalCode,
    };
  }
}

class PreferredLanguage {
  final String languageId;
  final String language;

  PreferredLanguage({
    required this.languageId,
    required this.language,
  });

  factory PreferredLanguage.fromJson(Map<String, dynamic> json) {
    return PreferredLanguage(
      languageId: json['languageId'],
      language: json['language'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'languageId': languageId,
      'language': language,
    };
  }
}

class AdditionalInfo {
  final Guardian guardian;

  AdditionalInfo({
    required this.guardian,
  });

  factory AdditionalInfo.fromJson(Map<String, dynamic> json) {
    return AdditionalInfo(
      guardian: Guardian.fromJson(json['guardian']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'guardian': guardian.toJson(),
    };
  }
}

class Guardian {
  final String? name;
  final String? emailId;
  final Contact contact;

  Guardian({
    this.name,
    this.emailId,
    required this.contact,
  });

  factory Guardian.fromJson(Map<String, dynamic> json) {
    return Guardian(
      name: json['name'],
      emailId: json['emailId'],
      contact: Contact.fromJson(json['contact']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'emailId': emailId,
      'contact': contact.toJson(),
    };
  }
}
