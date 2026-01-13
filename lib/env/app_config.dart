import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static late final String baseUrl;

  /// Load .env based on environment
  static Future<void> init({bool isProd = false}) async {
    await dotenv.load(fileName: isProd ? "env/.env.prod" : "env/.env.dev");

    baseUrl = dotenv.env['BASE_URL'] ?? 'https://fallback.example.com/api';
  }
}
