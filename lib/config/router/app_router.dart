import 'package:go_router/go_router.dart';
import 'package:cinema_pedia_app/presentation/screens/screens.dart';

final apppRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: HomeScreen.name,
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: 'movie/:id',
      name: MovieScreen.name,
      builder: (context, state) {
        final movieID = state.pathParameters['id'] ?? 'no-id';

        return MovieScreen(movieId: movieID);
      },
    ),
  ],
);
