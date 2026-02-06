import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottonNavigationbarWithScaffold extends StatelessWidget {
  const CustomBottonNavigationbarWithScaffold({
    super.key,
    required this.navigationSheel,
  });

  final StatefulNavigationShell navigationSheel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationSheel,
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        currentIndex: navigationSheel.currentIndex,
        onTap: (value) => {
          // Cambia de rama preservando el estado
          navigationSheel.goBranch(
            value,
            // Soporte nativo para ir al inicio de la rama si ya se esta en ella
            initialLocation: value == navigationSheel.currentIndex,
          ),
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.label_outlined),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
