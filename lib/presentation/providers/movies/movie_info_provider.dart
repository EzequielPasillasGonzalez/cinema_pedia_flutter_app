import 'package:cinema_pedia_app/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinema_pedia_app/domain/entities/movie.dart';

class MovieMapNotifier extends Notifier<Map<String, Movie>> {
  @override
  Map<String, Movie> build() {
    return {};
  }

  Future<void> loadMovie(String movieId) async {
    if (state[movieId] != null) return;

    final movie = await ref.read(movieRepositoryProvider).getMovieById(movieId);

    state = {...state, movieId: movie};
  }
}

final movieInfoProvider =
    NotifierProvider<MovieMapNotifier, Map<String, Movie>>(() {
      return MovieMapNotifier();
    });
