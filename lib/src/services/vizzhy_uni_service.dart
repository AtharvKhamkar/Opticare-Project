// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:uni_links/uni_links.dart';
// import 'package:vizzhy/src/data/models/cached_error_model.dart';
// import 'package:vizzhy/src/presentation/widgets/custom_toast_util.dart';
// import 'package:vizzhy/src/services/vizzhy_firebase_service.dart';

// /// use this class for DEEP-Linking
// class VizzhyFirebaseUniService {
//   //private variable
//   static String _code = '';

//   /// return bool whether code is present or not
//   static bool get hasCode => _code.isNotEmpty;

//   /// code
//   static String get code => _code;

//   /// reset code to empty. code = ''
//   static void reset() => _code = '';

//   /// call this method in main file
//   /// to initialize and listen about url changes
//   static Future<void> init() async {
//     try {
//       final Uri? url = await getInitialUri();
//       await uniLinkHandler(url);

//       uriLinkStream.listen((onData) async {
//         if (onData == null || onData.path.isEmpty) {
//           return;
//         }
//         await uniLinkHandler(onData);
//       }, onError: (ee) {
//         debugPrint("Error occured while handeling url : $ee");
//       });
//     } on PlatformException catch (e) {
//       debugPrint('platform exception while getting url :$e');
//     } on FormatException catch (e) {
//       debugPrint('Format exception while getting url :$e');
//     } catch (e) {
//       debugPrint("Exception occured  : $e");
//     }
//   }

//   /// handle your url
//   /// check information about url
//   /// and navigate user to specific page in the apps
//   static uniLinkHandler(Uri? url) {
//     if (url == null || url.queryParameters.isEmpty) {
//       return;
//     }

//     debugPrint("my my someone is navigated in our app from outside : $url");
//     // Permission.
//     final Map<String, String> urlParams = url.queryParameters;

//     final String userId = urlParams['user_id'] ?? '';
//     final String resource = urlParams['resource'] ?? '';
//     final String referenceId = urlParams['reference_id'] ?? '';

//     Get.offAllNamed('/profile');
//     if (userId.isEmpty || referenceId.isEmpty) {
//       // CustomToastUtil.showToast(message: 'something went wrong');

//       VizzhyFirebaseServices().logErrorToFirestore(CachedErrorModel(
//           errorMessage: 'Either userID or erf id is empty',
//           errorStack: '''{
//         success: ${false},
//         resource from webpage : $resource,
//         user_id: $userId,
//         ref_id: $referenceId,
//       }''',
//           timestamp: DateTime.now()));
//     } else if (userId.isNotEmpty && referenceId.isNotEmpty) {
//       CustomToastUtil.showToast(
//           message: 'Connection succuess with $resource',
//           backgroundColor: Colors.green,
//           borderColor: Colors.green);
//       VizzhyFirebaseServices().logDataToFirestore({
//         "success": true,
//         "connected from webpage to ": resource,
//         "user_id": userId,
//         "ref_id": referenceId
//       });
//     } else {
//       VizzhyFirebaseServices().logErrorToFirestore(CachedErrorModel(
//           errorMessage: 'something went wrong',
//           errorStack: '''{
//         success: ${false},
//         resource from webpage : $resource,
//         user_id: $userId,
//         ref_id: $referenceId,
//       }''',
//           timestamp: DateTime.now()));
//       // CustomToastUtil.showToast(message: 'something went wrong...');

//       debugPrint(
//           "user id : $userId\n resource : $resource \n refID : $referenceId");
//     }
//   }
// }
