import 'package:animate_do/animate_do.dart';
import 'package:cinema_pedia_app/config/helpers/human_format.dart';
import 'package:cinema_pedia_app/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MoviesHorizontalListview extends StatelessWidget {
  final List<Movie> movies;
  final String? title;
  final String? subTitle;
  final VoidCallback? loadNextPage;

  const MoviesHorizontalListview({
    super.key,
    required this.movies,
    this.title,
    this.subTitle,
    this.loadNextPage,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          if (title != null || subTitle != null)
            _Title(title: title, subTitle: subTitle),

          Expanded(
            child: ListView.builder(
              itemCount: movies.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return _Slide(movies[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;

  const _Slide(this.movie);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 5,
        children: [
          // * Imagen
          SizedBox(
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                fit: BoxFit.cover,
                movie.posterPath,
                width: 150,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: const CircularProgressIndicator(strokeWidth: 2),
                      ),
                    );
                  }

                  return FadeInRight(child: child);
                },
              ),
            ),
          ),

          //* Titulo
          SizedBox(
            width: 150,
            child: Text(movie.title, maxLines: 2, style: textTheme.titleSmall),
          ),

          // * Rating
          SizedBox(
            width: 150,
            child: Row(
              spacing: 3,
              children: [
                Icon(Icons.star_half_outlined, color: Colors.yellow[800]),
                Text(
                  '${movie.voteAverage}',
                  style: textTheme.bodyMedium?.copyWith(
                    color: Colors.yellow[800],
                  ),
                ),
                const Spacer(),
                Text(
                  HumanFormats.number(movie.popularity),
                  style: textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String? title;
  final String? subTitle;
  const _Title({this.title, this.subTitle});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;

    final title = this.title;
    final subTitle = this.subTitle;
    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          if (title != null) Text(title, style: titleStyle),
          const Spacer(),
          if (subTitle != null)
            FilledButton.tonal(
              style: ButtonStyle(visualDensity: VisualDensity.compact),
              onPressed: () {},
              child: Text(subTitle),
            ),
        ],
      ),
    );
  }
}
