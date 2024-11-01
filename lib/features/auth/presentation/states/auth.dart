import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:wolkup_app/core/resources/lib/supabase.dart';
import '../../domain/app_user.dart';

part 'auth.g.dart';

@Riverpod(keepAlive: true)
class Auth extends _$Auth {
  late final StreamSubscription<AuthState> _authStateSubscription;

  @override
  AppUser build() {
    initListener();

    return supabase.auth.currentSession == null
        ? AppUser.empty
        : AppUser.fromSession(supabase.auth.currentSession!);
  }

  initListener() {
    _authStateSubscription = supabase.auth.onAuthStateChange.listen((data) {
      state = AppUser.fromSession(data.session);
    });
  }

  Future<String?> login(String email, String password) async {
    try {
      await supabase.auth.signInWithPassword(password: password, email: email);

      return null;
    } on AuthException catch (er) {
      print(er.message);
      return er.message;
    } catch (err) {
      return err.toString();
    }
  }

  Future<String?> register(
      String email, String password, String fullName) async {
    try {
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
      );

      if (response.user != null) {
        final userId = response.user!.id;

        // Insertion des informations dans la table profiles
        final profileResponse = await supabase.from('profiles').insert({
          'id': userId,
          'full_name': fullName,
          'avatar_url': null, // L'avatar peut être ajouté plus tard
        });

        if (profileResponse.error != null) {
          return profileResponse.error!.message;
        }
      }

      return null;
    } on AuthException catch (er) {
      return er.message;
    } catch (err) {
      return err.toString();
    }
  }

  // Méthode pour mettre à jour le nom d'utilisateur
  Future<String?> updateProfile({required String displayName}) async {
    try {
      final user = supabase.auth.currentUser;
      if (user == null) {
        return 'Utilisateur non authentifié';
      }

      final response = await supabase.from('users').update({
        'displayName': displayName,
      }).eq('id', user.id);

      if (response.error != null) {
        return response.error!.message;
      }

      // Mettre à jour l'état local
      state = state.copyWith(displayName: displayName);
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  logout() async {
    await supabase.auth.signOut();
  }

  dispose() {
    _authStateSubscription.cancel();
  }
}
