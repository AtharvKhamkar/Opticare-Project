// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../../core/constants/constants.dart';

// class MealInputBox extends StatelessWidget {
//   final String text;
//   final String time;

//   const MealInputBox({
//     super.key,
//     required this.text,
//     required this.time,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.centerLeft,
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
//         width: Get.width * 0.75,
//         padding: const EdgeInsets.all(12),
//         // Adjust padding if needed
//         decoration: BoxDecoration(
//             borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(12),
//               topRight: Radius.circular(12),
//               bottomLeft: Radius.circular(0),
//               bottomRight: Radius.circular(12),
//             ),
//             border: Border.all(width: 1, color: Colors.transparent),
//             color: const Color(0xff393444)
//             // gradient: const LinearGradient(
//             //   begin: Alignment.topLeft,
//             //   end: Alignment.bottomRight,
//             //   colors: [
//             //     Color(0x3d4238d2),
//             //     Color(0x16a83062),
//             //     Color(0x05c159e),
//             //   ],
//             //   stops: [0.3, 1.0, 0.8],
//             // ),
//             ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               text,
//               style: TextStyles.headLine2,
//               textAlign: TextAlign.left,
//             ),
//             const SizedBox(height: 4),
//             Align(
//               alignment: Alignment.bottomRight,
//               child: Text(
//                 time,
//                 style: const TextStyle(
//                   fontSize: 12,
//                   color: Colors.grey,
//                 ),
//                 textAlign: TextAlign.left,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
