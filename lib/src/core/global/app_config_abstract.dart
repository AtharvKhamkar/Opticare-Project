// ignore_for_file: public_member_api_docs, non_constant_identifier_names

///This is a abstract class of the Config file contails base URLs and API keys of different micro services
abstract class AppConfig {
  String get LOGIN_BASE_URL;
  String get ONBOARDING_BASE_URL;
  String get APPOINTMENT_BASE_URL;
  String get REPORTS_BASE_URL;
  String get CARE_PLAN_BASE_URL;
  String get CUSTOMER_SERVICE_BASE_URL;
  String get MEALS_SERVICE_BASE_URL;
  String get IOT_BASE_URL;
  String get VFS_BASE_URL;
  String get CONVERSATION_BASE_URL;

  String get loginServiceApiKey;
  String get onboardingServiceApiKey;
  String get appointmentServiceApiKey;
  String get labReportServiceApiKey;
  String get carePlanServiceApiKey;
  String get customerService;
  String get mealsService;
  String get iotServiceKey;
  String get conversationServiceApiKey;

  String get termsCondition;
  String get vizzhyUrl;
  String get faqUrl;
}
