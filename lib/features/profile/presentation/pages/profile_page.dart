import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wolkup_app/features/profile/presentation/states/profile.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);

    final nameController = TextEditingController(text: profile.fullName ?? '');

    // Fonction pour sélectionner une image
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
                backgroundColor: Colors.red, // Bouton rouge pour la suppression
              ),
              child: const Text('Supprimer le compte'),
            ),
          ],
        ),
      ),
    );
  }

  // Méthode _deleteAccount définie ici
  Future<void> _deleteAccount(BuildContext context, WidgetRef ref) async {
    final result = await ref.read(profileProvider.notifier).deleteAccount();

    if (result == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Compte supprimé avec succès')),
      );
      Navigator.of(context).pushReplacementNamed('/login');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result)),
      );
    }
  }

  // Confirmation avant suppression du compte
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
                Navigator.of(context).pop(); // Fermer la boîte de dialogue
              },
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fermer la boîte de dialogue
                _deleteAccount(context, ref); // Appeler _deleteAccount
              },
              child: const Text('Confirmer'),
            ),
          ],
        );
      },
    );
  }
}
