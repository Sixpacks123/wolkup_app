import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wolkup_app/core/resources/lib/supabase.dart';
import '../../domain/profile_user.dart';

final profileUserProvider = StateNotifierProvider<ProfileUserNotifier, AsyncValue<Map<String, dynamic>>>((ref) {
  return ProfileUserNotifier();
});

class ProfileUserNotifier extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  ProfileUserNotifier() : super(const AsyncValue.loading()) {
    loadUserProfile();
  }

  Future<void> loadUserProfile() async {
    try {
      final session = supabase.auth.currentSession;
      final userId = session?.user.id;
      if (userId == null) throw Exception("Utilisateur non connecté");

      // Récupérer les informations de profil
      final profileResponse = await supabase
          .from('profiles')
          .select('full_name, avatar_url')
          .eq('user_id', userId)
          .single();
      final email = session?.user.email ?? '';
      final profile = ProfileUser(
        uid: userId,
        email: email,
        fullName: profileResponse['full_name'],
        avatarUrl: profileResponse['avatar_url'],
      );

      // Récupérer les points de l'utilisateur
      final pointsResponse = await supabase
          .from('user_points')
          .select('total_points')
          .eq('user_id', userId)
          .single();
      final points = pointsResponse['total_points'] as int;

      state = AsyncValue.data({
        'profile': profile,
        'points': points,
      });
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> updateAvatar(String newAvatarUrl) async {
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) return;

    await supabase.from('profiles').update({'avatar_url': newAvatarUrl}).eq('user_id', userId);
    loadUserProfile(); // Recharge les données pour mettre à jour l'avatar
  }

  Future<void> deleteAccount() async {
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) return;

    await supabase.from('profiles').delete().eq('user_id', userId);
    await supabase.auth.signOut();
    state = const AsyncValue.loading();
  }
}
