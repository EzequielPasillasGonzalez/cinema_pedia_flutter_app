import 'package:cinema_pedia_app/config/finals/enviroment.dart';
import 'package:cinema_pedia_app/domain/datasources/movies_datasource.dart';
import 'package:cinema_pedia_app/domain/entities/movie.dart';
import 'package:cinema_pedia_app/infrastructure/mappers/movie_mapper.dart';
import 'package:cinema_pedia_app/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

class ThemoviedbDatasource extends MoviesDatasource {
  final dio = Dio(
    BaseOptions(
      baseUrl: Enviroment.tMDBBaseUrl,
      queryParameters: {'language': 'es-Mx'},
      headers: {
        'Authorization': 'Bearer ${Enviroment.tMDBKey}',
        'acceept': 'application/json',
      },
    ),
  );

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get('movie/now_playing');

    final movieDBResponse = MovieDbResponse.fromJson(response.data);

    // Se filtra los que tienen posterPath diferente a 'no-poster'
    final List<Movie> movies = movieDBResponse.results
        .where((moviedb) => moviedb.posterPath != 'no-poster')
        .map((moviedb) => MovieMapper.movieDBToEntity(moviedb))
        .toList();

    return movies;
  }
}
