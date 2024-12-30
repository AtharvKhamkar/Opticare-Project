import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vizzhy/src/core/global/app_dialog_handler.dart';
import 'package:vizzhy/src/data/local_storage/app_storage.dart';
import 'package:vizzhy/src/presentation/widgets/menu_option.dart';
import 'package:vizzhy/src/features/profile/controllers/profile_controller.dart';
import 'package:vizzhy/src/features/try_terra/presentation/pages/try_terra_connect_page.dart';
import 'package:vizzhy/src/services/vizzhy_app_info.dart';

import '../../../../flavors.dart';
import '../../../core/constants/constants.dart';
import 'package:vizzhy/src/presentation/widgets/custom_app_bar.dart';

///This screen is used to display different profile options and features like a menu page
class ProfilePage extends StatelessWidget {
  ///Constructor the ProfilePage
  const ProfilePage({super.key, this.userNameColor});
  final Color? userNameColor;

  @override
  Widget build(BuildContext context) {
    debugPrint('profile page width :  ${MediaQuery.sizeOf(context).width}');
    return Scaffold(
      backgroundColor: AppColors.darkBackgroundColor,
      appBar: const CustomAppBar(
        title: "Profile Settings",
      ),
      body: GetBuilder<ProfileController>(
        builder: (controller) {
          return controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ),
                )
              : LayoutBuilder(builder: (context, constraints) {
                  return SingleChildScrollView(
                    // scrollDirection: Axis.vertical,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _profileInfo(
                            '${controller.profile.value.firstName} ${controller.profile.value.lastName}',
                            controller.profile.value.uniqueCustomerId),
                        SizedBox(height: Get.height * 0.04),
                        _profileOptions(constraints),
                        const SizedBox(
                          height: 20,
                        ),
                        FutureBuilder(
                            future: VizhhyAppInfoService.getAppVersion(),
                            builder: (context, snapshot) {
                              return Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  '${snapshot.data}, ${F.appFlavor == Flavor.prod ? '' : F.name.toUpperCase()}',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              );
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  );
                });
        },
      ),
    );
  }
}

Widget _profileOptions(BoxConstraints constraints) {
  const String assetPath = 'assets/images/profile';
  // final getHeight = Get.height;
  // final getWidth = Get.width;

  // final screenHeight = getWidth > getHeight ? getWidth : getHeight;
  // final screenWidth = getWidth < getHeight ? getWidth : getHeight;

  final menuOptionsList = [
    MenuOption(
        assetPath: '$assetPath/person.svg',
        title: 'Personal Information',
        onClick: () async {
          await Get.toNamed('/profile-details');
        }),
    MenuOption(
        assetPath: '$assetPath/devices.svg',
        title: 'My Devices',
        onClick: () async {
          await Get.to(TryTerraConnectPage(
            customerId: AppStorage.getUserId(),
          ));
        }),
    MenuOption(
        assetPath: '$assetPath/appointment.svg',
        title: 'Appointments',
        onClick: () async {
          await Get.toNamed('/appointment');
        }),
    MenuOption(
        assetPath: '$assetPath/carePlan.svg',
        title: 'Care Plan',
        onClick: () async {
          await Get.toNamed('/care-plan');
        }),
    MenuOption(
        assetPath: '$assetPath/info.svg',
        title: 'Metabolic Health Score',
        onClick: () async {
          await Get.toNamed('/metabolic-score');
        }),
    MenuOption(
        assetPath: '$assetPath/reports.svg',
        title: 'Reports',
        onClick: () async {
          await Get.toNamed('/reports');
        }),
    MenuOption(
        assetPath: '$assetPath/history.svg',
        title: 'Food Logs',
        onClick: () async {
          await Get.toNamed('/food-log');
        }),
    // MenuOption(
    //     assetPath: '$assetPath/support_agent.svg',
    //     title: 'Caregiver Support',
    //     onClick: () async {
    //       await Get.toNamed('/caregiver-support');
    //     }),
    MenuOption(
        assetPath: '$assetPath/chat_history.svg',
        title: 'Chat History',
        onClick: () async {
          await Get.toNamed('/chat-history');
        }),
    MenuOption(
        assetPath: '$assetPath/help_center.svg',
        title: 'Help',
        onClick: () async {}),
    MenuOption(
        assetPath: '$assetPath/security.svg',
        title: 'Security',
        onClick: () async {}),
    // MenuOption(
    //     assetPath: '$assetPath/lock.svg',
    //     title: 'App Lock',
    //     onClick: () async {
    //       await Get.toNamed('/setting');
    //     }),
    // MenuOption(
    //   assetPath: '$assetPath/setting.svg',
    //   title: 'Onboarding Flow',
    //   onClick: () async {
    //     await Get.toNamed('/otp-verification');
    //   },
    // ),
    MenuOption(
      assetPath: '$assetPath/logout.svg',
      title: 'Logout',
      onClick: () async {
        AppDialogHandler.logoutBottomSheet();
      },
    ),
  ];

  return Wrap(children: menuOptionsList);
}

Widget _profileInfo(String userName, String userId) {
  return SizedBox(
    width: Get.width * 0.5,
    child: Column(
      children: [
        SizedBox(
          height: Get.height * 0.03,
        ),
        Stack(
          children: [
            Hero(
              tag: 'profileImage',
              // child: Icon(Icons.person),
              child: CircleAvatar(
                // backgroundImage:
                //     AssetImage('assets/images/profile/boyProfilePic.png'),

                radius: 40,
                child: userName.isEmpty
                    ? const Icon(
                        Icons.person,
                        size: 30,
                      )
                    : Text(userName.substring(0, 1).toUpperCase(),
                        style: TextStyles.titles.copyWith(color: Colors.black)),
              ),
            ),

            // Positioned(
            //   right: 0,
            //   bottom: 0,
            //   child: CircleAvatar(
            //     backgroundColor: AppColors.primaryColor,
            //     radius: 14,
            //     child: SvgPicture.asset('assets/images/profile/editIcon.svg'),
            //   ),
            // ),
          ],
        ),
        SizedBox(
          height: Get.height * 0.03,
        ),
        Text(
          userName,
          style: TextStyles.headLine2,
        ),
        SizedBox(
          height: Get.height * 0.001,
        ),
        Text(userId, style: TextStyles.headLine5)
      ],
    ),
  );
}
