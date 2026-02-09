import 'package:animate_do/animate_do.dart';
import 'package:cinema_pedia_app/infrastructure/models/database/models/local_movie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MoviePosterLink extends StatelessWidget {
  final LocalMovie movie;
  const MoviePosterLink({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/movie/${movie.id}'),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: FadeIn(child: Image.network(movie.posterPath)),
      ),
    );
  }
}
