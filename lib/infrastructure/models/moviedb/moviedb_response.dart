import 'package:cinema_pedia_app/infrastructure/models/moviedb/dates_moviedb.dart';
import 'package:cinema_pedia_app/infrastructure/models/moviedb/movie_moviedb.dart';

// * Como vienen los datos de la API externa
class MovieDbResponse {
  final DatesFromMovieDB? dates;
  final int page;
  final List<MovieFromMovieDB> results;
  final int totalPages;
  final int totalResults;

  MovieDbResponse({
    required this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MovieDbResponse.fromJson(Map<String, dynamic> json) =>
      MovieDbResponse(
        dates: json["dates"] ? DatesFromMovieDB.fromJson(json["dates"]) : null,
        page: json["page"],
        results: List<MovieFromMovieDB>.from(
          json["results"].map((x) => MovieFromMovieDB.fromJson(x)),
        ),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
    "dates": dates?.toJson(),
    "page": page,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "total_pages": totalPages,
    "total_results": totalResults,
  };
}
