// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$User {

/// Primary key
 int get id;/// Unique login username
 String get username;/// Display name for UI
 String get displayName;/// Hashed password (BCrypt)
 String get passwordHash;/// User role (Admin/Artist)
 UserRole get role;/// UI theme preference key
 String get themeKey;/// Path to avatar image
 String get avatarPath;/// Default hourly rate
 double get hourlyRate;/// Work speed multiplier
 double get speedFactor;/// Account creation timestamp
 DateTime get createdAt;/// Last update timestamp
 DateTime get updatedAt;/// Last login timestamp
 DateTime? get lastLoginAt;/// Whether account is active
 bool get isActive;/// Soft delete flag
 bool get isDeleted;/// Deletion timestamp
 DateTime? get deletedAt;/// Department assignment
 String get department;/// Commission rate (0-1, e.g., 0.1 = 10%)
 double get commissionRate;/// UI font size preference
 int get fontSize;/// JSON string for keyboard shortcuts
 String get keyboardShortcutsJson;/// JSON string for permissions
 String get permissionsJson;
/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserCopyWith<User> get copyWith => _$UserCopyWithImpl<User>(this as User, _$identity);

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is User&&(identical(other.id, id) || other.id == id)&&(identical(other.username, username) || other.username == username)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.passwordHash, passwordHash) || other.passwordHash == passwordHash)&&(identical(other.role, role) || other.role == role)&&(identical(other.themeKey, themeKey) || other.themeKey == themeKey)&&(identical(other.avatarPath, avatarPath) || other.avatarPath == avatarPath)&&(identical(other.hourlyRate, hourlyRate) || other.hourlyRate == hourlyRate)&&(identical(other.speedFactor, speedFactor) || other.speedFactor == speedFactor)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.lastLoginAt, lastLoginAt) || other.lastLoginAt == lastLoginAt)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.department, department) || other.department == department)&&(identical(other.commissionRate, commissionRate) || other.commissionRate == commissionRate)&&(identical(other.fontSize, fontSize) || other.fontSize == fontSize)&&(identical(other.keyboardShortcutsJson, keyboardShortcutsJson) || other.keyboardShortcutsJson == keyboardShortcutsJson)&&(identical(other.permissionsJson, permissionsJson) || other.permissionsJson == permissionsJson));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,username,displayName,passwordHash,role,themeKey,avatarPath,hourlyRate,speedFactor,createdAt,updatedAt,lastLoginAt,isActive,isDeleted,deletedAt,department,commissionRate,fontSize,keyboardShortcutsJson,permissionsJson]);

@override
String toString() {
  return 'User(id: $id, username: $username, displayName: $displayName, passwordHash: $passwordHash, role: $role, themeKey: $themeKey, avatarPath: $avatarPath, hourlyRate: $hourlyRate, speedFactor: $speedFactor, createdAt: $createdAt, updatedAt: $updatedAt, lastLoginAt: $lastLoginAt, isActive: $isActive, isDeleted: $isDeleted, deletedAt: $deletedAt, department: $department, commissionRate: $commissionRate, fontSize: $fontSize, keyboardShortcutsJson: $keyboardShortcutsJson, permissionsJson: $permissionsJson)';
}


}

