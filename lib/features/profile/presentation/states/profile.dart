import 'dart:async';
import 'dart:io';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wolkup_app/features/profile/domain/profile_user.dart';
import 'package:wolkup_app/core/core.dart';

part 'profile.g.dart';

@Riverpod(keepAlive: true)
class Profile extends _$Profile {
  late final StreamSubscription<AuthState> _authStateSubscription;

  @override
  ProfileUser build() {
    initListener();
    return supabase.auth.currentSession == null
        ? ProfileUser.empty
        : ProfileUser.fromSession(supabase.auth.currentSession!);
  }

  void initListener() {
    _authStateSubscription =
        supabase.auth.onAuthStateChange.listen((data) async {
      final userId = data.session?.user.id;
      if (userId != null) {
        // Récupérer les données du profil dans la table 'profiles'
        try {
          final profileResponse = await supabase
              .from('profiles')
              .select()
              .eq('id', userId)
              .single(); // Récupérer une seule ligne

          // Vérification si des données ont été renvoyées
          final profileData = profileResponse;

          // Mettre à jour l'état avec les données du profil
          state = ProfileUser(
            uid: userId,
            email: data.session!.user.email ?? '',
            fullName: profileData['full_name'] as String?,
            avatarUrl: profileData['avatar_url'] as String?,
          );
        } catch (e) {
          print('Erreur inattendue lors de la récupération du profil : $e');
        }
      }
    });
  }

  Future<String?> updateProfile(
      {required String fullName, String? avatarUrl}) async {
    try {
      final userId = supabase.auth.currentUser?.id;
      if (userId == null) {
        return 'Utilisateur non authentifié';
      }

      final updates = {
        'full_name': fullName,
        'updated_at': DateTime.now().toUtc().toIso8601String(),
      };

      if (avatarUrl != null) {
        updates['avatar_url'] = avatarUrl;
      }

      print('Données envoyées pour mise à jour : $updates');

      // Exécuter la requête de mise à jour
      final response =
          await supabase.from('profiles').update(updates).eq('id', userId);

      // Vérifiez si la réponse contient des données
      if (response.data == null) {
        return 'Erreur inconnue lors de la mise à jour du profil.';
      }

      // Mettre à jour l'état local avec les nouvelles valeurs
      state = state.copyWith(fullName: fullName, avatarUrl: avatarUrl);
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> updateAvatar(String filePath) async {
    try {
      final user = supabase.auth.currentUser;
      if (user == null) {
        return 'Utilisateur non authentifié';
      }

      final fileName = '${user.id}.png';
      final storageResponse = await supabase.storage
          .from('avatars')
          .upload(fileName, File(filePath));

      if (storageResponse.isEmpty) {
        return 'Erreur lors du téléversement du fichier';
      }

      final avatarUrl = supabase.storage.from('avatars').getPublicUrl(fileName);

      // Mettre à jour l'URL de l'avatar dans la base de données
      final response = await supabase.from('profiles').update({
        'avatar_url': avatarUrl,
      }).eq('id', user.id);

      if (response.data == null) {
        return 'Erreur lors de la mise à jour de l\'avatar.';
      }

      // Mettre à jour l'état local
      state = state.copyWith(avatarUrl: avatarUrl);
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> deleteAccount() async {
    try {
      final user = supabase.auth.currentUser;
      if (user == null) {
        return 'Utilisateur non authentifié';
      }

      // Supprimer les informations de profil de la table 'profiles'
      final deleteProfileResponse =
          await supabase.from('profiles').delete().eq('id', user.id);

      if (deleteProfileResponse.data == null) {
        return 'Erreur lors de la suppression du profil.';
      }

      // Supprimer l'utilisateur de Supabase Auth
      await supabase.auth.admin.deleteUser(user.id);

      return null; // Succès si tout s'est bien passé
    } catch (e) {
      return e.toString();
    }
  }

  void dispose() {
    _authStateSubscription.cancel();
  }
}
