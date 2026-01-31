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
