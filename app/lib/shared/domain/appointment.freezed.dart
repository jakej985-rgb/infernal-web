// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'appointment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Appointment {

/// Primary key
 int get id;/// Sync identifier for multi-device sync
 String get syncId;/// Foreign key to Client
 int get clientId;/// Foreign key to User (Artist)
 int get userId;/// Denormalized client name for quick display
 String get clientName;/// Appointment start date/time
 DateTime get dateTime;/// Duration in minutes
 int get durationMinutes;/// Type of service (Tattoo, Piercing, etc.)
 String get serviceType;/// Service category grouping
 String get serviceCategory;/// Pricing method (Hourly, Flat, etc.)
 String get priceType;/// Amount charged
 double get priceCharged;/// Original quoted price
 double? get quotedPrice;/// Finalized price
 double? get finalPrice;/// Free-form notes
 String? get notes;/// Path to reference photo
 String? get photoPath;/// Calendar display color (hex or named)
 String get color;/// Current status (Scheduled, Completed, etc.)
 String get status;/// Whether this is a time block (not a real appointment)
 bool get isBlockOff;/// Last modification timestamp (UTC)
 DateTime get lastModifiedUtc;/// User who last modified this record
 String get lastModifiedBy;/// Soft delete flag
 bool get isDeleted;
/// Create a copy of Appointment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppointmentCopyWith<Appointment> get copyWith => _$AppointmentCopyWithImpl<Appointment>(this as Appointment, _$identity);

  /// Serializes this Appointment to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Appointment&&(identical(other.id, id) || other.id == id)&&(identical(other.syncId, syncId) || other.syncId == syncId)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.clientName, clientName) || other.clientName == clientName)&&(identical(other.dateTime, dateTime) || other.dateTime == dateTime)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.serviceType, serviceType) || other.serviceType == serviceType)&&(identical(other.serviceCategory, serviceCategory) || other.serviceCategory == serviceCategory)&&(identical(other.priceType, priceType) || other.priceType == priceType)&&(identical(other.priceCharged, priceCharged) || other.priceCharged == priceCharged)&&(identical(other.quotedPrice, quotedPrice) || other.quotedPrice == quotedPrice)&&(identical(other.finalPrice, finalPrice) || other.finalPrice == finalPrice)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.photoPath, photoPath) || other.photoPath == photoPath)&&(identical(other.color, color) || other.color == color)&&(identical(other.status, status) || other.status == status)&&(identical(other.isBlockOff, isBlockOff) || other.isBlockOff == isBlockOff)&&(identical(other.lastModifiedUtc, lastModifiedUtc) || other.lastModifiedUtc == lastModifiedUtc)&&(identical(other.lastModifiedBy, lastModifiedBy) || other.lastModifiedBy == lastModifiedBy)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,syncId,clientId,userId,clientName,dateTime,durationMinutes,serviceType,serviceCategory,priceType,priceCharged,quotedPrice,finalPrice,notes,photoPath,color,status,isBlockOff,lastModifiedUtc,lastModifiedBy,isDeleted]);

@override
String toString() {
  return 'Appointment(id: $id, syncId: $syncId, clientId: $clientId, userId: $userId, clientName: $clientName, dateTime: $dateTime, durationMinutes: $durationMinutes, serviceType: $serviceType, serviceCategory: $serviceCategory, priceType: $priceType, priceCharged: $priceCharged, quotedPrice: $quotedPrice, finalPrice: $finalPrice, notes: $notes, photoPath: $photoPath, color: $color, status: $status, isBlockOff: $isBlockOff, lastModifiedUtc: $lastModifiedUtc, lastModifiedBy: $lastModifiedBy, isDeleted: $isDeleted)';
}


}

