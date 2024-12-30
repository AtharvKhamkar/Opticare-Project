import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:vizzhy/src/data/local_storage/app_storage.dart';
import 'package:vizzhy/src/features/auth/controllers/auth_controller.dart';
import 'package:vizzhy/src/features/auth/pages/login_screen.dart';

import '../../../core/constants/constants.dart';

///This is splash screen, Splash screen is displayed while initializing app for 3 sec meantime login process is done
class SplashScreen extends StatefulWidget {
  ///constructor of the SplashScreen
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthController authController =
      AuthController().initialized ? Get.find() : Get.put(AuthController());

  @override
  void initState() {
    super.initState();
    // Future.delayed(const Duration(seconds: 3), () async {
    //   await SembastDB.initSembastDB();
    //   bool userLoggedIn = await loginController.checkUserLoggedIn();
    //   if (userLoggedIn) {
    //     Get.toNamed('/conversation');
    //   } else {
    //     Get.toNamed('/login');
    //   }
    // });

    // Future.delayed(const Duration(seconds: 3), () {
    //   Get.offAll(() => const LoginScreen(), binding: AuthBinding());
    // });

    Future.delayed(
      const Duration(seconds: 3),
      () async {
        debugPrint(AppStorage.isLoggedIn().toString());
        if (AppStorage.isLoggedIn()) {
          Map<String, dynamic>? credentials = AppStorage.getUserCredentials();
          if (credentials != null) {
            String? userName = credentials['userName'];
            String? password = credentials['password'];
            authController.userNameController.text = userName ?? "";
            authController.passwordController.text = password ?? "";
            authController.login();
          } else {
            Get.offAll(
              () => const MainBackgroundWrapper(page: LoginScreen()),
              binding: AuthBinding(),
            );
          }
        } else {
          Get.offAll(
            () => const MainBackgroundWrapper(page: LoginScreen()),
            binding: AuthBinding(),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const Spacer(),
            SizedBox(
              height: Get.height * 0.1,
            ),
            const Spacer(),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
