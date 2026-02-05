import 'package:cinema_pedia_app/domain/entities/movie.dart';
import 'package:cinema_pedia_app/presentation/delegates/search_movie_delegate.dart';
import 'package:cinema_pedia_app/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final titleMedium = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(Icons.movie_outlined, color: colors.primary),
              const SizedBox(width: 5),
              Text('CinemaPedia', style: titleMedium),

              const Spacer(),
              IconButton(
                onPressed: () async {
                  // final movieRepository = ref.read(movieRepositoryProvider);
                  final searchQuery = ref.read(searchQueryProvider);
                  final searchMovies = ref.read(searchMoviesProvider);

                  final movie = await showSearch<Movie?>(
                    query: searchQuery,
                    context: context,
                    delegate: SearchMovieDelegate(
                      initialMovies: searchMovies,
                      searchMovies: (query) {
                        ref
                            .read(searchQueryProvider.notifier)
                            .changeSearchQuery(query);
                        return ref
                            .read(searchMoviesProvider.notifier)
                            .searchMoviesByQuery(query);
                      },
                    ),
                  );

                  if (movie == null) return;

                  // Sigue este widget vivo en la pantalla?
                  if (!context.mounted) return;

                  // Si sigue vivo, es seguro navegar
                  context.push('/movie/${movie.id}');
                },
                icon: Icon(Icons.search),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
