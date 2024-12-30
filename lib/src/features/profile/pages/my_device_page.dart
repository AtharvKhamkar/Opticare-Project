// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import '../../../core/constants/constants.dart';
// import 'package:vizzhy/src/presentation/widgets/custom_app_bar.dart';

// class MyDevicesPage extends StatelessWidget {
//   const MyDevicesPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     bool CGMswitch = false;
//     bool appleSwitch = true;
//     return Scaffold(
//         backgroundColor: Colors.transparent,
//         appBar: const CustomAppBar(title: "My Device"),
//         body: Container(
//           margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//           padding: const EdgeInsets.all(2),
//           decoration: const BoxDecoration(
//             color: Color.fromRGBO(
//                 95, 87, 113, 0.16), // Apply background color with opacity
//             borderRadius: BorderRadius.all(Radius.circular(8)),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               _buildMyDevicesOptions(
//                   CupertinoSwitch(value: CGMswitch, onChanged: (bool value) {}),
//                   "CGM",
//                   "ID: 7th4769gtj"),
//               _buildMyDevicesOptions(
//                   CupertinoSwitch(
//                       value: appleSwitch, onChanged: (bool value) {}),
//                   "Apple Watch",
//                   null)
//             ],
//           ),
//         ));
//   }
// }

// Widget _buildMyDevicesOptions(
//     CupertinoSwitch? cupertinoSwitch, String title, String? subtitle) {
//   return SizedBox(
//       child: Column(
//     children: [
//       ListTile(
//           minVerticalPadding: 0,
//           title: Text(title, style: TextStyles.headLine2),
//           subtitle: subtitle != null
//               ? Text(subtitle, style: TextStyles.headLine3)
//               : null,
//           onTap: () {},
//           trailing: cupertinoSwitch),
//       const Divider(
//         thickness: 0.1,
//       )
//     ],
//   ));
// }
