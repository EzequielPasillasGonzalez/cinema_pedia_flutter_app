import 'package:cinema_pedia_app/domain/entities/movie.dart';
import 'package:cinema_pedia_app/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef MovieCallback = Future<List<Movie>> Function({int page});


abstract class MoviesNotifier extends Notifier<List<Movie>> {
  int currentPage = 0;

  @override
  List<Movie> build() => [];

  Future<List<Movie>> fetchMoreMovies({required int page});

  Future<void> loadNextPage() async {
    currentPage++;

    final List<Movie> movies = await fetchMoreMovies(page: currentPage);

    state = [...state, ...movies];
  }
}

class NowPlayingMapNotifier extends MoviesNotifier {
  @override
  Future<List<Movie>> fetchMoreMovies({required int page}) {
    return ref.read(movieRepositoryProvider).getNowPlaying(page: page);
  }
}


final nowPlayingMoviesProvider =
    NotifierProvider<NowPlayingMapNotifier, List<Movie>>(() {
      return NowPlayingMapNotifier();
    });
