import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:vizzhy/src/core/injection/locator.dart';

import 'app.dart';

FutureOr<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init("vizzhy_onboarding");
  await GetStorage.init("vizzhy");
  setupLocator();
  runApp(const OverlaySupport.global(child: MyApp()));
}
