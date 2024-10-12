import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'profile_user.freezed.dart';
part 'profile_user.g.dart';

@freezed
class ProfileUser with _$ProfileUser {
  const factory ProfileUser({
    required String uid,
    required String email,
    String? fullName,
    String? avatarUrl,
  }) = _ProfileUser;

  factory ProfileUser.fromJson(Map<String, dynamic> json) =>
      _$ProfileUserFromJson(json);

  // Récupération du profil depuis la session Supabase
  factory ProfileUser.fromSession(Session? session) => session == null
      ? empty
      : ProfileUser(
          uid: session.user.id,
          email: session.user.email ?? '',
          fullName: session.user.userMetadata?['full_name'],
          avatarUrl: session.user.userMetadata?['avatar_url'],
        );

  static ProfileUser empty = const ProfileUser(
    uid: '',
    email: '',
  );
}

extension UserX on ProfileUser {
  bool get isEmpty => this == ProfileUser.empty;
}
