import 'package:cinema_pedia_app/domain/datasources/movies_datasource.dart';
import 'package:cinema_pedia_app/domain/entities/movie.dart';
import 'package:cinema_pedia_app/infrastructure/datasources/moviedb_dio.dart';
import 'package:cinema_pedia_app/infrastructure/mappers/movie_mapper.dart';
import 'package:cinema_pedia_app/infrastructure/models/moviedb/movie_details_moviedb.dart';
import 'package:cinema_pedia_app/infrastructure/models/moviedb/moviedb_response.dart';

// * Interactuan con la api externa
class ThemoviedbDatasource extends MoviesDatasource {
  final dio = dioMovieDB;

  List<Movie> _jsonToMovies(Map<String, dynamic> json) {
    final movieDBResponse = MovieDbResponse.fromJson(json);

    // Se filtra los que tienen posterPath diferente a 'no-poster'
    final List<Movie> movies = movieDBResponse.results
        .where((moviedb) => moviedb.posterPath != null)
        .map((moviedb) => MovieMapper.movieDBToEntity(moviedb))
        .toList();

    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get(
      'movie/now_playing',
      queryParameters: {'page': page},
    );
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response = await dio.get(
      'movie/popular',
      queryParameters: {'page': page},
    );

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response = await dio.get(
      'movie/top_rated',
      queryParameters: {'page': page},
    );

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final response = await dio.get(
      'movie/upcoming',
      queryParameters: {'page': page},
    );

    return _jsonToMovies(response.data);
  }

  @override
  Future<Movie> getMovieById(String id) async {
    final response = await dio.get('movie/$id');

    if (response.statusCode != 200) {
      throw Exception('Movie with id: $id not found');
    }
    final movieDB = MovieDbDetail.fromJson(response.data);

    return MovieMapper.movieDetailsToEntity(movieDB);
  }

  @override
  Future<List<Movie>> searchMovies(String query) async {
    if (query.isEmpty) return [];
    final response = await dio.get(
      'search/movie',
      queryParameters: {'query': query},
    );

    return _jsonToMovies(response.data);
  }
}
