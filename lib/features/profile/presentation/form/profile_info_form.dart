import 'package:flutter/material.dart';
import '../../domain/profile_user.dart';

class ProfileInfoForm extends StatelessWidget {
  final ProfileUser profile;

  const ProfileInfoForm({required this.profile, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          initialValue: profile.fullName,
          decoration: const InputDecoration(labelText: 'Nom'),
          onChanged: (value) {
            // Gérer la mise à jour du nom
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          initialValue: profile.email,
          decoration: const InputDecoration(labelText: 'Email'),
          onChanged: (value) {
            // Gérer la mise à jour de l'email
          },
        ),
      ],
    );
  }
}
