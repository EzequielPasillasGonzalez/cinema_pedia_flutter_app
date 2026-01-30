import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinema_pedia_app/presentation/providers/movies/movies_providers.dart';
import 'package:cinema_pedia_app/domain/entities/movie.dart';

final moviesSlideshowProvider = Provider<List<Movie>>((ref) {
  final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);

  if (nowPlayingMovies.isEmpty) return [];

  return nowPlayingMovies.take(6).toList();
});
