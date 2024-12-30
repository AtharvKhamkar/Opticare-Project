// import 'dart:isolate';

// import 'package:get/get.dart';
// import 'package:vizzhy/src/features/try_terra/list_of_subscription_model.dart';
// import 'package:vizzhy/src/features/try_terra/presentation/controllers/try_terra_controller.dart';
// import 'package:vizzhy/src/services/vizzhy_terra_service.dart';

// class VizzhyTerraIsolates {
//   final terraController = Get.find<TryTerraController>();
// // Define the function to run in an isolate
//   Future<void> checkConnectionAndGetData(
//     SendPort sendPort,
//   ) async {
//     // Receive data from the main isolate
//     final ReceivePort receivePort = ReceivePort();
//     sendPort.send(receivePort.sendPort); // Send the SendPort back

//     // Get all user list in Terra
//     final List<TryTerraUser>? terraConnectionUsers = await receivePort.first;

//     if (terraConnectionUsers == null || terraConnectionUsers.isEmpty) return;

//     checkApple(terraConnectionUsers);
//     checkSamsung(terraConnectionUsers);
//   }

//   void checkApple(List<TryTerraUser> users) {
//     TryTerraUser? appleData = users.firstWhereOrNull(
//         (userProviderList) => userProviderList.provider == 'APPLE');
//     if (appleData != null) {
//       // await SembastDB.storeIOTConnections(
//       //     Connection.appleHealth.name, appleData.userId);
//       terraController.updateIsAppleHealthConnected(true);
//     }
//   }

//   void checkSamsung(List<TryTerraUser> users) {
//     TryTerraUser? appleData = users.firstWhereOrNull(
//         (userProviderList) => userProviderList.provider == 'SAMSUNG');
//     if (appleData != null) {
//       // await SembastDB.storeIOTConnections(
//       //     Connection.appleHealth.name, appleData.userId);
//       terraController.updateIsSamsungHealthConnected(true);
//     }
//   }

// // Main function to start the isolate
//   Future<void> startCheckConnectionAndGetData(
//       {required String refId,
//       required String devId,
//       required String apiKey}) async {
//     // get user Info
//     List<TryTerraUser>? thisConsumerTerraConnections =
//         await VizzhyTerraServices.getUserInfoByReferenceId(refId,
//             devId: devId, apikey: apiKey);

//     final receivePort = ReceivePort();

//     // Spawn the isolate
//     final isolate =
//         await Isolate.spawn(checkConnectionAndGetData, receivePort.sendPort);

//     // Send the connection data to the isolate
//     final sendPort = await receivePort.first
//         as SendPort; // Receive the SendPort from the isolate
//     sendPort.send(
//       thisConsumerTerraConnections?.map((e)=>{e.provider}).toList()
//     ); // Send the current user connection list

//     // Optionally, listen for results or completion
//     // receivePort.listen((data) {
//     //   // Handle any results from the isolate here
//     // });

//     // If you need to wait for the isolate to finish:
//     await receivePort
//         .first; // This could be a completion signal, if you send one back
//     receivePort.close(); // Close the receive port when done
//   }
// }
