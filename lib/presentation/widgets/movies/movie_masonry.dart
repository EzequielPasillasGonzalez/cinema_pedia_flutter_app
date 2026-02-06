import 'package:cinema_pedia_app/infrastructure/database/models/local_movie.dart';
import 'package:flutter/material.dart';

class MovieMasonry extends StatefulWidget {
  final List<LocalMovie> movies;
  final VoidCallback loadNextPage;

  const MovieMasonry({super.key});

  @override
  State<MovieMasonry> createState() => _MovieMasonryState();
}

class _MovieMasonryState extends State<MovieMasonry> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
