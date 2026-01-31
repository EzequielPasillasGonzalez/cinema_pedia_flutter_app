import 'package:cinema_pedia_app/domain/entities/movie.dart';
import 'package:cinema_pedia_app/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef MovieCallback = Future<List<Movie>> Function({int page});

abstract class MoviesNotifier extends Notifier<List<Movie>> {
  int currentPage = 0;
  bool isLoadding = false;
  @override
  List<Movie> build() => [];

  Future<List<Movie>> fetchMoreMovies({required int page});

  Future<void> loadNextPage() async {
    if (isLoadding) return;
    isLoadding = true;

    currentPage++;

    final List<Movie> movies = await fetchMoreMovies(page: currentPage);

    state = [...state, ...movies];
    await Future.delayed(const Duration(microseconds: 300));
    isLoadding = false;
  }
}

class NowPlayingMapNotifier extends MoviesNotifier {
  @override
  Future<List<Movie>> fetchMoreMovies({required int page}) {
    return ref.read(movieRepositoryProvider).getNowPlaying(page: page);
  }
}

final nowPlayingMoviesProvider =
    NotifierProvider<NowPlayingMapNotifier, List<Movie>>(
      () => NowPlayingMapNotifier(),
    );

class PopularMoviesMapNotifier extends MoviesNotifier {
  @override
  Future<List<Movie>> fetchMoreMovies({required int page}) {
    return ref.read(movieRepositoryProvider).getPopular(page: page);
  }
}

final getPopularMoviesProvider =
    NotifierProvider<PopularMoviesMapNotifier, List<Movie>>(
      () => PopularMoviesMapNotifier(),
    );

class TopRatedMapNotifier extends MoviesNotifier {
  @override
  Future<List<Movie>> fetchMoreMovies({required int page}) {
    return ref.read(movieRepositoryProvider).getTopRated(page: page);
  }
}

final getTopRatedProvider = NotifierProvider<TopRatedMapNotifier, List<Movie>>(
  () => TopRatedMapNotifier(),
);

class UpcomingMapNotifier extends MoviesNotifier {
  @override
  Future<List<Movie>> fetchMoreMovies({required int page}) {
    return ref.read(movieRepositoryProvider).getUpcoming(page: page);
  }
}

final getUpcomingProvider = NotifierProvider<UpcomingMapNotifier, List<Movie>>(
  () => UpcomingMapNotifier(),
);
