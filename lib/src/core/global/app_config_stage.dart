// ignore_for_file: non_constant_identifier_names

import 'package:vizzhy/src/core/global/app_config_abstract.dart';

///This class contains all the Base URLs and ApiKeys of the microservices in the dev enviroment
class AppConfigStage extends AppConfig {
  //Stage BASE URLS
  @override
  String get LOGIN_BASE_URL =>
      "https://opticare-login-service.wizardstech.in/v1/";

  @override
  String get ONBOARDING_BASE_URL =>
      "https://opticare-onboarding-service.wizardstech.in/v1/";

  @override
  String get APPOINTMENT_BASE_URL =>
      "https://opticare-appointment-service.wizardstech.in/v1/";

  @override
  String get REPORTS_BASE_URL =>
      "https://opticare-labreport-service.wizardstech.in/v1/";

  @override
  String get CARE_PLAN_BASE_URL =>
      "https://opticare-careplan-service.wizardstech.in/v1/";

  @override
  String get CUSTOMER_SERVICE_BASE_URL =>
      "https://opticare-customer-service.wizardstech.in/v1/";

  @override
  String get MEALS_SERVICE_BASE_URL =>
      "https://opticare-meal-service.wizardstech.in/v1/";

  @override
  String get IOT_BASE_URL =>
      "https://opticare-customer-iot-service.wizardstech.in/v1/";

  @override
  String get CONVERSATION_BASE_URL =>
      "https://opticare-conversation-service.wizardstech.in/v1/";

  //API keys
  @override
  String get loginServiceApiKey =>
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjbGllbnQiOiJPUFRJQ0FSRSIsImFwcGxpY2F0aW9uIjoiTE9HSU4tQVBJIiwiZW52IjoiU1RBR0UiLCJpYXQiOjE3MzMyOTgyNzF9.jRV2cHRguzQPowT1M3puCQ4gAqqjp0aVW78P9l0WcXU";

  @override
  String get onboardingServiceApiKey =>
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjbGllbnQiOiJWSVpaSFkiLCJhcHBsaWNhdGlvbiI6Ik9OQk9BUkRJTkctQVBJIiwiZW52IjoiU1RBR0UiLCJpYXQiOjE3MzMyOTk1NTd9.EfOIzyr54bJIujGEZbvrL0P5mY5KLyUDQUDxum9PJ2o";

  @override
  String get appointmentServiceApiKey =>
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjbGllbnQiOiJPUFRJQ0FSRSIsImFwcGxpY2F0aW9uIjoiQVBQT0lOVE1FTlQtQVBJIiwiZW52IjoiU1RBR0UiLCJpYXQiOjE3MzMzMDQwMTd9.IaRRS-M8N2vuUMc65L3RTu66o3NQHbxmiYk6oE2O9GA";

  @override
  String get labReportServiceApiKey =>
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjbGllbnQiOiJWSVpaSFkiLCJhcHBsaWNhdGlvbiI6IkxBQi1SRVBPUlQtQVBJIiwiZW52IjoiU1RBR0UiLCJpYXQiOjE3MzMzMDY2NDN9.MOgFH9rOkqmeZJ2Uh4orQtKDtV6WbPdPdsO5NZ1Lf54";

  @override
  String get carePlanServiceApiKey =>
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjbGllbnQiOiJPUFRJQ0FSRSIsImFwcGxpY2F0aW9uIjoiQ0FSRVBMQU4tQVBJIiwiZW52IjoiU1RBR0UiLCJpYXQiOjE3MzMzMDk3MDB9.9pxCFJ88qi_jzCKOeVdu8NUQo2IPsRnQRyLIVKeq16A";

  @override
  String get customerService =>
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjbGllbnQiOiJPUFRJQ0FSRSIsImFwcGxpY2F0aW9uIjoiQ1VTVE9NRVItQVBJIiwiZW52IjoiU1RBR0UiLCJpYXQiOjE3MzMzMTEwMDN9.TBR2QzRVHDN44F3Hz-PWK9ulg3sFZV0d1vL2lPCu7Qw";

  @override
  String get mealsService =>
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjbGllbnQiOiJPUFRJQ0FSRSIsImFwcGxpY2F0aW9uIjoiTUVBTC1TRVJJVkUtQVBJIiwiZW52IjoiU1RBR0UiLCJpYXQiOjE3MzMzMTIwOTV9.9FpDyUgWwHcm56sUNv79CD188mTOR1XXUHZH01-aKHY";

  @override
  String get iotServiceKey =>
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjbGllbnQiOiJPUFRJQ0FSRSIsImFwcGxpY2F0aW9uIjoiSU9ULUFQSSIsImVudiI6IlNUQUdFIiwiaWF0IjoxNzMzMzEyOTY1fQ.ojQnmpGyP5M-qI2Sb74uKQWVfYCIPF2bLUM1fYNVZzs";

  @override
  String get conversationServiceApiKey =>
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjbGllbnQiOiJPUFRJQ0FSRSIsImFwcGxpY2F0aW9uIjoiQ09OVkVSU0FUSU9OLUFQSSIsImVudiI6IlNUQUdFIiwiaWF0IjoxNzMzMzEzODE1fQ.muDF9F8_FsL7K8hX6Xm1PwIf5hE2Hm2_eP884uPSVVI";

  @override
  String get VFS_BASE_URL => "https://dev-vfs-food-api.vizzhy.in/";

  @override
  String get termsCondition => "https://vizzhy.in/terms-and-conditions.html";

  @override
  String get faqUrl => "https://vizzhy.in/faq.html";

  @override
  String get vizzhyUrl => "https://www.vizzhy.com/";
}