/// @nodoc
abstract mixin class $UserCopyWith<$Res>  {
  factory $UserCopyWith(User value, $Res Function(User) _then) = _$UserCopyWithImpl;
@useResult
$Res call({
 int id, String username, String displayName, String passwordHash, UserRole role, String themeKey, String avatarPath, double hourlyRate, double speedFactor, DateTime createdAt, DateTime updatedAt, DateTime? lastLoginAt, bool isActive, bool isDeleted, DateTime? deletedAt, String department, double commissionRate, int fontSize, String keyboardShortcutsJson, String permissionsJson
});




}
/// @nodoc
class _$UserCopyWithImpl<$Res>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._self, this._then);

  final User _self;
  final $Res Function(User) _then;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? username = null,Object? displayName = null,Object? passwordHash = null,Object? role = null,Object? themeKey = null,Object? avatarPath = null,Object? hourlyRate = null,Object? speedFactor = null,Object? createdAt = null,Object? updatedAt = null,Object? lastLoginAt = freezed,Object? isActive = null,Object? isDeleted = null,Object? deletedAt = freezed,Object? department = null,Object? commissionRate = null,Object? fontSize = null,Object? keyboardShortcutsJson = null,Object? permissionsJson = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,passwordHash: null == passwordHash ? _self.passwordHash : passwordHash // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as UserRole,themeKey: null == themeKey ? _self.themeKey : themeKey // ignore: cast_nullable_to_non_nullable
