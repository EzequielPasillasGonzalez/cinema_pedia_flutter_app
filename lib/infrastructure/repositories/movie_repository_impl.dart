import 'package:cinema_pedia_app/domain/datasources/movies_datasource.dart';
import 'package:cinema_pedia_app/domain/entities/movie.dart';
import 'package:cinema_pedia_app/domain/repositories/movies_repository.dart';

class MovieRepositoryImpl extends MoviesRepository {
  final MoviesDatasource movieDatasource;

  MovieRepositoryImpl({required this.movieDatasource});

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return movieDatasource.getNowPlaying(page: page);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    return movieDatasource.getPopular(page: page);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) {
    return movieDatasource.getTopRated(page: page);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) {
    return movieDatasource.getUpcoming(page: page);
  }

  @override
  Future<Movie> getMovieById(String id) {
    return movieDatasource.getMovieById(id);
  }

  @override
  Future<List<Movie>> searchMovies(String query) {
    return movieDatasource.searchMovies(query);
  }
}
