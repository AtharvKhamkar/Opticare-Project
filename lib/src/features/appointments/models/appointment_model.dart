// ignore_for_file: public_member_api_docs

///Appointment model to handle & check single appointment response
class Appointment {
  final String appointmentId;
  final DateTime fromDate;
  final DateTime toDate;
  final String title;
  final String meetingType;
  final String description;
  final String? callLinkSource;
  final String? callLink;
  final bool isReschedule;
  final String timeZone;
  final List<String> participants;
  final String userId;
  final String userName;
  final String customerId;
  final String customerName;
  final String status;
  final String? meetingId;
  final String? meetingUrl;
  final String? meetingPassword;
  final String? meetingTypeFromDetails;

  Appointment({
    required this.appointmentId,
    required this.fromDate,
    required this.toDate,
    required this.title,
    required this.meetingType,
    required this.description,
    this.callLinkSource,
    this.callLink,
    required this.isReschedule,
    required this.timeZone,
    required this.participants,
    required this.userId,
    required this.userName,
    required this.customerId,
    required this.customerName,
    required this.status,
    this.meetingId,
    this.meetingUrl,
    this.meetingPassword,
    this.meetingTypeFromDetails,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      appointmentId: json['appointmentDetails']['appointmentId'],
      fromDate: DateTime.parse(json['appointmentDetails']['fromDate']),
      toDate: DateTime.parse(json['appointmentDetails']['toDate']),
      title: json['appointmentDetails']['title'] ?? '',
      meetingType: json['appointmentDetails']['meetingType'] ?? '',
      description: json['appointmentDetails']['description'] ?? '',
      callLinkSource: json['appointmentDetails']['callLinkSource'],
      callLink: json['appointmentDetails']['callLink'],
      isReschedule: json['appointmentDetails']['isReschedule'] ?? false,
      timeZone: json['appointmentDetails']['timeZone'] ?? '',
      participants: List<String>.from(json['participants'] ?? []),
      userId: json['user']['userId'] ?? '',
      userName: json['user']['userName'] ?? '',
      customerId: json['customer']['customerId'] ?? '',
      customerName: json['customer']['customerName'] ?? '',
      status: json['status'] ?? '',
      meetingId: json['meetingDetails']?['meetingId'],
      meetingUrl: json['meetingDetails']?['meetingUrl'],
      meetingPassword: json['meetingDetails']?['meetingPassword'],
      meetingTypeFromDetails: json['meetingDetails']?['meetingType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'appointmentDetails': {
        'appointmentId': appointmentId,
        'fromDate': fromDate.toIso8601String(),
        'toDate': toDate.toIso8601String(),
        'title': title,
        'meetingType': meetingType,
        'description': description,
        'callLinkSource': callLinkSource,
        'callLink': callLink,
        'isReschedule': isReschedule,
        'timeZone': timeZone,
      },
      'participants': participants,
      'user': {
        'userId': userId,
        'userName': userName,
      },
      'customer': {
        'customerId': customerId,
        'customerName': customerName,
      },
      'status': status,
      'meetingDetails': {
        'meetingId': meetingId,
        'meetingUrl': meetingUrl,
        'meetingPassword': meetingPassword,
        'meetingType': meetingTypeFromDetails,
      },
    };
  }
}