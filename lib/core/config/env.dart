import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static String get dbName => dotenv.env['DB_NAME'] ?? 'your_store_app.db';
  static int get dbVersion => int.tryParse(dotenv.env['DB_VERSION'] ?? '1') ?? 1;
  static String get baseUrl => dotenv.env['BASE_URL'] ?? 'https://dummyjson.com';
}