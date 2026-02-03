import 'package:cinema_pedia_app/infrastructure/datasources/actor_moviedb_datasource.dart';
import 'package:cinema_pedia_app/infrastructure/repositories/actors_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Este repositorio es inmutable
final actorRepositoryProvider = Provider((ref) {
  return ActorsRepositoryImpl(datasource: ActorMovieDBDatasource());
});
