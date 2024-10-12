import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wolkup_app/features/profile/presentation/states/profile.dart';
import 'package:wolkup_app/features/auth/presentation/states/auth.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);

    final nameController = TextEditingController(text: profile.fullName ?? '');

    // Function to select an image
    Future<void> _pickImage() async {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        final result = await ref
            .read(profileProvider.notifier)
            .updateAvatar(pickedFile.path);

        if (result == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Avatar mis à jour')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(result)),
          );
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => _pickImage(),
              child: CircleAvatar(
                radius: 50,
                backgroundImage: profile.avatarUrl != null
                    ? NetworkImage(profile.avatarUrl!)
                    : null,
                child: profile.avatarUrl == null
                    ? const Icon(Icons.person, size: 50)
                    : null,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Nom complet',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final result =
                    await ref.read(profileProvider.notifier).updateProfile(
                          fullName: nameController.text,
                        );

                if (result == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Profil mis à jour')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(result)),
                  );
                }
              },
              child: const Text('Mettre à jour le profil'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _confirmDeleteAccount(context, ref),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('Supprimer le compte'),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                ref.read(authProvider.notifier).logout();
                context.go('/login'); // Redirect to login page after logout
              },
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }

  // _deleteAccount method here
  Future<void> _deleteAccount(BuildContext context, WidgetRef ref) async {
    final result = await ref.read(profileProvider.notifier).deleteAccount();

    if (result == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Compte supprimé avec succès')),
      );
      context.go('/login'); // Redirect to login after account deletion
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result)),
      );
    }
  }

  // Confirmation before account deletion
  void _confirmDeleteAccount(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: const Text(
              'Voulez-vous vraiment supprimer votre compte ? Cette action est irréversible.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                _deleteAccount(context, ref); // Call _deleteAccount
              },
              child: const Text('Confirmer'),
            ),
          ],
        );
      },
    );
  }
}
