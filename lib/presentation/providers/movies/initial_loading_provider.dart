import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinema_pedia_app/presentation/providers/movies/movies_providers.dart';

final initialLoadginProvider = Provider<bool>((ref) {
  final step1 = ref.watch(nowPlayingMoviesProvider).isEmpty;
  final step2 = ref.watch(getPopularMoviesProvider).isEmpty;
  final step3 = ref.watch(getTopRatedProvider).isEmpty;
  final step4 = ref.watch(getUpcomingProvider).isEmpty;

  if (step1 || step2 || step3 || step4) return true;

  return false;
});
