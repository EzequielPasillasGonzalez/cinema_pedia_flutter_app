import 'package:cinema_pedia_app/domain/entities/movie.dart';
import 'package:cinema_pedia_app/infrastructure/models/moviedb/movie_moviedb.dart';

class MovieMapper {
  static Movie movieDBToEntity(MovieFromMovieDB movieFromMovieDB) => Movie(
    adult: movieFromMovieDB.adult,
    backdropPath: movieFromMovieDB.backdropPath != ''
        ? 'https://image.tmdb.org/t/p/w500/${movieFromMovieDB.backdropPath}.jpg'
        : 'https://tse1.mm.bing.net/th/id/OIP.Lr_j_PgqTGzKxJTeIwajVwHaLH?rs=1&pid=ImgDetMain&o=7&rm=3',
    genreIds: movieFromMovieDB.genreIds.map((e) => e.toString()).toList(),
    id: movieFromMovieDB.id,
    originalLanguage: movieFromMovieDB.originalLanguage,
    originalTitle: movieFromMovieDB.originalTitle,
    overview: movieFromMovieDB.overview,
    popularity: movieFromMovieDB.popularity,
    posterPath: movieFromMovieDB.posterPath != ''
        ? 'https://image.tmdb.org/t/p/w500/${movieFromMovieDB.posterPath}.jpg'
        : 'no-poster',
    releaseDate: movieFromMovieDB.releaseDate,
    title: movieFromMovieDB.title,
    video: movieFromMovieDB.video,
    voteAverage: movieFromMovieDB.voteAverage,
    voteCount: movieFromMovieDB.voteCount,
  );
}
