import 'package:animate_do/animate_do.dart';
import 'package:cinema_pedia_app/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MoviesCard extends StatelessWidget {
  final Movie movie;

  const MoviesCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(color: Colors.black45, blurRadius: 10, offset: Offset(0, 10)),
      ],
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DecoratedBox(
        decoration: decoration,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            movie.backdropPath,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress != null) {
                return DecoratedBox(
                  decoration: BoxDecoration(color: colors.primary),
                );
              }

              return FadeIn(child: child);
            },
          ),
        ),
      ),
    );
  }
}
