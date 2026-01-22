import 'package:cinema_pedia_app/domain/entities/movie.dart';

abstract class MoviesDatasource {
  Future<List<Movie>> getNowPlayong({int page = 1});
}
