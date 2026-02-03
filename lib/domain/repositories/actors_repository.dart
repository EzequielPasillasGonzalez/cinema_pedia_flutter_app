import 'package:cinema_pedia_app/domain/entities/actor.dart';

// * definen como interactuar con los datos
abstract class ActorsRepository {
  Future<List<Actor>> getActorsByMovie(String movieId);
}
