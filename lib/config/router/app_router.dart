import 'package:cinema_pedia_app/presentation/views/views.dart';
import 'package:cinema_pedia_app/presentation/widgets/shared/custom_botton_navigationbar_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cinema_pedia_app/presentation/screens/screens.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _sectionHomeNavigatorKey = GlobalKey<NavigatorState>();
final _sectionCategoritesNavigatorKey = GlobalKey<NavigatorState>();
final _sectionFavoritesNavigatorKey = GlobalKey<NavigatorState>();

final apppRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        // navigationShell es el objeto que contiene la lógica
        // para cambiar de rama sin perder el estado.
        return CustomBottonNavigationbarWithScaffold(
          navigationSheel: navigationShell,
        );
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _sectionHomeNavigatorKey,
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => HomeView(),
              routes: [
                GoRoute(
                  path: '/movie/:id',
                  name: MovieScreen.name,
                  builder: (context, state) {
                    final movieID = state.pathParameters['id'] ?? 'no-id';

                    return MovieScreen(movieId: movieID);
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _sectionCategoritesNavigatorKey,
          routes: [
            GoRoute(
              path: '/categories',
              builder: (context, state) => CategoriesView(),
            ),
          ],
        ),

        StatefulShellBranch(
          navigatorKey: _sectionFavoritesNavigatorKey,
          routes: [
            GoRoute(
              path: '/favorites',
              builder: (context, state) => FavoritesView(),
            ),
          ],
        ),
      ],
    ),
  ],
);
