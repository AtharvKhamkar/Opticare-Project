// ignore_for_file: public_member_api_docs

import 'package:flutter_dotenv/flutter_dotenv.dart';

///This class is used to get secret enviroment variables in the .env file
class EnvFileVariableNames {
  static const String terraDevIDName = 'TERRADEVID';
  static const String terraStagIDName = 'TERRASTAGID';
  static const String terraProdIDName = 'TERRAPRODID';
  static const String terraDevApiKeyName = 'TERRADEVAPIKEY';
  static const String terraStagApiKeyName = 'TERRASTAGAPIKEY';
  static const String terraProdApiKeyName = 'TERRAPRODAPIKEY';

  static String get terraDevId => dotenv.env[terraDevIDName] ?? '';
  static String get terraStagId => dotenv.env[terraStagIDName] ?? '';
  static String get terraProdId => dotenv.env[terraProdIDName] ?? '';

  static String get terraDevApiKey => dotenv.env[terraDevApiKeyName] ?? '';
  static String get terraStagApiKey => dotenv.env[terraStagApiKeyName] ?? '';
  static String get terraProdApiKey => dotenv.env[terraProdApiKeyName] ?? '';
}