as String,avatarPath: null == avatarPath ? _self.avatarPath : avatarPath // ignore: cast_nullable_to_non_nullable
as String,hourlyRate: null == hourlyRate ? _self.hourlyRate : hourlyRate // ignore: cast_nullable_to_non_nullable
as double,speedFactor: null == speedFactor ? _self.speedFactor : speedFactor // ignore: cast_nullable_to_non_nullable
as double,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastLoginAt: freezed == lastLoginAt ? _self.lastLoginAt : lastLoginAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,department: null == department ? _self.department : department // ignore: cast_nullable_to_non_nullable
as String,commissionRate: null == commissionRate ? _self.commissionRate : commissionRate // ignore: cast_nullable_to_non_nullable
as double,fontSize: null == fontSize ? _self.fontSize : fontSize // ignore: cast_nullable_to_non_nullable
as int,keyboardShortcutsJson: null == keyboardShortcutsJson ? _self.keyboardShortcutsJson : keyboardShortcutsJson // ignore: cast_nullable_to_non_nullable
as String,permissionsJson: null == permissionsJson ? _self.permissionsJson : permissionsJson // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [User].
extension UserPatterns on User {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _User value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _User() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _User value)  $default,){
final _that = this;
switch (_that) {
case _User():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _User value)?  $default,){
final _that = this;
switch (_that) {
case _User() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String username,  String displayName,  String passwordHash,  UserRole role,  String themeKey,  String avatarPath,  double hourlyRate,  double speedFactor,  DateTime createdAt,  DateTime updatedAt,  DateTime? lastLoginAt,  bool isActive,  bool isDeleted,  DateTime? deletedAt,  String department,  double commissionRate,  int fontSize,  String keyboardShortcutsJson,  String permissionsJson)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _User() when $default != null:
return $default(_that.id,_that.username,_that.displayName,_that.passwordHash,_that.role,_that.themeKey,_that.avatarPath,_that.hourlyRate,_that.speedFactor,_that.createdAt,_that.updatedAt,_that.lastLoginAt,_that.isActive,_that.isDeleted,_that.deletedAt,_that.department,_that.commissionRate,_that.fontSize,_that.keyboardShortcutsJson,_that.permissionsJson);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String username,  String displayName,  String passwordHash,  UserRole role,  String themeKey,  String avatarPath,  double hourlyRate,  double speedFactor,  DateTime createdAt,  DateTime updatedAt,  DateTime? lastLoginAt,  bool isActive,  bool isDeleted,  DateTime? deletedAt,  String department,  double commissionRate,  int fontSize,  String keyboardShortcutsJson,  String permissionsJson)  $default,) {final _that = this;
switch (_that) {
case _User():
return $default(_that.id,_that.username,_that.displayName,_that.passwordHash,_that.role,_that.themeKey,_that.avatarPath,_that.hourlyRate,_that.speedFactor,_that.createdAt,_that.updatedAt,_that.lastLoginAt,_that.isActive,_that.isDeleted,_that.deletedAt,_that.department,_that.commissionRate,_that.fontSize,_that.keyboardShortcutsJson,_that.permissionsJson);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String username,  String displayName,  String passwordHash,  UserRole role,  String themeKey,  String avatarPath,  double hourlyRate,  double speedFactor,  DateTime createdAt,  DateTime updatedAt,  DateTime? lastLoginAt,  bool isActive,  bool isDeleted,  DateTime? deletedAt,  String department,  double commissionRate,  int fontSize,  String keyboardShortcutsJson,  String permissionsJson)?  $default,) {final _that = this;
switch (_that) {
case _User() when $default != null:
return $default(_that.id,_that.username,_that.displayName,_that.passwordHash,_that.role,_that.themeKey,_that.avatarPath,_that.hourlyRate,_that.speedFactor,_that.createdAt,_that.updatedAt,_that.lastLoginAt,_that.isActive,_that.isDeleted,_that.deletedAt,_that.department,_that.commissionRate,_that.fontSize,_that.keyboardShortcutsJson,_that.permissionsJson);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _User extends User {
  const _User({required this.id, required this.username, this.displayName = '', this.passwordHash = '', this.role = UserRole.artist, this.themeKey = 'InfernalNeon', this.avatarPath = '', this.hourlyRate = 150.0, this.speedFactor = 1.0, required this.createdAt, required this.updatedAt, this.lastLoginAt, this.isActive = true, this.isDeleted = false, this.deletedAt, this.department = '', this.commissionRate = 0.0, this.fontSize = 14, this.keyboardShortcutsJson = '', this.permissionsJson = ''}): super._();
  factory _User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

/// Primary key
@override final  int id;
/// Unique login username
@override final  String username;
/// Display name for UI
@override@JsonKey() final  String displayName;
/// Hashed password (BCrypt)
@override@JsonKey() final  String passwordHash;
/// User role (Admin/Artist)
@override@JsonKey() final  UserRole role;
/// UI theme preference key
@override@JsonKey() final  String themeKey;
/// Path to avatar image
@override@JsonKey() final  String avatarPath;
/// Default hourly rate
@override@JsonKey() final  double hourlyRate;
/// Work speed multiplier
@override@JsonKey() final  double speedFactor;
/// Account creation timestamp
@override final  DateTime createdAt;
/// Last update timestamp
@override final  DateTime updatedAt;
/// Last login timestamp
@override final  DateTime? lastLoginAt;
/// Whether account is active
@override@JsonKey() final  bool isActive;
/// Soft delete flag
@override@JsonKey() final  bool isDeleted;
/// Deletion timestamp
@override final  DateTime? deletedAt;
/// Department assignment
@override@JsonKey() final  String department;
/// Commission rate (0-1, e.g., 0.1 = 10%)
@override@JsonKey() final  double commissionRate;
/// UI font size preference
@override@JsonKey() final  int fontSize;
/// JSON string for keyboard shortcuts
@override@JsonKey() final  String keyboardShortcutsJson;
/// JSON string for permissions
@override@JsonKey() final  String permissionsJson;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserCopyWith<_User> get copyWith => __$UserCopyWithImpl<_User>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _User&&(identical(other.id, id) || other.id == id)&&(identical(other.username, username) || other.username == username)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.passwordHash, passwordHash) || other.passwordHash == passwordHash)&&(identical(other.role, role) || other.role == role)&&(identical(other.themeKey, themeKey) || other.themeKey == themeKey)&&(identical(other.avatarPath, avatarPath) || other.avatarPath == avatarPath)&&(identical(other.hourlyRate, hourlyRate) || other.hourlyRate == hourlyRate)&&(identical(other.speedFactor, speedFactor) || other.speedFactor == speedFactor)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.lastLoginAt, lastLoginAt) || other.lastLoginAt == lastLoginAt)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.department, department) || other.department == department)&&(identical(other.commissionRate, commissionRate) || other.commissionRate == commissionRate)&&(identical(other.fontSize, fontSize) || other.fontSize == fontSize)&&(identical(other.keyboardShortcutsJson, keyboardShortcutsJson) || other.keyboardShortcutsJson == keyboardShortcutsJson)&&(identical(other.permissionsJson, permissionsJson) || other.permissionsJson == permissionsJson));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,username,displayName,passwordHash,role,themeKey,avatarPath,hourlyRate,speedFactor,createdAt,updatedAt,lastLoginAt,isActive,isDeleted,deletedAt,department,commissionRate,fontSize,keyboardShortcutsJson,permissionsJson]);

