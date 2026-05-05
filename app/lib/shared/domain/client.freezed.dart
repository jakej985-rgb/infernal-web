// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'client.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Client {

/// Primary key
 int get id;/// Sync identifier for multi-device sync
 String get syncId;/// First name
 String get firstName;/// Middle name (optional)
 String get middleName;/// Last name
 String get lastName;/// Phone number
 String get phone;/// Email address
 String get email;/// Free-form notes about the client
 String get notes;/// Number of visits
 int get visits;/// Path to profile photo
 String get photoPath;/// Client status (Bound/FreshSoul/HighValue/Void)
 ClientStatus get status;/// Last modification timestamp (UTC)
 DateTime get lastModifiedUtc;/// User who last modified this record
 String get lastModifiedBy;/// Soft delete flag
 bool get isDeleted;
/// Create a copy of Client
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClientCopyWith<Client> get copyWith => _$ClientCopyWithImpl<Client>(this as Client, _$identity);

  /// Serializes this Client to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Client&&(identical(other.id, id) || other.id == id)&&(identical(other.syncId, syncId) || other.syncId == syncId)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.middleName, middleName) || other.middleName == middleName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.email, email) || other.email == email)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.visits, visits) || other.visits == visits)&&(identical(other.photoPath, photoPath) || other.photoPath == photoPath)&&(identical(other.status, status) || other.status == status)&&(identical(other.lastModifiedUtc, lastModifiedUtc) || other.lastModifiedUtc == lastModifiedUtc)&&(identical(other.lastModifiedBy, lastModifiedBy) || other.lastModifiedBy == lastModifiedBy)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,syncId,firstName,middleName,lastName,phone,email,notes,visits,photoPath,status,lastModifiedUtc,lastModifiedBy,isDeleted);

@override
String toString() {
  return 'Client(id: $id, syncId: $syncId, firstName: $firstName, middleName: $middleName, lastName: $lastName, phone: $phone, email: $email, notes: $notes, visits: $visits, photoPath: $photoPath, status: $status, lastModifiedUtc: $lastModifiedUtc, lastModifiedBy: $lastModifiedBy, isDeleted: $isDeleted)';
}


}

/// @nodoc
abstract mixin class $ClientCopyWith<$Res>  {
  factory $ClientCopyWith(Client value, $Res Function(Client) _then) = _$ClientCopyWithImpl;
@useResult
$Res call({
 int id, String syncId, String firstName, String middleName, String lastName, String phone, String email, String notes, int visits, String photoPath, ClientStatus status, DateTime lastModifiedUtc, String lastModifiedBy, bool isDeleted
});




}
/// @nodoc
class _$ClientCopyWithImpl<$Res>
    implements $ClientCopyWith<$Res> {
  _$ClientCopyWithImpl(this._self, this._then);

  final Client _self;
  final $Res Function(Client) _then;

/// Create a copy of Client
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? syncId = null,Object? firstName = null,Object? middleName = null,Object? lastName = null,Object? phone = null,Object? email = null,Object? notes = null,Object? visits = null,Object? photoPath = null,Object? status = null,Object? lastModifiedUtc = null,Object? lastModifiedBy = null,Object? isDeleted = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,syncId: null == syncId ? _self.syncId : syncId // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,middleName: null == middleName ? _self.middleName : middleName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,visits: null == visits ? _self.visits : visits // ignore: cast_nullable_to_non_nullable
as int,photoPath: null == photoPath ? _self.photoPath : photoPath // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ClientStatus,lastModifiedUtc: null == lastModifiedUtc ? _self.lastModifiedUtc : lastModifiedUtc // ignore: cast_nullable_to_non_nullable
as DateTime,lastModifiedBy: null == lastModifiedBy ? _self.lastModifiedBy : lastModifiedBy // ignore: cast_nullable_to_non_nullable
as String,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Client].
extension ClientPatterns on Client {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Client value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Client() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Client value)  $default,){
final _that = this;
switch (_that) {
case _Client():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Client value)?  $default,){
final _that = this;
switch (_that) {
case _Client() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String syncId,  String firstName,  String middleName,  String lastName,  String phone,  String email,  String notes,  int visits,  String photoPath,  ClientStatus status,  DateTime lastModifiedUtc,  String lastModifiedBy,  bool isDeleted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Client() when $default != null:
return $default(_that.id,_that.syncId,_that.firstName,_that.middleName,_that.lastName,_that.phone,_that.email,_that.notes,_that.visits,_that.photoPath,_that.status,_that.lastModifiedUtc,_that.lastModifiedBy,_that.isDeleted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String syncId,  String firstName,  String middleName,  String lastName,  String phone,  String email,  String notes,  int visits,  String photoPath,  ClientStatus status,  DateTime lastModifiedUtc,  String lastModifiedBy,  bool isDeleted)  $default,) {final _that = this;
switch (_that) {
case _Client():
return $default(_that.id,_that.syncId,_that.firstName,_that.middleName,_that.lastName,_that.phone,_that.email,_that.notes,_that.visits,_that.photoPath,_that.status,_that.lastModifiedUtc,_that.lastModifiedBy,_that.isDeleted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String syncId,  String firstName,  String middleName,  String lastName,  String phone,  String email,  String notes,  int visits,  String photoPath,  ClientStatus status,  DateTime lastModifiedUtc,  String lastModifiedBy,  bool isDeleted)?  $default,) {final _that = this;
switch (_that) {
case _Client() when $default != null:
return $default(_that.id,_that.syncId,_that.firstName,_that.middleName,_that.lastName,_that.phone,_that.email,_that.notes,_that.visits,_that.photoPath,_that.status,_that.lastModifiedUtc,_that.lastModifiedBy,_that.isDeleted);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Client extends Client {
  const _Client({required this.id, required this.syncId, required this.firstName, this.middleName = '', required this.lastName, this.phone = '', this.email = '', this.notes = '', this.visits = 0, this.photoPath = '', this.status = ClientStatus.bound, required this.lastModifiedUtc, this.lastModifiedBy = '', this.isDeleted = false}): super._();
  factory _Client.fromJson(Map<String, dynamic> json) => _$ClientFromJson(json);

/// Primary key
@override final  int id;
/// Sync identifier for multi-device sync
@override final  String syncId;
/// First name
@override final  String firstName;
/// Middle name (optional)
@override@JsonKey() final  String middleName;
/// Last name
@override final  String lastName;
/// Phone number
@override@JsonKey() final  String phone;
/// Email address
@override@JsonKey() final  String email;
/// Free-form notes about the client
@override@JsonKey() final  String notes;
/// Number of visits
@override@JsonKey() final  int visits;
/// Path to profile photo
@override@JsonKey() final  String photoPath;
/// Client status (Bound/FreshSoul/HighValue/Void)
@override@JsonKey() final  ClientStatus status;
/// Last modification timestamp (UTC)
@override final  DateTime lastModifiedUtc;
/// User who last modified this record
@override@JsonKey() final  String lastModifiedBy;
/// Soft delete flag
@override@JsonKey() final  bool isDeleted;

/// Create a copy of Client
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClientCopyWith<_Client> get copyWith => __$ClientCopyWithImpl<_Client>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClientToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Client&&(identical(other.id, id) || other.id == id)&&(identical(other.syncId, syncId) || other.syncId == syncId)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.middleName, middleName) || other.middleName == middleName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.email, email) || other.email == email)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.visits, visits) || other.visits == visits)&&(identical(other.photoPath, photoPath) || other.photoPath == photoPath)&&(identical(other.status, status) || other.status == status)&&(identical(other.lastModifiedUtc, lastModifiedUtc) || other.lastModifiedUtc == lastModifiedUtc)&&(identical(other.lastModifiedBy, lastModifiedBy) || other.lastModifiedBy == lastModifiedBy)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,syncId,firstName,middleName,lastName,phone,email,notes,visits,photoPath,status,lastModifiedUtc,lastModifiedBy,isDeleted);

