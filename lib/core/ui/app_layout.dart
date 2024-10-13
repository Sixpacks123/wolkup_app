import 'package:flutter/material.dart';
import 'package:wolkup_app/features/home/presentation/pages/home_page.dart';
import 'package:wolkup_app/features/maps/maps.dart';
import 'package:wolkup_app/features/profile/presentation/pages/profile_page.dart';

class AppLayout extends StatefulWidget {
  const AppLayout({super.key});

  @override
  _AppLayoutState createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  int _currentIndex = 0;

  // Méthode pour changer la page sans animation sur la BottomNavigationBar
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          MapPage(),
          const HomePage(),
          const ProfilePage(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 10,
              offset: const Offset(0, -2), // Ombre légère au-dessus de la barre
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
          backgroundColor: Colors.white, // Couleur de fond
          type: BottomNavigationBarType.fixed,
          selectedItemColor:
              Colors.blueAccent, // Couleur de l'élément sélectionné
          unselectedItemColor:
              Colors.grey, // Couleur des éléments non sélectionnés
          selectedLabelStyle: const TextStyle(
            fontWeight:
                FontWeight.bold, // Texte en gras pour l'élément sélectionné
          ),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.map_outlined, size: 28),
              activeIcon: Icon(Icons.map, size: 28),
              label: 'Maps',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined, size: 28),
              activeIcon: Icon(Icons.home, size: 28),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline, size: 28),
              activeIcon: Icon(Icons.person, size: 28),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
