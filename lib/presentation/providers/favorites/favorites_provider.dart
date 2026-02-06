import 'package:cinema_pedia_app/infrastructure/datasources/local_db_datasource.dart';
import 'package:cinema_pedia_app/infrastructure/mappers/movie_database_mapper.dart';
import 'package:cinema_pedia_app/infrastructure/models/moviedb/movie_details_moviedb.dart';
import 'package:cinema_pedia_app/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinema_pedia_app/infrastructure/database/models/local_movie.dart';

class FavoritesMoviesNotifer extends Notifier<List<LocalMovie>> {
  @override
  List<LocalMovie> build() {
    // Iniciamos vacíos, pero disparamos la carga inicial
    loadFavorites();
    return [];
  }

  // Carga inicial y paginación
  Future<List<LocalMovie>> loadFavorites() async {
    final localDb = ref.read(localDbDatasourceProvider);
    final movies = await localDb.loadFavorites();

    state = movies;

    return movies;
  }

  Future<void> addToFavorites(MovieDbDetail movieDetail) async {
    final localMovie = MovieDatabaseMapper.movieDetailsToEntity(movieDetail);

    final localDb = ref.read(localDbDatasourceProvider);

    await localDb.toggleFavorite(localMovie);

    // Verificamos si la película ya estaba en la lista del estado actual
    final bool isMovieInList = state.any((movie) => movie.id == localMovie.id);

    if (isMovieInList) {
      // Si estaba, la quitamos de la lista visual
      state = state.where((m) => m.id != localMovie.id).toList();
    } else {
      // Si no estaba, la agregamos a la lista visual
      state = [...state, localMovie];
    }
  }

  Future<bool> isFavorite(int movieId) async {
    final localDb = ref.read(localDbDatasourceProvider);

    return localDb.isFavorite(movieId);
  }
}

final favoriteMovieProvider =
    NotifierProvider<FavoritesMoviesNotifer, List<LocalMovie>>(
      () => FavoritesMoviesNotifer(),
    );
