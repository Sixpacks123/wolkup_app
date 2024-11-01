import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../states/profile_user_provider.dart';

class PersonalInfoPage extends ConsumerWidget {
  const PersonalInfoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfileAsync = ref.watch(profileUserProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Informations personnelles'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back to the settings page
            context.go('/settings'); // Adjust this to go back to the settings page
          },
        ),
      ),
      body: userProfileAsync.when(
        data: (data) {
          final profile = data['profile'];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nom: ${profile.fullName ?? 'Non spécifié'}'),
                Text('Email: ${profile.email}'),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Logic for saving changes or other actions
                  },
                  child: const Text("Sauvegarder les modifications"),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text("Erreur: ${error.toString()}")),
      ),
    );
  }
}
