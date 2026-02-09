import 'package:cinema_pedia_app/domain/entities/movie.dart';
import 'package:cinema_pedia_app/infrastructure/mappers/movie_database_mapper.dart';
import 'package:cinema_pedia_app/infrastructure/models/moviedb/movie_details_moviedb.dart';
import 'package:cinema_pedia_app/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinema_pedia_app/infrastructure/models/database/models/local_movie.dart';

class FavoritesMoviesNotifer extends Notifier<List<LocalMovie>> {
  int _page = 0;
  // bool _isLoading = false;

  @override
  List<LocalMovie> build() {
    // Iniciamos vacíos, pero disparamos la carga inicial
    // loadNextPage();
    return [];
  }

  // Carga inicial y paginación
  Future<List<LocalMovie>> loadNextPage() async {
    // if (_isLoading) return ;
    // _isLoading = true;

    final localDb = ref.read(localDbRepositoryProvider);

    final movies = await localDb.loadFavorites(offset: _page * 10, limit: 10);

    _page++;

    state = [...state, ...movies];

    // _isLoading = false;

    return movies;
  }

  Future<void> addToFavorites(Movie movie) async {
    final localMovie = MovieDatabaseMapper.movieDetailsToEntity(movie);

    final localDb = ref.read(localDbRepositoryProvider);

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
    final localDb = ref.read(localDbRepositoryProvider);

    return localDb.isFavorite(movieId);
  }
}

final favoriteMovieProvider =
    NotifierProvider<FavoritesMoviesNotifer, List<LocalMovie>>(
      () => FavoritesMoviesNotifer(),
    );
