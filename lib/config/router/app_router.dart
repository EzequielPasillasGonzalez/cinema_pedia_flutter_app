import 'package:cinema_pedia_app/presentation/views/views.dart';
import 'package:go_router/go_router.dart';
import 'package:cinema_pedia_app/presentation/screens/screens.dart';

final apppRouter = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return HomeScreen(childView: child);
      },
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
        GoRoute(
          path: '/favorites',
          builder: (context, state) => FavoritesView(),
        ),
      ],
    ),
  ],
);
