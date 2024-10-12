// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProfileUser _$ProfileUserFromJson(Map<String, dynamic> json) {
  return _ProfileUser.fromJson(json);
}

/// @nodoc
mixin _$ProfileUser {
  String get uid => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get fullName => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;

  /// Serializes this ProfileUser to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProfileUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfileUserCopyWith<ProfileUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileUserCopyWith<$Res> {
  factory $ProfileUserCopyWith(
          ProfileUser value, $Res Function(ProfileUser) then) =
      _$ProfileUserCopyWithImpl<$Res, ProfileUser>;
  @useResult
  $Res call({String uid, String email, String? fullName, String? avatarUrl});
}

/// @nodoc
class _$ProfileUserCopyWithImpl<$Res, $Val extends ProfileUser>
    implements $ProfileUserCopyWith<$Res> {
  _$ProfileUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfileUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? email = null,
    Object? fullName = freezed,
    Object? avatarUrl = freezed,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: freezed == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProfileUserImplCopyWith<$Res>
    implements $ProfileUserCopyWith<$Res> {
  factory _$$ProfileUserImplCopyWith(
          _$ProfileUserImpl value, $Res Function(_$ProfileUserImpl) then) =
      __$$ProfileUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String uid, String email, String? fullName, String? avatarUrl});
}

/// @nodoc
class __$$ProfileUserImplCopyWithImpl<$Res>
    extends _$ProfileUserCopyWithImpl<$Res, _$ProfileUserImpl>
    implements _$$ProfileUserImplCopyWith<$Res> {
  __$$ProfileUserImplCopyWithImpl(
      _$ProfileUserImpl _value, $Res Function(_$ProfileUserImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProfileUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? email = null,
    Object? fullName = freezed,
    Object? avatarUrl = freezed,
  }) {
    return _then(_$ProfileUserImpl(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: freezed == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfileUserImpl implements _ProfileUser {
  const _$ProfileUserImpl(
      {required this.uid, required this.email, this.fullName, this.avatarUrl});

  factory _$ProfileUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfileUserImplFromJson(json);

  @override
  final String uid;
  @override
  final String email;
  @override
  final String? fullName;
  @override
  final String? avatarUrl;

  @override
  String toString() {
    return 'ProfileUser(uid: $uid, email: $email, fullName: $fullName, avatarUrl: $avatarUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileUserImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, uid, email, fullName, avatarUrl);

  /// Create a copy of ProfileUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileUserImplCopyWith<_$ProfileUserImpl> get copyWith =>
      __$$ProfileUserImplCopyWithImpl<_$ProfileUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfileUserImplToJson(
      this,
    );
  }
}

abstract class _ProfileUser implements ProfileUser {
  const factory _ProfileUser(
      {required final String uid,
      required final String email,
      final String? fullName,
      final String? avatarUrl}) = _$ProfileUserImpl;

  factory _ProfileUser.fromJson(Map<String, dynamic> json) =
      _$ProfileUserImpl.fromJson;

  @override
  String get uid;
  @override
  String get email;
  @override
  String? get fullName;
  @override
  String? get avatarUrl;

  /// Create a copy of ProfileUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileUserImplCopyWith<_$ProfileUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
