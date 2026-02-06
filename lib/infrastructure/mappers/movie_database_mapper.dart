import 'package:cinema_pedia_app/domain/entities/movie.dart';
import 'package:cinema_pedia_app/infrastructure/models/database/models/local_movie.dart';

class MovieDatabaseMapper {
  static LocalMovie movieDetailsToEntity(Movie movie) => LocalMovie(
    id: movie.id,
    posterPath: movie.posterPath,
    title: movie.title,
  );
}
