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
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final moviesSlideshow = ref.watch(moviesSlideshowProvider);
    return CustomScrollView(
      slivers: [
        const SliverAppBar(floating: true, title: CustomAppbar()),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return Column(
              children: [
                Builder(
                  builder: (context) {
                    if (moviesSlideshow.isEmpty) {
                      return DecoratedBox(
                        decoration: BoxDecoration(color: colors.primary),
                      );
                    }
                    return MoviesSlideshow(movies: moviesSlideshow);
                  },
                ),
                Builder(
                  builder: (context) {
                    if (nowPlayingMovies.isEmpty) {
                      return DecoratedBox(
                        decoration: BoxDecoration(color: colors.primary),
                      );
                    }
                    return Column(
                      children: [
                        MoviesHorizontalListview(
                          movies: nowPlayingMovies,
                          title: 'En cines',
                          subTitle: 'Lunes 20 de marzo',
                          loadNextPage: () => ref
                              .read(nowPlayingMoviesProvider.notifier)
                              .loadNextPage(),
                        ),

                        MoviesHorizontalListview(
                          movies: nowPlayingMovies,
                          title: 'Prximamente',
                          subTitle: 'En este mes',
                          loadNextPage: () => ref
                              .read(nowPlayingMoviesProvider.notifier)
                              .loadNextPage(),
                        ),

                        MoviesHorizontalListview(
                          movies: nowPlayingMovies,
                          title: 'Populares',
                          loadNextPage: () => ref
                              .read(nowPlayingMoviesProvider.notifier)
                              .loadNextPage(),
                        ),

                        MoviesHorizontalListview(
                          movies: nowPlayingMovies,
                          title: 'Mejor valoradas',
                          subTitle: 'De todos los tiempos',
                          loadNextPage: () => ref
                              .read(nowPlayingMoviesProvider.notifier)
                              .loadNextPage(),
                        ),

                        const SizedBox(height: 10),
                      ],
                    );
                  },
                ),
              ],
            );
          }, childCount: 1),
        ),
      ],
    );
  }
}
