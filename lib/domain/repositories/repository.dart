import 'package:cinema_pedia_app/domain/entities/movie.dart';

// * definen como interactuar con los datos
abstract class MoviesRepository {
  Future<List<Movie>> getNowPlaying({int page = 1});
}
