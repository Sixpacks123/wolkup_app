import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../themes/theme_provider.dart';
import '../../../auth/presentation/states/auth.dart'; // Import du provider d'auth

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres',),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,),
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
            title: const Text('Informations personnelles'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              context.go('/settings/personal_info'); // Use GoRouter for naviga      tion
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Changer le mot de passe',),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              // Navigate to password change page (create this page later)
              // Example: context.go('/settings/change_password');
            },
          ),

          const Divider(),
          ListTile(
            title: const Text('Mode nuit'),
            trailing: Switch(
              value: isDarkMode,
              onChanged: (value) {
                ref.read(themeProvider.notifier).toggleTheme();
              },
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('Déconnexion',),
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
