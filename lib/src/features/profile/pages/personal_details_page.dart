import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vizzhy/src/features/profile/controllers/profile_controller.dart';

import '../../../core/constants/constants.dart';
import 'package:vizzhy/src/presentation/widgets/custom_app_bar.dart';

///This screen is used to display personal details of the customer
class PersonalDetailsPage extends StatelessWidget {
  ///Constructor of the PersonalDetailsPage
  const PersonalDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackgroundColor,
      appBar: const CustomAppBar(title: "Personal Information"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: GetBuilder<ProfileController>(
          builder: (controller) {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  controller.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: Get.height * 0.065,
                              ),
                              Text(
                                'Personal Details',
                                style: TextStyles.headLine2.copyWith(
                                    fontSize: 22, fontWeight: FontWeight.w600),
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(
                                height: Get.height * 0.02,
                              ),
                              _buildProfileOptions("First Name",
                                  controller.profile.value.firstName),
                              _buildProfileOptions("Last Name",
                                  controller.profile.value.lastName),
                              _buildProfileOptions("Email Address",
                                  controller.profile.value.email),
                              _buildProfileOptions("Mobile Number",
                                  controller.profile.value.phone),
                              _buildProfileOptions(
                                  "Gender", controller.profile.value.gender),
                              _buildProfileOptions("Date of Birth",
                                  controller.profile.value.dateOfBirth),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              Text(
                                'Current Address',
                                style: TextStyles.headLine2.copyWith(
                                    fontSize: 22, fontWeight: FontWeight.w600),
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              _buildProfileOptions(
                                  "Address", controller.profile.value.address,
                                  showDivider: false),
                            ],
                          ),
                        ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

Widget _buildProfileOptions(String title, String value,
    {bool showDivider = true}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyles.headLine5,
              textAlign: TextAlign.left,
            ),
            const SizedBox(width: 8),
            Text(value,
                style: TextStyles.headLine2
                    .copyWith(fontSize: 18, fontWeight: FontWeight.w400),
                softWrap: true)
          ],
        ),
        if (showDivider)
          const Divider(
            thickness: 0.1,
          )
      ],
    ),
  );
}
