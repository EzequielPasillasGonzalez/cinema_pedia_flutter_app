import 'package:cinema_pedia_app/domain/entities/movie.dart';

abstract class MoviesRepository {
  Future<List<Movie>> getNowPlayong({int page = 1});
}
