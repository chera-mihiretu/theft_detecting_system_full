import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get videoStreamApiUrl => dotenv.env['VIDEO_STREAM_API_URL'] ?? '';
  static String get notificationApiUrl => dotenv.env['NOTIFICATION_API_URL'] ?? '';
  static int get videoCacheSizeMB => int.tryParse(dotenv.env['VIDEO_CACHE_SIZE_MB'] ?? '100') ?? 100;
  
  static String get firebaseProjectId => dotenv.env['FIREBASE_PROJECT_ID'] ?? '';
  static String get firebaseApiKey => dotenv.env['FIREBASE_API_KEY'] ?? '';
  static String get firebaseAppId => dotenv.env['FIREBASE_APP_ID'] ?? '';
  
  static String get googleClientId => dotenv.env['GOOGLE_CLIENT_ID'] ?? '';
  
  static Future<void> load() async {
    await dotenv.load(fileName: ".env");
  }
}
