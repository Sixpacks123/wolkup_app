import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../themes/theme_provider.dart';
import '../../../auth/presentation/states/auth.dart';
import '../../domain/profile_user.dart';
import '../states/profile_user_provider.dart';

class UserProfilePage extends ConsumerStatefulWidget {
  const UserProfilePage({super.key});

  @override
  ConsumerState<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends ConsumerState<UserProfilePage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ref.read(profileUserProvider.notifier).loadUserProfile();
  }@override
  Widget build(BuildContext context) {
    final userProfileAsync = ref.watch(profileUserProvider);
    final isDarkMode = ref.watch(themeProvider).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'PROFIL',

        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: userProfileAsync.when(
        data: (data) {
          final profile = data['profile'] as ProfileUser;
          final points = data['points'] as int;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Carte utilisateur
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(1.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Avatar
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: profile.avatarUrl?.startsWith('http') == true
                              ? NetworkImage(profile.avatarUrl!)
                              : AssetImage(profile.avatarUrl ?? 'assets/images/default-avatar.png')
                          as ImageProvider,
                        ),
                        const SizedBox(height: 16),

                        // Nom complet
                        Text(
                          profile.fullName ?? 'Nom non spécifié',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Points
                        const Text(
                          'Points',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.diamond, color: Colors.green, size: 20),
                            const SizedBox(width: 4),
                            Text(
                              points.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Nom d'utilisateur
                        Text(
                          'Nom d\'utilisateur : ${profile.email ?? 'Non spécifié'}',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Inscrit(e) il y a 6 mois', // Ajouter une donnée dynamique si disponible
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Espacement entre la carte utilisateur et la section des paramètres
                const SizedBox(height: 16),

                // Section des paramètres
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      // Liste 1 : Informations personnelles
                      ListTile(
                        tileColor: Theme.of(context).colorScheme.primary,

                        title: const Text('Informations personnelles',),
                        trailing: const Icon(Icons.arrow_forward, color: Colors.white,),
                        onTap: () {
                          context.go('/settings/personal_info');
                        },
                      ),
                      const Divider(),

                      // Liste 2 : Changer le mot de passe
                      ListTile(
                        tileColor: Theme.of(context).colorScheme.primary,
                        title: const Text('Changer le mot de passe'),
                        trailing: const Icon(Icons.arrow_forward, color: Colors.white),
                        onTap: () {
                          // Naviguer vers la page de changement de mot de passe
                        },
                      ),
                      const Divider(),

                      // Liste 3 : Mode nuit
                      ListTile(
                        tileColor: Theme.of(context).colorScheme.primary,

                        title: const Text('Mode nuit'),
                        trailing: Switch(
                          value: isDarkMode,
                          onChanged: (value) {
                            ref.read(themeProvider.notifier).toggleTheme();
                          },
                        ),
                      ),
                      const Divider(),

                      // Liste 4 : Déconnexion
                      ListTile(
                        tileColor: Theme.of(context).colorScheme.primary,

                        title: const Text('Déconnexion'),
                        trailing: const Icon(Icons.logout, color: Colors.white),
                        onTap: () {
                          ref.read(authProvider.notifier).logout();
                          context.go('/login'); // Redirection après déconnexion
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text("Erreur: ${error.toString()}"),
        ),
      ),
    );
  }


}

