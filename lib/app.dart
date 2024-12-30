import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vizzhy/src/core/constants/constants.dart';
import 'package:vizzhy/src/presentation/widgets/custom_toast_util.dart';
import 'package:vizzhy/src/features/auth/pages/splash_screen.dart';
import 'package:vizzhy/src/services/vizzhy_context_service.dart';

import 'src/core/Routes/app_routes.dart';

/// init flutter app
class MyApp extends StatelessWidget {
  /// contructor
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    CustomToastUtil.init(context);
    // VizzhyAppInfo.getInfoOfApp();

    return GetMaterialApp(
      navigatorKey: VizzhyContextService.navigatorKey,
      title: 'Opti Care Application',
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        primaryColorDark: AppColors.primaryColorDark,
        primaryColorLight: AppColors.primaryColorLight,
        scaffoldBackgroundColor: AppColors.backgroundColor,
        appBarTheme: const AppBarTheme(color: AppColors.primaryColor),
        buttonTheme: const ButtonThemeData(
            buttonColor: AppColors.primaryColor,
            textTheme: ButtonTextTheme.primary),
        textTheme: const TextTheme(bodySmall: TextStyles.defaultText),
        useMaterial3: true,
      ),
      home: const MainBackgroundWrapper(
        page: SplashScreen(),
      ),
      initialRoute: AppRoutes.initial,
      getPages: AppRoutes.routes,
    );
  }
}
