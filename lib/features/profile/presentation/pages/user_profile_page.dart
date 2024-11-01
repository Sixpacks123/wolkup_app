import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../states/profile_user_provider.dart';
import '../widgets/avatar_display.dart';
import '../widgets/points_display.dart';

class UserProfilePage extends ConsumerStatefulWidget {
  const UserProfilePage({super.key});

  @override
  ConsumerState<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends ConsumerState<UserProfilePage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ref.read(profileUserProvider.notifier).loadUserProfile(); // Load user profile when dependencies change
  }

  void _showAvatarSelectionDialog() {
    final points = ref.read(profileUserProvider).value?['points'] ?? 0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Sélectionnez votre Avatar"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildAvatarOption('assets/images/avatars/avatar1.png', points),
              _buildAvatarOption('assets/images/avatars/avatar2.png', points),
              _buildAvatarOption('assets/images/avatars/avatar3.png', points),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Fermer"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAvatarOption(String avatarPath, int points) {
    bool isUnlocked = false; // Logic to determine if the avatar is unlocked based on points

    // Define required points for each avatar
    if (avatarPath == 'assets/images/avatars/avatar2.png') {
      isUnlocked = points >= 100;
    } else if (avatarPath == 'assets/images/avatars/avatar3.png') {
      isUnlocked = points >= 200;
    } else {
      isUnlocked = true; // Avatar1 is always unlocked
    }

    return GestureDetector(
      onTap: isUnlocked
          ? () {
        ref.read(profileUserProvider.notifier).updateAvatar(avatarPath);
        Navigator.of(context).pop(); // Close dialog after selection
      }
          : null, // Disable selection if locked
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage(avatarPath),
            foregroundColor: isUnlocked ? null : Colors.grey, // Gray out locked avatars
          ),
          const SizedBox(height: 8),
          if (!isUnlocked)
            const Text("Verrouillé", style: TextStyle(color: Colors.red)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProfileAsync = ref.watch(profileUserProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.shadow,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              context.go('/settings');
            },
          ),
        ],
      ),
      body: userProfileAsync.when(
        data: (data) {
          final profile = data['profile'];
          final points = data['points'];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AvatarDisplay(avatarPath: profile.avatarUrl ?? ''),
                const SizedBox(height: 16),
                Text(
                  profile.fullName ?? 'Nom non spécifié',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  profile.email,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                PointsDisplay(points: points),
                const SizedBox(height: 20),

                // Button to change avatar
                ElevatedButton(
                  onPressed: _showAvatarSelectionDialog,
                  child: const Text("Changer Avatar"),
                ),

                const SizedBox(height: 20),

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
