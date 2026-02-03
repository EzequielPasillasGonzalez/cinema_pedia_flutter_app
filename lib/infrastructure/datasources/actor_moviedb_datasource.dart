import 'package:cinema_pedia_app/domain/datasources/actors_datasource.dart';
import 'package:cinema_pedia_app/domain/entities/actor.dart';
import 'package:cinema_pedia_app/infrastructure/datasources/moviedb_dio.dart';
import 'package:cinema_pedia_app/infrastructure/mappers/actor_mapper.dart';
import 'package:cinema_pedia_app/infrastructure/models/moviedb/credits_response.dart';

class ActorMovieDBDatasource extends ActorsDatasource {
  final dio = dioMovieDB;

  List<Actor> _jsonToActor(Map<String, dynamic> json) {
    final castDBResponse = CastResponse.fromJson(json);

    final List<Actor> actors = castDBResponse.cast
        .map((castdb) => ActorMapper.castToentity(castdb))
        .toList();

    return actors;
  }

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    final response = await dio.get('movie/$movieId/credits');
    return _jsonToActor(response.data);
  }
}
