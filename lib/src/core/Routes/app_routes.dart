import 'package:get/get.dart';
import 'package:vizzhy/src/features/appointments/controllers/appointments_controller.dart';
import 'package:vizzhy/src/features/appointments/pages/appointment_page.dart';
import 'package:vizzhy/src/features/auth/controllers/auth_controller.dart';
import 'package:vizzhy/src/features/auth/pages/change_password.dart';
import 'package:vizzhy/src/features/auth/pages/forgot_password_screen.dart';
import 'package:vizzhy/src/features/auth/pages/login_screen.dart';
import 'package:vizzhy/src/features/auth/pages/mpin_setup_screen.dart';
import 'package:vizzhy/src/features/auth/pages/mpin_success_screen.dart';
import 'package:vizzhy/src/features/auth/pages/otp_success_screen.dart';
import 'package:vizzhy/src/features/auth/pages/otp_verification_screen.dart';
import 'package:vizzhy/src/features/auth/pages/set_password_screen.dart';
import 'package:vizzhy/src/features/auth/pages/set_password_success.dart';
import 'package:vizzhy/src/features/auth/pages/splash_screen.dart';
import 'package:vizzhy/src/features/conversation/presentation/controller/conversation_controller.dart';
import 'package:vizzhy/src/features/conversation/presentation/controller/meal_input_controller.dart';
import 'package:vizzhy/src/features/conversation/presentation/pages/conversation_screen.dart';
import 'package:vizzhy/src/features/conversation/presentation/pages/speech_to_text_screen.dart';
import 'package:vizzhy/src/features/conversation/presentation/pages/foodlog_vizzhy_ai_screen.dart';
import 'package:vizzhy/src/features/insights/controllers/insights_controller.dart';
import 'package:vizzhy/src/features/insights/pages/add_meal_name_screen.dart';
import 'package:vizzhy/src/features/insights/pages/add_meal_quantity_screen.dart';
import 'package:vizzhy/src/features/insights/pages/add_meal_time_screen.dart';
import 'package:vizzhy/src/features/insights/pages/edit_meal_screen.dart';
import 'package:vizzhy/src/features/insights/pages/food_log_screen.dart';
import 'package:vizzhy/src/features/insights/pages/care_plan_screen.dart';
import 'package:vizzhy/src/features/insights/pages/meal_insights_screen.dart';
import 'package:vizzhy/src/features/metabolic_health/presentation/controller/metabolic_controller.dart';
import 'package:vizzhy/src/features/metabolic_health/presentation/pages/metabolic_score_page.dart';
import 'package:vizzhy/src/features/profile/controllers/profile_controller.dart';
import 'package:vizzhy/src/features/reports/controllers/pdf_controller.dart';
import 'package:vizzhy/src/features/reports/pages/external_reports_page.dart';
import 'package:vizzhy/src/features/reports/pages/reports_page.dart';
import 'package:vizzhy/src/features/reports/pages/vizzhy_reports_page.dart';
import 'package:vizzhy/src/features/support/presentation/pages/caregiver_support_page.dart';
import 'package:vizzhy/src/features/support/presentation/pages/help_support_page.dart';
import 'package:vizzhy/src/features/support/presentation/pages/security_page.dart';
import 'package:vizzhy/src/features/support/presentation/pages/technical_support_page.dart';
import 'package:vizzhy/src/features/vizzhy_ai/controllers/vizzhy_ai_chat_history_controller.dart';
import 'package:vizzhy/src/features/vizzhy_ai/presentation/chat_history_screen.dart';
import '../../features/profile/pages/personal_details_page.dart';
import '../../features/profile/pages/profile_page.dart';
import '../../features/profile/pages/setting_page.dart';
import '../constants/Colors/main_background_wrapper.dart';

///This file contains all the routes which are used in the application
class AppRoutes {
  AppRoutes._();

