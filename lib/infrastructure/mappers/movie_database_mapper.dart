import 'package:cinema_pedia_app/infrastructure/database/models/local_movie.dart';
import 'package:cinema_pedia_app/infrastructure/models/moviedb/movie_details_moviedb.dart';

class MovieDatabaseMapper {
  static LocalMovie movieDetailsToEntity(
    MovieDbDetail movieDetail,
  ) => LocalMovie(
    id: movieDetail.id,
    posterPath:
        movieDetail.posterPath ??
        'https://tse1.mm.bing.net/th/id/OIP.Lr_j_PgqTGzKxJTeIwajVwHaLH?rs=1&pid=ImgDetMain&o=7&rm=3',
    title: movieDetail.title,
  );
}
