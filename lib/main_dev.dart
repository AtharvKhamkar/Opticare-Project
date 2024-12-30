import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:vizzhy/firebase_options_dev.dart';
import 'package:vizzhy/src/core/injection/locator.dart';
// import 'package:vizzhy/src/services/vizzhy_uni_service.dart';

import 'flavors.dart';

import 'main_starter.dart' as runner;

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    F.appFlavor = Flavor.dev;

    await Firebase.initializeApp(
        options: DefaultFirebaseOptionsDev.currentPlatform);
    debugPrint('firebase app is initialized....');

    // await VizzhyFirebaseUniService.init();
    // Pass all uncaught "fatal" errors from the framework to Crashlytics
    // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    // PlatformDispatcher.instance.onError = (error, stack) {
    //   FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    //   return true;
    // };

    F.appFlavor = Flavor.dev;
    debugPrint('running app in dev mode');
    setupLocator();
    await dotenv.load();
    await runner.main();
  } catch (e, s) {
    debugPrint("error in main_dev.dart  :$e , $s");
  }
}
