import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppEnvironment {
  const AppEnvironment._();

  static String get appEnv => dotenv.maybeGet('APP_ENV') ?? 'development';
  static bool get debug => (dotenv.maybeGet('DEBUG') ?? 'true') == 'true';
  static String get aiModel => dotenv.maybeGet('AI_MODEL') ?? 'gpt-5.5-mini';
  static String? get aiApiKey => dotenv.maybeGet('AI_API_KEY');
  static String? get supabaseUrl => dotenv.maybeGet('SUPABASE_URL');
  static String? get supabaseAnonKey => dotenv.maybeGet('SUPABASE_ANON_KEY');
  static String? get storageBucket => dotenv.maybeGet('STORAGE_BUCKET');
}
