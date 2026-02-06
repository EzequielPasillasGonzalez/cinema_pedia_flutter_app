import 'package:cinema_pedia_app/domain/datasources/local_database_datasource.dart';
import 'package:cinema_pedia_app/domain/repositories/local_database_repository.dart';
import 'package:cinema_pedia_app/infrastructure/models/database/models/local_movie.dart';

class LocalDatabaseImpl extends LacalDatabaseRepository {
  final LocalDatabaseDatasource datasource;

  LocalDatabaseImpl({required this.datasource});

  @override
  Future<bool> isFavorite(int movieId) {
    return datasource.isFavorite(movieId);
  }

  @override
  Future<List<LocalMovie>> loadFavorites({int limit = 10, offset = 0}) {
    return datasource.loadFavorites(limit: limit, offset: offset);
  }

  @override
  Future<void> toggleFavorite(LocalMovie movie) {
    return datasource.toggleFavorite(movie);
  }
}
