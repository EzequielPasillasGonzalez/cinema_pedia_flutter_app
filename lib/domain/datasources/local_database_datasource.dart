import 'package:cinema_pedia_app/infrastructure/models/database/models/local_movie.dart';

abstract class LocalDatabaseDatasource {
  Future<void> toggleFavorite(LocalMovie movie);
  Future<bool> isFavorite(int movieId);
  Future<List<LocalMovie>> loadFavorites({int limit = 10, offset = 0});
}