  ///Initial route of the application
  static const initial = '/splash-screen';
  static const String login = '/login';
  static const String profile = '/profile';
  static const String setting = '/setting';
  static const String profileDetails = '/profile-details';
  static const String reports = '/reports';
  static const String vizzhyReports = '/vizzhy-reports';
  static const String externalReports = '/external-reports';
  static const String carePlan = '/care-plan';
  static const String foodLog = '/food-log';
  static const String speechToText = '/speech-to-text';
  static const String foodLogVizzhyAI = '/vizzhyAI';
  static const String metabolicScore = '/metabolic-score';
  static const String helpSupport = '/help-support';
  static const String security = '/security';
  static const String technicalSupport = '/technical-support';
  static const String caregiverSupport = '/caregiver-support';
  static const String chatHistory = '/chat-history';
  static const String appointment = '/appointment';
  static const String addMealTime = '/add-meal-time';
  static const String addMealName = '/add-meal-name';
  static const String addMealQuantity = '/add-meal-quantity';
  static const String editMeal = '/editMeal';
  static const String mealInsights = '/mealInsights';
  static const String setPassword = '/set-password';
  static const String setPasswordSuccess = '/setPasswordSuccess';
  static const String forgotPassword = '/forgotPassword';
  static const String otpVerification = '/otp-verification';
  static const String mpinSetup = '/mpin-setup';
  static const String otpSuccess = '/otp-success';
  static const String mpinSuccess = '/mpin-success';
  static const String changePassword = '/change-password';

