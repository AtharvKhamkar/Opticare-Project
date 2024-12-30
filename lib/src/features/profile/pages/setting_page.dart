import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vizzhy/src/core/constants/Colors/app_colors.dart';
import 'package:vizzhy/src/core/constants/fonts/text_styles.dart';
import 'package:vizzhy/src/presentation/widgets/custom_app_bar.dart';

///This screen is used display different setting options
class SettingsScreen extends StatefulWidget {
  ///Constructor of the settingsScreen
  const SettingsScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _faceIdSwitchValue = false;
  bool _mpinSwitchValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.darkBackgroundColor,
        appBar: const CustomAppBar(
          title: "Settings",
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              _settingOptions(),
            ],
          ),
        ));
  }

  Widget _settingOptions() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      padding: const EdgeInsets.all(2),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(
            95, 87, 113, 0.16), // Apply background color with opacity
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Column(
        children: [
          _buildSettingOptions(null, "Language Preference", "English"),
          _buildSettingOptions(
            CupertinoSwitch(
              value: _faceIdSwitchValue,
              onChanged: (bool value) {
                setState(() {
                  _faceIdSwitchValue = value;
                });
              },
            ),
            "Face ID",
            null,
          ),
          _buildSettingOptions(
              CupertinoSwitch(
                value: _mpinSwitchValue,
                onChanged: (bool value) {
                  setState(() {
                    _mpinSwitchValue = value;
                  });
                },
              ),
              "MPIN",
              null,
              showDivider: false),
          // _buildSettingOptions(null, "Delete Account", null,
          //     showDivider: false),
        ],
      ),
    );
  }

  Widget _buildSettingOptions(
      CupertinoSwitch? cupertinoSwitch, String title, String? subtitle,
      {bool showDivider = true}) {
    return SizedBox(
      width: Get.width,
      child: Column(
        children: [
          ListTile(
            minVerticalPadding: 0,
            title: Text(title, style: TextStyles.headLine2),
            onTap: () {},
            trailing: cupertinoSwitch ??
                (subtitle != null
                    ? Text(
                        subtitle,
                        style: TextStyles.headLine3,
                      )
                    : null),
          ),
          if (showDivider)
            const Divider(
              thickness: 0.1,
            )
        ],
      ),
    );
  }
}
