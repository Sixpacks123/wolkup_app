import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../auth/presentation/states/auth.dart'; // Import du provider d'auth

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Go back to the previous page
            context.go('/'); // Adjust this to your desired back navigation
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: const Text('Informations personnelles', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              context.go('/settings/personal_info'); // Use GoRouter for navigation
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Changer le mot de passe',style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              // Navigate to password change page (create this page later)
              // Example: context.go('/settings/change_password');
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Déconnexion',style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
            trailing: const Icon(Icons.logout),
            onTap: () {
              ref.read(authProvider.notifier).logout();
              context.go('/login'); // Redirect to login page after logout
            },
          ),
        ],
      ),
    );
  }
}