  ///routes array
  static final routes = [
    GetPage(
      name: '/splash-screen',
      page: () => const MainBackgroundWrapper(page: SplashScreen()),
    ),
    GetPage(
      name: '/login',
      page: () => const MainBackgroundWrapper(
        page: LoginScreen(),
      ),
      binding: AuthBinding(),
    ),
    GetPage(
        name: '/profile',
        page: () => const MainBackgroundWrapper(page: ProfilePage()),
        binding: ProfileBinding(),
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
      name: '/setting',
      page: () => const MainBackgroundWrapper(page: SettingsScreen()),
    ),
    GetPage(
      name: '/profile-details',
      page: () => const MainBackgroundWrapper(page: PersonalDetailsPage()),
    ),
    GetPage(
        name: '/reports',
        page: () => MainBackgroundWrapper(
              page: ReportsPage(),
            ),
        binding: PdfBindings()),
    GetPage(
      name: '/vizzhy-reports',
      page: () => MainBackgroundWrapper(page: VizzhyReportsPage()),
      binding: PdfBindings(),
    ),
    GetPage(
      name: '/external-reports',
      page: () => MainBackgroundWrapper(page: ExternalReportsPage()),
      binding: PdfBindings(),
    ),
    GetPage(
      name: '/care-plan',
      page: () => MainBackgroundWrapper(page: CarePlan()),
      binding: InsightsBinding(),
    ),
    GetPage(
      name: '/food-log',
      page: () => const MainBackgroundWrapper(page: FoodLogScreen()),
      binding: MealsInputBindings(),
    ),
    GetPage(
        name: '/conversation',
        page: () => const MainBackgroundWrapper(page: ConversationScreen()),
        binding: ConversationBindings()),
    GetPage(
        name: '/speech-to-text',
        page: () => const MainBackgroundWrapper(page: SpeechToTextScreen()),
        transition: Transition.noTransition,
        binding: ConversationBindings()),
    GetPage(
        name: '/vizzhyAI',
        page: () => const MainBackgroundWrapper(page: FoodlogVizzhyAiScreen()),
        transition: Transition.noTransition,
        bindings: [ConversationBindings(), MealsInputBindings()]),
    GetPage(
        name: '/metabolic-score',
        page: () => const MainBackgroundWrapper(
              page: MetabolicScorePage(),
            ),
        binding: MetabolicScoreBindings()),
    GetPage(
      name: '/help-support',
      page: () => const MainBackgroundWrapper(page: HelpSupportPage()),
    ),
    GetPage(
      name: '/security',
      page: () => const MainBackgroundWrapper(page: SecurityPage()),
    ),
    GetPage(
      name: '/technical-support',
      page: () => const MainBackgroundWrapper(page: TechnicalSupportPage()),
    ),
    GetPage(
      name: '/caregiver-support',
      page: () => const MainBackgroundWrapper(page: CaregiverSupportPage()),
    ),
    GetPage(
        name: '/chat-history',
        page: () => const MainBackgroundWrapper(
              page: ChatHistoryScreen(),
            ),
        binding: VizzhyAiChatHistoryBinding()),
    GetPage(
      name: '/appointment',
      page: () => const MainBackgroundWrapper(page: AppointmentsPage()),
      binding: AppointmentsBinding(),
    ),
    GetPage(
        name: '/add-meal-time',
        page: () => const MainBackgroundWrapper(
              page: AddMealTimeScreen(),
            ),
        binding: MealsInputBindings()),
    GetPage(
        name: '/add-meal-name',
        page: () => const MainBackgroundWrapper(
              page: AddMealNameScreen(),
            ),
        binding: MealsInputBindings()),
    GetPage(
        name: '/add-meal-quantity',
        page: () => const MainBackgroundWrapper(
              page: AddMealQuantityScreen(),
            ),
        binding: MealsInputBindings()),
    GetPage(
        name: '/editMeal',
        page: () => MainBackgroundWrapper(
              page: EditMealScreen(
                foodName: Get.arguments['foodName'],
                quantity: Get.arguments['quantity'],
                portion: Get.arguments['portion'],
                time: Get.arguments['time'],
                mealDate: Get.arguments['mealDate'],
                cmiDetailsId: Get.arguments['cmiDetailsId'],
              ),
            ),
        binding: MealsInputBindings()),
    GetPage(
        name: '/mealInsights',
        page: () => MainBackgroundWrapper(
              page: MealInsightsScreen(
                text: Get.arguments['text'],
                time: Get.arguments['time'],
                mealType: Get.arguments['mealType'],
                quantity: Get.arguments['quantity'],
                unit: Get.arguments['unit'],
                calories: Get.arguments['calories'],
                mealDate: Get.arguments['mealDate'],
                cmiDetailsId: Get.arguments['cmiDetailsId'],
              ),
            ),
        binding: MealsInputBindings()),
    GetPage(
      name: '/set-password',
      page: () => const MainBackgroundWrapper(
        page: SetPasswordScreen(),
      ),
      binding: AuthBinding(),
    ),
    GetPage(
      name: '/set-password-success',
      page: () => const MainBackgroundWrapper(
        page: SetPasswordSuccessScreen(redirectScreenPath: '/forgot-password'),
      ),
    ),
    GetPage(
      name: '/forgot-password',
      page: () => MainBackgroundWrapper(
        page: ForgotPasswordScreen(),
      ),
    ),
    GetPage(
      name: '/otp-verification',
      page: () => MainBackgroundWrapper(
        page: OtpVerificationScreen(),
      ),
    ),
    GetPage(
      name: '/mpin-setup',
      page: () => const MainBackgroundWrapper(
        page: MpinSetupScreen(),
      ),
    ),
    GetPage(
      name: '/otp-success',
      page: () => const MainBackgroundWrapper(
        page: OtpSuccessScreen(
          redirectScreenPath: 'mpin-setup',
        ),
      ),
    ),
    GetPage(
      name: '/mpin-success',
      page: () => const MainBackgroundWrapper(
        page: MpinSuccessScreen(
          redirectScreenPath: '/conversation',
        ),
      ),
    ),
    GetPage(
        name: '/change-password',
        page: () => const MainBackgroundWrapper(page: ChangePassword()),
        binding: AuthBinding())
  ];
}
