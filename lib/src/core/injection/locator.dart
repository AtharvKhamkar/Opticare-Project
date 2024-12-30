import 'package:flutter/foundation.dart';
import 'package:vizzhy/src/core/injection/injection.dart';
import 'package:vizzhy/src/data/remote/api_client.dart';

import '../../../flavors.dart';
import '../global/app_config_abstract.dart';
import '../global/app_config_dev.dart';
import '../global/app_config_stage.dart';

void setupLocator() {
  debugPrint('Flavours setup in setupLocator function ${F.appFlavor}');
  if (F.appFlavor == Flavor.dev) {
    getIt.registerLazySingleton<AppConfig>(() => AppConfigDev());
  } else {
    getIt.registerLazySingleton<AppConfig>(() => AppConfigStage());
  }

  getIt.registerLazySingleton<ApiClient>(() => ApiClient());
}
