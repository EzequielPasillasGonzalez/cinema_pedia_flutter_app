import 'package:cinema_pedia_app/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

final apppRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: HomeScreen.name,
      builder: (context, state) => HomeScreen(),
    ),
  ],
);
