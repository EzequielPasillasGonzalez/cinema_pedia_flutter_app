import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottonNavigationbar extends StatelessWidget {
  const CustomBottonNavigationbar({super.key});

  int getCurrenIndex(BuildContext context) {
    final String location = GoRouterState.of(context).matchedLocation;

    // if (location) return 0;

    switch (location) {
      case '/':
        return 0;
      case '/categories':
        return 1;
      case '/favorites':
        return 2;

      default:
        return 0;
    }
  }

  void onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/');
        break;
      case 2:
        context.go('/favorites');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      currentIndex: getCurrenIndex(context),
      onTap: (value) => onItemTapped(context, value),
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.label_outlined),
          label: 'Categories',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outline),
          label: 'Favorites',
        ),
      ],
    );
  }
}
