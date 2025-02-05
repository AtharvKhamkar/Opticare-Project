// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options_stag.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptionsStag {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAhkYXvLOEx_E3FqGf0nAfA-DJrHzZlc68',
    appId: '1:315546812604:web:50dce213ff65611eeed0b9',
    messagingSenderId: '315546812604',
    projectId: 'vizzhystag-bcb4e',
    authDomain: 'vizzhystag-bcb4e.firebaseapp.com',
    storageBucket: 'vizzhystag-bcb4e.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyArqpXRHykSuwrWIDixUWtXQtBIDneensQ',
    appId: '1:315546812604:android:06ac4755cd6b1d5eeed0b9',
    messagingSenderId: '315546812604',
    projectId: 'vizzhystag-bcb4e',
    storageBucket: 'vizzhystag-bcb4e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAX_BdwDKraT9X6y_ARLOMSGBPy1bwuwKU',
    appId: '1:315546812604:ios:9ba7c8ff2de1c20eeed0b9',
    messagingSenderId: '315546812604',
    projectId: 'vizzhystag-bcb4e',
    storageBucket: 'vizzhystag-bcb4e.appspot.com',
    iosBundleId: 'com.vizzhy.multiomics',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAX_BdwDKraT9X6y_ARLOMSGBPy1bwuwKU',
    appId: '1:315546812604:ios:9f40a80075676cb2eed0b9',
    messagingSenderId: '315546812604',
    projectId: 'vizzhystag-bcb4e',
    storageBucket: 'vizzhystag-bcb4e.appspot.com',
    iosBundleId: 'come.vizzhy.vizzhy',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAhkYXvLOEx_E3FqGf0nAfA-DJrHzZlc68',
    appId: '1:315546812604:web:37352bb333e831b6eed0b9',
    messagingSenderId: '315546812604',
    projectId: 'vizzhystag-bcb4e',
    authDomain: 'vizzhystag-bcb4e.firebaseapp.com',
    storageBucket: 'vizzhystag-bcb4e.appspot.com',
  );
}
