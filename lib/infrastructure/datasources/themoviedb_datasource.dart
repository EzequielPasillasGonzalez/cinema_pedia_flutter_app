import 'package:cinema_pedia_app/config/finals/enviroment.dart';
import 'package:cinema_pedia_app/domain/datasources/movies_datasource.dart';
import 'package:cinema_pedia_app/domain/entities/movie.dart';
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
  Future<List<Movie>> getNowPlayong({int page = 1}) async {
    final response = await dio.get('movie/now_playing');

    final List<Movie> movies = [];
    return movies;
  }
}
