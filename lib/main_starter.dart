import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:vizzhy/src/data/local_storage/app_storage.dart';
import 'package:vizzhy/src/features/try_terra/presentation/controllers/try_terra_controller.dart';
import 'app.dart';

FutureOr<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init("vizzhy_onboarding");
  await GetStorage.init("vizzhy");
  await dotenv.load();

  runApp(const OverlaySupport.global(child: MyApp()));
}
