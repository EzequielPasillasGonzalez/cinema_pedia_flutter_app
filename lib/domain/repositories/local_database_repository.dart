import 'package:cinema_pedia_app/infrastructure/models/database/models/local_movie.dart';

// * definen como interactuar con los datos
abstract class LacalDatabaseRepository {
  Future<void> toggleFavorite(LocalMovie movie);
  Future<bool> isFavorite(int movieId);
  Future<List<LocalMovie>> loadFavorites({int limit = 10, offset = 0});
}
