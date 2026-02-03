import 'package:cinema_pedia_app/domain/entities/actor.dart';
import 'package:cinema_pedia_app/infrastructure/models/moviedb/credits_response.dart';

class ActorMapper {
  static Actor castToentity(Cast cast) => Actor(
    id: cast.id,
    name: cast.name,
    profilePath: cast.profilePath != null
        ? 'https://image.tmdb.org/t/p/w500/${cast.profilePath}.jpg'
        : 'https://claritycareconsulting.co.uk/wp-content/uploads/2023/05/Blank-Profile-Picture.jpg',
    character: cast.character,
  );
}
