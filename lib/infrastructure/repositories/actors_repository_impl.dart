import 'package:cinema_pedia_app/domain/datasources/actors_datasource.dart';
import 'package:cinema_pedia_app/domain/entities/actor.dart';
import 'package:cinema_pedia_app/domain/repositories/actors_repository.dart';

class ActorsRepositoryImpl extends ActorsRepository {
  final ActorsDatasource datasource;

  ActorsRepositoryImpl({required this.datasource});

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    return datasource.getActorsByMovie(movieId);
  }
}
