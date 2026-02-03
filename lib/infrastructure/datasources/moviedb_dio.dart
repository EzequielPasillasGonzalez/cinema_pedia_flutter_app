import 'package:cinema_pedia_app/config/finals/enviroment.dart';
import 'package:dio/dio.dart';

final dioMovieDB = Dio(
  BaseOptions(
    baseUrl: Enviroment.tMDBBaseUrl,
    queryParameters: {'language': 'es-Mx'},
    headers: {
      'Authorization': 'Bearer ${Enviroment.tMDBKey}',
      'accept': 'application/json',
    },
  ),
);