@override
String toString() {
  return 'User(id: $id, username: $username, displayName: $displayName, passwordHash: $passwordHash, role: $role, themeKey: $themeKey, avatarPath: $avatarPath, hourlyRate: $hourlyRate, speedFactor: $speedFactor, createdAt: $createdAt, updatedAt: $updatedAt, lastLoginAt: $lastLoginAt, isActive: $isActive, isDeleted: $isDeleted, deletedAt: $deletedAt, department: $department, commissionRate: $commissionRate, fontSize: $fontSize, keyboardShortcutsJson: $keyboardShortcutsJson, permissionsJson: $permissionsJson)';
}


}

/// @nodoc
abstract mixin class _$UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$UserCopyWith(_User value, $Res Function(_User) _then) = __$UserCopyWithImpl;
@override @useResult
$Res call({
 int id, String username, String displayName, String passwordHash, UserRole role, String themeKey, String avatarPath, double hourlyRate, double speedFactor, DateTime createdAt, DateTime updatedAt, DateTime? lastLoginAt, bool isActive, bool isDeleted, DateTime? deletedAt, String department, double commissionRate, int fontSize, String keyboardShortcutsJson, String permissionsJson
});




}
/// @nodoc
class __$UserCopyWithImpl<$Res>
    implements _$UserCopyWith<$Res> {
  __$UserCopyWithImpl(this._self, this._then);

  final _User _self;
  final $Res Function(_User) _then;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? username = null,Object? displayName = null,Object? passwordHash = null,Object? role = null,Object? themeKey = null,Object? avatarPath = null,Object? hourlyRate = null,Object? speedFactor = null,Object? createdAt = null,Object? updatedAt = null,Object? lastLoginAt = freezed,Object? isActive = null,Object? isDeleted = null,Object? deletedAt = freezed,Object? department = null,Object? commissionRate = null,Object? fontSize = null,Object? keyboardShortcutsJson = null,Object? permissionsJson = null,}) {
  return _then(_User(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,passwordHash: null == passwordHash ? _self.passwordHash : passwordHash // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as UserRole,themeKey: null == themeKey ? _self.themeKey : themeKey // ignore: cast_nullable_to_non_nullable
as String,avatarPath: null == avatarPath ? _self.avatarPath : avatarPath // ignore: cast_nullable_to_non_nullable
as String,hourlyRate: null == hourlyRate ? _self.hourlyRate : hourlyRate // ignore: cast_nullable_to_non_nullable
as double,speedFactor: null == speedFactor ? _self.speedFactor : speedFactor // ignore: cast_nullable_to_non_nullable
as double,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastLoginAt: freezed == lastLoginAt ? _self.lastLoginAt : lastLoginAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,department: null == department ? _self.department : department // ignore: cast_nullable_to_non_nullable
as String,commissionRate: null == commissionRate ? _self.commissionRate : commissionRate // ignore: cast_nullable_to_non_nullable
as double,fontSize: null == fontSize ? _self.fontSize : fontSize // ignore: cast_nullable_to_non_nullable
as int,keyboardShortcutsJson: null == keyboardShortcutsJson ? _self.keyboardShortcutsJson : keyboardShortcutsJson // ignore: cast_nullable_to_non_nullable
as String,permissionsJson: null == permissionsJson ? _self.permissionsJson : permissionsJson // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
