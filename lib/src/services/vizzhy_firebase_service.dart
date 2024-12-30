import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vizzhy/flavors.dart';
import 'package:vizzhy/src/services/device_info_services.dart';

import '../data/models/cached_error_model.dart';

/// This service clas sepecifically design to call Firebase related function
/// from Controller or BLoc call these functions
/// communicate to firebase using this service
/// Tip : modify this service file for extra feature
/// and firebase service utilization
class VizzhyFirebaseServices {
  // Write all firebase function below

  FirebaseFirestore? get _firestore =>
      Firebase.apps.isEmpty ? null : FirebaseFirestore.instance;

  /// Function to log error in the firebse firestore
  void logErrorToFirestore(CachedErrorModel error) {
    try {
      if (_firestore == null) return;
      VizzhyDeviceInfoServices().initPlatformState().then((devicedata) {
        _firestore!
            .collection('${F.appFlavor}_error_logs')
            .doc(
                '${DateTime.now().toLocal().toIso8601String().substring(0, 16)}_${Random().nextInt(3000000)}')
            .set({
          "cached error ": error.toMap(),
          "device info ": devicedata,
        });
      });

      debugPrint("Error logged successfully!");
    } catch (e) {
      debugPrint("Failed to log error: $e");
    }
  }

  /// Function to log data to Firebase Firestore
  void logDataToFirestore(data) {
    try {
      if (_firestore == null) return;

      VizzhyDeviceInfoServices().initPlatformState().then((devicedata) {
        _firestore!
            .collection('${F.appFlavor}_data')
            .doc(
                '${DateTime.now().toLocal().toIso8601String().substring(0, 16)}_${Random().nextInt(3000000)}')
            .set({
          "Data ": data,
          "device info ": devicedata,
        });
      });
      debugPrint("data logged successfully!");
    } catch (e) {
      debugPrint("Failed to log data: $e");
    }
  }
}
