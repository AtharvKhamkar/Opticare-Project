import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  Logger get loggerDev =>
      Logger(printer: PrettyPrinter(lineLength: 80, methodCount: 1));
}
