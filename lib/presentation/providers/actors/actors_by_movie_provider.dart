import 'package:cinema_pedia_app/domain/entities/actor.dart';
import 'package:cinema_pedia_app/presentation/providers/actors/actors_repository_provider.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActorByMovieMapNotifier extends Notifier<Map<String, List<Actor>>> {
  @override
  Map<String, List<Actor>> build() {
    return {};
  }

  Future<void> loadActors(String movieId) async {
    if (state[movieId] != null) return;

    final actors = await ref
        .read(actorRepositoryProvider)
        .getActorsByMovie(movieId);

    state = {...state, movieId: actors};
  }
}

final actorsByMovieProvider =
    NotifierProvider<ActorByMovieMapNotifier, Map<String, List<Actor>>>(() {
      return ActorByMovieMapNotifier();
    });
