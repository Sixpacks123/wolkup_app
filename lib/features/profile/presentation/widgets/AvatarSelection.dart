import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../states/profile_user_provider.dart';
import '../widgets/avatar_display.dart';

class AvatarSelection extends ConsumerWidget {
  final int points;
  const AvatarSelection({required this.points, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final avatars = [
      {'path': 'assets/images/avatars/avatar1.png', 'requiredPoints': 0},
      {'path': 'assets/images/avatars/avatar2.png', 'requiredPoints': 100},
      {'path': 'assets/images/avatars/avatar3.png', 'requiredPoints': 200},
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Sélectionnez un avatar", style: TextStyle(fontSize: 20)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 16,
            children: avatars.map((avatar) {
              final isUnlocked = points >= (avatar['requiredPoints'] as int);
              return GestureDetector(
                onTap: isUnlocked
                    ? () {
                  ref.read(profileUserProvider.notifier).updateAvatar(avatar['path'] as String);
                  Navigator.of(context).pop();
                }
                    : null,
                child: Opacity(
                  opacity: isUnlocked ? 1.0 : 0.5,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      AvatarDisplay(avatarPath: avatar['path'] as String),
                      if (!isUnlocked)
                        const Icon(Icons.lock, color: Colors.black54),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
