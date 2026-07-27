import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppEnvironment {
  const AppEnvironment._();

  static String get appEnv => _maybeGet('APP_ENV') ?? 'development';
  static bool get debug => (_maybeGet('DEBUG') ?? 'true') == 'true';
  static String get aiModel => _maybeGet('AI_MODEL') ?? 'gpt-5.5-mini';
  static String? get aiApiKey => _maybeGet('AI_API_KEY');
  static String? get removeBgApiKey => _maybeGet('REMOVE_BG_API_KEY');
  static String? get supabaseUrl => _maybeGet('SUPABASE_URL');
  static String? get supabaseAnonKey => _maybeGet('SUPABASE_ANON_KEY');
  static String? get storageBucket => _maybeGet('STORAGE_BUCKET');

  static String? _maybeGet(String name) {
    try {
      return dotenv.maybeGet(name);
    } catch (_) {
      return null;
    }
  }
}
