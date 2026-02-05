import 'package:cinema_pedia_app/domain/entities/movie.dart';
import 'package:cinema_pedia_app/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchQueryNotifier extends Notifier<String> {
  @override
  String build() {
    return '';
  }

  void changeSearchQuery(String query) {
    state = query;
  }
}

final searchQueryProvider = NotifierProvider<SearchQueryNotifier, String>(() {
  return SearchQueryNotifier();
});

class SearchMoviesNotifier extends Notifier<List<Movie>> {
  @override
  List<Movie> build() {
    return [];
  }

  Future<List<Movie>> searchMoviesByQuery(String query) async {
    if (query.isEmpty) return [];

    final List<Movie> movies = await ref
        .read(movieRepositoryProvider)
        .searchMovies(query);

    ref.read(searchQueryProvider.notifier).changeSearchQuery(query);

    state = movies;

    return movies;
  }
}

final searchMoviesProvider =
    NotifierProvider<SearchMoviesNotifier, List<Movie>>(() {
      return SearchMoviesNotifier();
    });