/// @nodoc
abstract mixin class $AppointmentCopyWith<$Res>  {
  factory $AppointmentCopyWith(Appointment value, $Res Function(Appointment) _then) = _$AppointmentCopyWithImpl;
@useResult
$Res call({
 int id, String syncId, int clientId, int userId, String clientName, DateTime dateTime, int durationMinutes, String serviceType, String serviceCategory, String priceType, double priceCharged, double? quotedPrice, double? finalPrice, String? notes, String? photoPath, String color, String status, bool isBlockOff, DateTime lastModifiedUtc, String lastModifiedBy, bool isDeleted
});




}
/// @nodoc
class _$AppointmentCopyWithImpl<$Res>
    implements $AppointmentCopyWith<$Res> {
  _$AppointmentCopyWithImpl(this._self, this._then);

  final Appointment _self;
  final $Res Function(Appointment) _then;

/// Create a copy of Appointment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? syncId = null,Object? clientId = null,Object? userId = null,Object? clientName = null,Object? dateTime = null,Object? durationMinutes = null,Object? serviceType = null,Object? serviceCategory = null,Object? priceType = null,Object? priceCharged = null,Object? quotedPrice = freezed,Object? finalPrice = freezed,Object? notes = freezed,Object? photoPath = freezed,Object? color = null,Object? status = null,Object? isBlockOff = null,Object? lastModifiedUtc = null,Object? lastModifiedBy = null,Object? isDeleted = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,syncId: null == syncId ? _self.syncId : syncId // ignore: cast_nullable_to_non_nullable
as String,clientId: null == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,clientName: null == clientName ? _self.clientName : clientName // ignore: cast_nullable_to_non_nullable
as String,dateTime: null == dateTime ? _self.dateTime : dateTime // ignore: cast_nullable_to_non_nullable
as DateTime,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,serviceType: null == serviceType ? _self.serviceType : serviceType // ignore: cast_nullable_to_non_nullable
as String,serviceCategory: null == serviceCategory ? _self.serviceCategory : serviceCategory // ignore: cast_nullable_to_non_nullable
as String,priceType: null == priceType ? _self.priceType : priceType // ignore: cast_nullable_to_non_nullable
as String,priceCharged: null == priceCharged ? _self.priceCharged : priceCharged // ignore: cast_nullable_to_non_nullable
as double,quotedPrice: freezed == quotedPrice ? _self.quotedPrice : quotedPrice // ignore: cast_nullable_to_non_nullable
as double?,finalPrice: freezed == finalPrice ? _self.finalPrice : finalPrice // ignore: cast_nullable_to_non_nullable
as double?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,photoPath: freezed == photoPath ? _self.photoPath : photoPath // ignore: cast_nullable_to_non_nullable
as String?,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,isBlockOff: null == isBlockOff ? _self.isBlockOff : isBlockOff // ignore: cast_nullable_to_non_nullable
as bool,lastModifiedUtc: null == lastModifiedUtc ? _self.lastModifiedUtc : lastModifiedUtc // ignore: cast_nullable_to_non_nullable
as DateTime,lastModifiedBy: null == lastModifiedBy ? _self.lastModifiedBy : lastModifiedBy // ignore: cast_nullable_to_non_nullable
as String,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Appointment].
extension AppointmentPatterns on Appointment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Appointment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Appointment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Appointment value)  $default,){
final _that = this;
switch (_that) {
case _Appointment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Appointment value)?  $default,){
final _that = this;
switch (_that) {
case _Appointment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String syncId,  int clientId,  int userId,  String clientName,  DateTime dateTime,  int durationMinutes,  String serviceType,  String serviceCategory,  String priceType,  double priceCharged,  double? quotedPrice,  double? finalPrice,  String? notes,  String? photoPath,  String color,  String status,  bool isBlockOff,  DateTime lastModifiedUtc,  String lastModifiedBy,  bool isDeleted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Appointment() when $default != null:
return $default(_that.id,_that.syncId,_that.clientId,_that.userId,_that.clientName,_that.dateTime,_that.durationMinutes,_that.serviceType,_that.serviceCategory,_that.priceType,_that.priceCharged,_that.quotedPrice,_that.finalPrice,_that.notes,_that.photoPath,_that.color,_that.status,_that.isBlockOff,_that.lastModifiedUtc,_that.lastModifiedBy,_that.isDeleted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String syncId,  int clientId,  int userId,  String clientName,  DateTime dateTime,  int durationMinutes,  String serviceType,  String serviceCategory,  String priceType,  double priceCharged,  double? quotedPrice,  double? finalPrice,  String? notes,  String? photoPath,  String color,  String status,  bool isBlockOff,  DateTime lastModifiedUtc,  String lastModifiedBy,  bool isDeleted)  $default,) {final _that = this;
switch (_that) {
case _Appointment():
return $default(_that.id,_that.syncId,_that.clientId,_that.userId,_that.clientName,_that.dateTime,_that.durationMinutes,_that.serviceType,_that.serviceCategory,_that.priceType,_that.priceCharged,_that.quotedPrice,_that.finalPrice,_that.notes,_that.photoPath,_that.color,_that.status,_that.isBlockOff,_that.lastModifiedUtc,_that.lastModifiedBy,_that.isDeleted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String syncId,  int clientId,  int userId,  String clientName,  DateTime dateTime,  int durationMinutes,  String serviceType,  String serviceCategory,  String priceType,  double priceCharged,  double? quotedPrice,  double? finalPrice,  String? notes,  String? photoPath,  String color,  String status,  bool isBlockOff,  DateTime lastModifiedUtc,  String lastModifiedBy,  bool isDeleted)?  $default,) {final _that = this;
switch (_that) {
case _Appointment() when $default != null:
return $default(_that.id,_that.syncId,_that.clientId,_that.userId,_that.clientName,_that.dateTime,_that.durationMinutes,_that.serviceType,_that.serviceCategory,_that.priceType,_that.priceCharged,_that.quotedPrice,_that.finalPrice,_that.notes,_that.photoPath,_that.color,_that.status,_that.isBlockOff,_that.lastModifiedUtc,_that.lastModifiedBy,_that.isDeleted);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Appointment extends Appointment {
  const _Appointment({required this.id, required this.syncId, required this.clientId, required this.userId, this.clientName = '', required this.dateTime, required this.durationMinutes, this.serviceType = 'Tattoo', this.serviceCategory = 'General', this.priceType = 'Hourly', this.priceCharged = 0.0, this.quotedPrice, this.finalPrice, this.notes, this.photoPath, this.color = '', this.status = 'Scheduled', this.isBlockOff = false, required this.lastModifiedUtc, this.lastModifiedBy = '', this.isDeleted = false}): super._();
  factory _Appointment.fromJson(Map<String, dynamic> json) => _$AppointmentFromJson(json);

/// Primary key
@override final  int id;
/// Sync identifier for multi-device sync
@override final  String syncId;
/// Foreign key to Client
@override final  int clientId;
/// Foreign key to User (Artist)
@override final  int userId;
/// Denormalized client name for quick display
@override@JsonKey() final  String clientName;
/// Appointment start date/time
@override final  DateTime dateTime;
/// Duration in minutes
@override final  int durationMinutes;
/// Type of service (Tattoo, Piercing, etc.)
@override@JsonKey() final  String serviceType;
/// Service category grouping
@override@JsonKey() final  String serviceCategory;
/// Pricing method (Hourly, Flat, etc.)
@override@JsonKey() final  String priceType;
/// Amount charged
@override@JsonKey() final  double priceCharged;
/// Original quoted price
@override final  double? quotedPrice;
/// Finalized price
@override final  double? finalPrice;
/// Free-form notes
@override final  String? notes;
/// Path to reference photo
@override final  String? photoPath;
/// Calendar display color (hex or named)
@override@JsonKey() final  String color;
/// Current status (Scheduled, Completed, etc.)
@override@JsonKey() final  String status;
/// Whether this is a time block (not a real appointment)
@override@JsonKey() final  bool isBlockOff;
/// Last modification timestamp (UTC)
@override final  DateTime lastModifiedUtc;
/// User who last modified this record
@override@JsonKey() final  String lastModifiedBy;
/// Soft delete flag
@override@JsonKey() final  bool isDeleted;

/// Create a copy of Appointment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppointmentCopyWith<_Appointment> get copyWith => __$AppointmentCopyWithImpl<_Appointment>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppointmentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Appointment&&(identical(other.id, id) || other.id == id)&&(identical(other.syncId, syncId) || other.syncId == syncId)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.clientName, clientName) || other.clientName == clientName)&&(identical(other.dateTime, dateTime) || other.dateTime == dateTime)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.serviceType, serviceType) || other.serviceType == serviceType)&&(identical(other.serviceCategory, serviceCategory) || other.serviceCategory == serviceCategory)&&(identical(other.priceType, priceType) || other.priceType == priceType)&&(identical(other.priceCharged, priceCharged) || other.priceCharged == priceCharged)&&(identical(other.quotedPrice, quotedPrice) || other.quotedPrice == quotedPrice)&&(identical(other.finalPrice, finalPrice) || other.finalPrice == finalPrice)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.photoPath, photoPath) || other.photoPath == photoPath)&&(identical(other.color, color) || other.color == color)&&(identical(other.status, status) || other.status == status)&&(identical(other.isBlockOff, isBlockOff) || other.isBlockOff == isBlockOff)&&(identical(other.lastModifiedUtc, lastModifiedUtc) || other.lastModifiedUtc == lastModifiedUtc)&&(identical(other.lastModifiedBy, lastModifiedBy) || other.lastModifiedBy == lastModifiedBy)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,syncId,clientId,userId,clientName,dateTime,durationMinutes,serviceType,serviceCategory,priceType,priceCharged,quotedPrice,finalPrice,notes,photoPath,color,status,isBlockOff,lastModifiedUtc,lastModifiedBy,isDeleted]);

@override
String toString() {
  return 'Appointment(id: $id, syncId: $syncId, clientId: $clientId, userId: $userId, clientName: $clientName, dateTime: $dateTime, durationMinutes: $durationMinutes, serviceType: $serviceType, serviceCategory: $serviceCategory, priceType: $priceType, priceCharged: $priceCharged, quotedPrice: $quotedPrice, finalPrice: $finalPrice, notes: $notes, photoPath: $photoPath, color: $color, status: $status, isBlockOff: $isBlockOff, lastModifiedUtc: $lastModifiedUtc, lastModifiedBy: $lastModifiedBy, isDeleted: $isDeleted)';
}


}

/// @nodoc
abstract mixin class _$AppointmentCopyWith<$Res> implements $AppointmentCopyWith<$Res> {
  factory _$AppointmentCopyWith(_Appointment value, $Res Function(_Appointment) _then) = __$AppointmentCopyWithImpl;
@override @useResult
$Res call({
 int id, String syncId, int clientId, int userId, String clientName, DateTime dateTime, int durationMinutes, String serviceType, String serviceCategory, String priceType, double priceCharged, double? quotedPrice, double? finalPrice, String? notes, String? photoPath, String color, String status, bool isBlockOff, DateTime lastModifiedUtc, String lastModifiedBy, bool isDeleted
});




}
/// @nodoc
class __$AppointmentCopyWithImpl<$Res>
    implements _$AppointmentCopyWith<$Res> {
  __$AppointmentCopyWithImpl(this._self, this._then);

  final _Appointment _self;
  final $Res Function(_Appointment) _then;

/// Create a copy of Appointment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? syncId = null,Object? clientId = null,Object? userId = null,Object? clientName = null,Object? dateTime = null,Object? durationMinutes = null,Object? serviceType = null,Object? serviceCategory = null,Object? priceType = null,Object? priceCharged = null,Object? quotedPrice = freezed,Object? finalPrice = freezed,Object? notes = freezed,Object? photoPath = freezed,Object? color = null,Object? status = null,Object? isBlockOff = null,Object? lastModifiedUtc = null,Object? lastModifiedBy = null,Object? isDeleted = null,}) {
  return _then(_Appointment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,syncId: null == syncId ? _self.syncId : syncId // ignore: cast_nullable_to_non_nullable
as String,clientId: null == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,clientName: null == clientName ? _self.clientName : clientName // ignore: cast_nullable_to_non_nullable
as String,dateTime: null == dateTime ? _self.dateTime : dateTime // ignore: cast_nullable_to_non_nullable
as DateTime,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,serviceType: null == serviceType ? _self.serviceType : serviceType // ignore: cast_nullable_to_non_nullable
as String,serviceCategory: null == serviceCategory ? _self.serviceCategory : serviceCategory // ignore: cast_nullable_to_non_nullable
as String,priceType: null == priceType ? _self.priceType : priceType // ignore: cast_nullable_to_non_nullable
as String,priceCharged: null == priceCharged ? _self.priceCharged : priceCharged // ignore: cast_nullable_to_non_nullable
as double,quotedPrice: freezed == quotedPrice ? _self.quotedPrice : quotedPrice // ignore: cast_nullable_to_non_nullable
as double?,finalPrice: freezed == finalPrice ? _self.finalPrice : finalPrice // ignore: cast_nullable_to_non_nullable
as double?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,photoPath: freezed == photoPath ? _self.photoPath : photoPath // ignore: cast_nullable_to_non_nullable
as String?,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,isBlockOff: null == isBlockOff ? _self.isBlockOff : isBlockOff // ignore: cast_nullable_to_non_nullable
as bool,lastModifiedUtc: null == lastModifiedUtc ? _self.lastModifiedUtc : lastModifiedUtc // ignore: cast_nullable_to_non_nullable
as DateTime,lastModifiedBy: null == lastModifiedBy ? _self.lastModifiedBy : lastModifiedBy // ignore: cast_nullable_to_non_nullable
as String,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
