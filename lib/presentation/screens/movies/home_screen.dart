import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinema_pedia_app/presentation/providers/providers.dart';
import 'package:cinema_pedia_app/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottonNavigationbar(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(getPopularMoviesProvider.notifier).loadNextPage();
    ref.read(getTopRatedProvider.notifier).loadNextPage();
    ref.read(getUpcomingProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(getPopularMoviesProvider);
    final topRatedMovies = ref.watch(getTopRatedProvider);
    final upcomingMovies = ref.watch(getUpcomingProvider);
    final moviesSlideshow = ref.watch(moviesSlideshowProvider);

    return CustomScrollView(
      slivers: [
        const SliverAppBar(floating: true, title: CustomAppbar()),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return Column(
              children: [
                if (moviesSlideshow.isEmpty)
                  _LoadingBox(colors: colors)
                else
                  MoviesSlideshow(movies: moviesSlideshow),

                if (nowPlayingMovies.isEmpty)
                  _LoadingBox(colors: colors)
                else
                  MoviesHorizontalListview(
                    movies: nowPlayingMovies,
                    title: 'En cines',
                    subTitle: 'Lunes 20 de marzo',
                    loadNextPage: () => ref
                        .read(nowPlayingMoviesProvider.notifier)
                        .loadNextPage(),
                  ),

                if (topRatedMovies.isEmpty)
                  _LoadingBox(colors: colors)
                else
                  MoviesHorizontalListview(
                    movies: topRatedMovies,
                    title: 'Mejor valoradas',
                    subTitle: 'De todos los tiempos',
                    loadNextPage: () =>
                        ref.read(getTopRatedProvider.notifier).loadNextPage(),
                  ),

                if (popularMovies.isEmpty)
                  _LoadingBox(colors: colors)
                else
                  MoviesHorizontalListview(
                    movies: popularMovies,
                    title: 'Populares',
                    loadNextPage: () => ref
                        .read(getPopularMoviesProvider.notifier)
                        .loadNextPage(),
                  ),

                if (upcomingMovies.isEmpty)
                  _LoadingBox(colors: colors)
                else
                  MoviesHorizontalListview(
                    movies: upcomingMovies,
                    title: 'Proximamente',
                    subTitle: 'En este mes',

                    loadNextPage: () =>
                        ref.read(getUpcomingProvider.notifier).loadNextPage(),
                  ),
                const SizedBox(height: 10),
              ],
            );
          }, childCount: 1),
        ),
      ],
    );
  }
}

class _LoadingBox extends StatelessWidget {
  const _LoadingBox({required this.colors});

  final ColorScheme colors;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(decoration: BoxDecoration(color: colors.primary));
  }
}
