import 'package:flutter_dotenv/flutter_dotenv.dart';

class Enviroment {
  static final String tMDBKey =
      dotenv.env["TMDB_API_KEY"] ??
      (throw AssertionError('TMDB_API_KEY not found in .env file'));

  static final String tMDBBaseUrl =
      dotenv.env["TMDB_BASE_URL"] ??
      (throw AssertionError('TMDB_BASE_URL not found in .env file'));
}
