import 'package:cinema_pedia_app/presentation/providers/movies/initial_loading_provider.dart';
import 'package:cinema_pedia_app/presentation/providers/movies/movies_providers.dart';
import 'package:cinema_pedia_app/presentation/providers/movies/movies_slideshow_provider.dart';
import 'package:cinema_pedia_app/presentation/widgets/movies/movies_horizontal_listview.dart';
import 'package:cinema_pedia_app/presentation/widgets/movies/movies_slideshow.dart';
import 'package:cinema_pedia_app/presentation/widgets/shared/custom_appbar.dart';
import 'package:cinema_pedia_app/presentation/widgets/shared/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
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
    //* Carga los datos y muestra una pantalla en lo que espera
    final isLoading = ref.watch(initialLoadginProvider);

    if (isLoading) return const FullScreenLoader();

    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(getPopularMoviesProvider);
    final topRatedMovies = ref.watch(getTopRatedProvider);
    final upcomingMovies = ref.watch(getUpcomingProvider);
    final moviesSlideshow = ref.watch(moviesSlideshowProvider);

    // * Con visibility no se muestra hasta que cargaron
    return Visibility(
      visible: !isLoading,
      child: CustomScrollView(
        slivers: [
          const SliverAppBar(floating: true, title: CustomAppbar()),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Column(
                children: [
                  MoviesSlideshow(movies: moviesSlideshow),

                  MoviesHorizontalListview(
                    movies: nowPlayingMovies,
                    title: 'En cines',
                    subTitle: 'Lunes 20 de marzo',
                    loadNextPage: () => ref
                        .read(nowPlayingMoviesProvider.notifier)
                        .loadNextPage(),
                  ),

                  MoviesHorizontalListview(
                    movies: topRatedMovies,
                    title: 'Mejor valoradas',
                    subTitle: 'De todos los tiempos',
                    loadNextPage: () =>
                        ref.read(getTopRatedProvider.notifier).loadNextPage(),
                  ),

                  MoviesHorizontalListview(
                    movies: popularMovies,
                    title: 'Populares',
                    loadNextPage: () => ref
                        .read(getPopularMoviesProvider.notifier)
                        .loadNextPage(),
                  ),

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
      ),
    );
  }
}
