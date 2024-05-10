import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvLoader {
  static String? getEnvVar(String key) {
    return dotenv.env[key];
  }
}
