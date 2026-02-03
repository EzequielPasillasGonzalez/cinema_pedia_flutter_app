import 'package:cinema_pedia_app/domain/entities/movie.dart';
import 'package:cinema_pedia_app/presentation/providers/movies/movie_info_provider.dart';
import 'package:cinema_pedia_app/presentation/widgets/shared/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieScreen extends ConsumerStatefulWidget {
  static const name = 'movie-screen';

  final String movieId;

  const MovieScreen({super.key, required this.movieId});

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();

    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieId];

    return Scaffold(
      body: movie == null
          ? const FullScreenLoader()
          : CustomScrollView(
              physics: const ClampingScrollPhysics(),
              slivers: [
                _CustomSliverAppBar(movie: movie),
                _CustomSliverList(movie: movie),
              ],
            ),
    );
  }
}

class _CustomSliverList extends StatelessWidget {
  const _CustomSliverList({required this.movie});
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => _MovieDetails(movie: movie),
        childCount: 1,
      ),
    );
  }
}

class _MovieDetails extends StatelessWidget {
  const _MovieDetails({required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(20),
                child: Image.network(movie.posterPath, width: size.width * 0.3),
              ),

              const SizedBox(width: 10),

              SizedBox(
                width: (size.width - 40) * 0.7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(movie.title, style: textTheme.titleLarge),
                    Text(movie.overview),
                  ],
                ),
              ),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(8),
          child: Wrap(
            children: [
              ...movie.genreIds.map(
                (gender) => Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: Chip(
                    label: Text(gender),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Todo: Mostrar actores ListView
        const SizedBox(height: 100),
      ],
    );
  }
}

class _CustomSliverAppBar extends StatelessWidget {
  final Movie movie;

  const _CustomSliverAppBar({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            _BackgroundImage(movie.posterPath),
            _Gradiente(begin: Alignment.topCenter, end: Alignment.bottomCenter),
            _Gradiente(
              begin: Alignment.topLeft,
              stops: [0.0, 0.3],
              colors: [Colors.black87, Colors.transparent],
            ),
          ],
        ),
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        title: _SliiverTitle(movieTitle: movie.title),
      ),
    );
  }
}

class _Gradiente extends StatelessWidget {
  const _Gradiente({
    this.stops,
    this.begin = Alignment.centerLeft,
    this.end = Alignment.centerRight,
    this.colors = const [Colors.transparent, Colors.black87],
  });

  final List<double>? stops;
  final Alignment begin;
  final Alignment end;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: begin,
            end: end,
            stops: stops,
            colors: colors,
          ),
        ),
      ),
    );
  }
}

class _SliiverTitle extends StatelessWidget {
  const _SliiverTitle({required this.movieTitle});

  final String movieTitle;

  @override
  Widget build(BuildContext context) {
    return Text(
      movieTitle,
      style: const TextStyle(fontSize: 20, color: Colors.white),
      textAlign: TextAlign.start,
    );
  }
}

class _BackgroundImage extends StatelessWidget {
  final String imagePath;

  const _BackgroundImage(this.imagePath);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(child: Image.network(imagePath, fit: BoxFit.cover));
  }
}
