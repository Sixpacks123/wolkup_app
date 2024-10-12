// core/ui/widgets/bottom_bar.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomBar extends StatelessWidget {
  final int currentIndex;

  const BottomBar({super.key, required this.currentIndex});

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/'); // Page Home
        break;
      case 1:
        context.go('/profile'); // Page Profile
        break;
      // Ajoutez d'autres routes ici si nécessaire
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) => _onItemTapped(context, index),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
        // Ajoutez plus d'items ici si nécessaire
      ],
    );
  }
}