@override
String toString() {
  return 'Client(id: $id, syncId: $syncId, firstName: $firstName, middleName: $middleName, lastName: $lastName, phone: $phone, email: $email, notes: $notes, visits: $visits, photoPath: $photoPath, status: $status, lastModifiedUtc: $lastModifiedUtc, lastModifiedBy: $lastModifiedBy, isDeleted: $isDeleted)';
}


}

/// @nodoc
abstract mixin class _$ClientCopyWith<$Res> implements $ClientCopyWith<$Res> {
  factory _$ClientCopyWith(_Client value, $Res Function(_Client) _then) = __$ClientCopyWithImpl;
@override @useResult
$Res call({
 int id, String syncId, String firstName, String middleName, String lastName, String phone, String email, String notes, int visits, String photoPath, ClientStatus status, DateTime lastModifiedUtc, String lastModifiedBy, bool isDeleted
});




}
/// @nodoc
class __$ClientCopyWithImpl<$Res>
    implements _$ClientCopyWith<$Res> {
  __$ClientCopyWithImpl(this._self, this._then);

  final _Client _self;
  final $Res Function(_Client) _then;

/// Create a copy of Client
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? syncId = null,Object? firstName = null,Object? middleName = null,Object? lastName = null,Object? phone = null,Object? email = null,Object? notes = null,Object? visits = null,Object? photoPath = null,Object? status = null,Object? lastModifiedUtc = null,Object? lastModifiedBy = null,Object? isDeleted = null,}) {
  return _then(_Client(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,syncId: null == syncId ? _self.syncId : syncId // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,middleName: null == middleName ? _self.middleName : middleName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,visits: null == visits ? _self.visits : visits // ignore: cast_nullable_to_non_nullable
as int,photoPath: null == photoPath ? _self.photoPath : photoPath // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ClientStatus,lastModifiedUtc: null == lastModifiedUtc ? _self.lastModifiedUtc : lastModifiedUtc // ignore: cast_nullable_to_non_nullable
as DateTime,lastModifiedBy: null == lastModifiedBy ? _self.lastModifiedBy : lastModifiedBy // ignore: cast_nullable_to_non_nullable
as String,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
