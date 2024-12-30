// import 'dart:async';

// import 'package:app_links/app_links.dart';
// import 'package:flutter/material.dart';
// import 'constants.dart';

// class DynamicLinkService {
//   StreamSubscription<Uri>? linkSubscription;
//   openAppLink({NavigatorState? navigator, required int foreGroundCount}) async {
//     final appLinks = AppLinks();
//     final initialLink = await appLinks.getInitialAppLink();

//     if (initialLink != null &&
//         !(initialLink.toString().contains('google')) &&
//         foreGroundCount == 1) {
//       debugPrint("${initialLink}iniiittt");
//       navigateScreen(navigator, initialLink);
//     }

//     // Handle link when app is in warm state (front or background)
//     linkSubscription = appLinks.uriLinkStream.listen((uri) {
//       debugPrint("${uri}uriiii");

//       navigateScreen(navigator, uri);
//     });
//   }
//   // send this file to me

//   void navigateScreen(NavigatorState? navigator, Uri uri) {
//     String? link = "";
//     if (uri.queryParameters["link"] != null) {
//       link = uri.queryParameters["link"];
//     } else {
//       link = uri.toString();
//     }
//     Uri appLink = Uri.parse(link!);
//     if (appLink.path == PasswordScreen.route) {
//       navigator?.pushNamedAndRemoveUntil(
//         appLink.path,
//         (r) => false,
//         arguments: PasswordScreenArgs(
//             passwordType: PasswordType.newPassword,
//             token: appLink.queryParameters['token'].toString(),
//             uri: appLink.toString(),
//             termsAndPolicy:
//                 appLink.queryParameters['terms_and_policy_required'] ==
//                     Strings.trueString),
//       );
//     } else if (appLink.path == "/baau/verification") {
//       navigator?.pushNamed(BankBauOtpScreen.route,
//           arguments: BankBauOtpScreenArgs(
//               email: appLink.queryParameters['email'].toString()));
//     } else if (appLink.path == BauVerifyMailScreen.route) {
//       navigator?.pushNamed(BauVerifyMailScreen.route,
//           arguments: BankBauOtpScreenArgs(mst: appLink.queryParameters['mst']));
//     }
//   }
// }
