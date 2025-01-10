import 'package:flutter/material.dart';
import 'package:wolkup_app/features/maps/maps.dart';
import '../../features/profile/presentation/pages/user_profile_page.dart';
import '../../features/reporting/presentation/pages/report_status_page.dart';
import '../../features/shop/presentation/pages/shopPage.dart';

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
        children: const [
          MapPage(),
          UserReportStatusPage(),
          SpendWolksPage(),
          UserProfilePage(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.shadow,

            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              spreadRadius: 3,
              blurRadius: 8,
              offset: const Offset(0, -1), // Ombre subtile au-dessus de la barre
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              if (index != 9) { // Ignore le bouton central
                _onItemTapped(index);
              }
            },
            backgroundColor: Colors.transparent,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Theme.of(context).colorScheme.secondary,
            unselectedItemColor: Colors.white,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.map_outlined, size: 32),
                activeIcon: Icon(Icons.map, size: 32),
                label: 'Maps',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.flag_outlined, size: 32),
                activeIcon: Icon(Icons.flag, size: 32),
                label: 'Signal',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.card_giftcard, size: 32),
                activeIcon: Icon(Icons.card_giftcard, size: 32),
                label: 'Rewards',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline, size: 32),
                activeIcon: Icon(Icons.person, size: 32),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
