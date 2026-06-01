// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'communication.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CommunicationRitual {

 int get id; String get syncId; int? get clientId; String get clientName; String get type;// SMS, Email, Ritual
 String get direction;// INBOUND, OUTBOUND
 String get content; DateTime get sentAt; String get status;// PENDING, SENT, FAILED
 DateTime? get lastModifiedUtc; String get lastModifiedBy; bool get isDeleted;
/// Create a copy of CommunicationRitual
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommunicationRitualCopyWith<CommunicationRitual> get copyWith => _$CommunicationRitualCopyWithImpl<CommunicationRitual>(this as CommunicationRitual, _$identity);

  /// Serializes this CommunicationRitual to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunicationRitual&&(identical(other.id, id) || other.id == id)&&(identical(other.syncId, syncId) || other.syncId == syncId)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.clientName, clientName) || other.clientName == clientName)&&(identical(other.type, type) || other.type == type)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.content, content) || other.content == content)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.lastModifiedUtc, lastModifiedUtc) || other.lastModifiedUtc == lastModifiedUtc)&&(identical(other.lastModifiedBy, lastModifiedBy) || other.lastModifiedBy == lastModifiedBy)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,syncId,clientId,clientName,type,direction,content,sentAt,status,lastModifiedUtc,lastModifiedBy,isDeleted);

@override
String toString() {
  return 'CommunicationRitual(id: $id, syncId: $syncId, clientId: $clientId, clientName: $clientName, type: $type, direction: $direction, content: $content, sentAt: $sentAt, status: $status, lastModifiedUtc: $lastModifiedUtc, lastModifiedBy: $lastModifiedBy, isDeleted: $isDeleted)';
}


}

/// @nodoc
abstract mixin class $CommunicationRitualCopyWith<$Res>  {
  factory $CommunicationRitualCopyWith(CommunicationRitual value, $Res Function(CommunicationRitual) _then) = _$CommunicationRitualCopyWithImpl;
@useResult
$Res call({
 int id, String syncId, int? clientId, String clientName, String type, String direction, String content, DateTime sentAt, String status, DateTime? lastModifiedUtc, String lastModifiedBy, bool isDeleted
});




}
/// @nodoc
class _$CommunicationRitualCopyWithImpl<$Res>
    implements $CommunicationRitualCopyWith<$Res> {
  _$CommunicationRitualCopyWithImpl(this._self, this._then);

  final CommunicationRitual _self;
  final $Res Function(CommunicationRitual) _then;

/// Create a copy of CommunicationRitual
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? syncId = null,Object? clientId = freezed,Object? clientName = null,Object? type = null,Object? direction = null,Object? content = null,Object? sentAt = null,Object? status = null,Object? lastModifiedUtc = freezed,Object? lastModifiedBy = null,Object? isDeleted = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,syncId: null == syncId ? _self.syncId : syncId // ignore: cast_nullable_to_non_nullable
as String,clientId: freezed == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as int?,clientName: null == clientName ? _self.clientName : clientName // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,sentAt: null == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,lastModifiedUtc: freezed == lastModifiedUtc ? _self.lastModifiedUtc : lastModifiedUtc // ignore: cast_nullable_to_non_nullable
as DateTime?,lastModifiedBy: null == lastModifiedBy ? _self.lastModifiedBy : lastModifiedBy // ignore: cast_nullable_to_non_nullable
as String,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CommunicationRitual].
extension CommunicationRitualPatterns on CommunicationRitual {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommunicationRitual value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommunicationRitual() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommunicationRitual value)  $default,){
final _that = this;
switch (_that) {
case _CommunicationRitual():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommunicationRitual value)?  $default,){
final _that = this;
switch (_that) {
case _CommunicationRitual() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String syncId,  int? clientId,  String clientName,  String type,  String direction,  String content,  DateTime sentAt,  String status,  DateTime? lastModifiedUtc,  String lastModifiedBy,  bool isDeleted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommunicationRitual() when $default != null:
return $default(_that.id,_that.syncId,_that.clientId,_that.clientName,_that.type,_that.direction,_that.content,_that.sentAt,_that.status,_that.lastModifiedUtc,_that.lastModifiedBy,_that.isDeleted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String syncId,  int? clientId,  String clientName,  String type,  String direction,  String content,  DateTime sentAt,  String status,  DateTime? lastModifiedUtc,  String lastModifiedBy,  bool isDeleted)  $default,) {final _that = this;
switch (_that) {
case _CommunicationRitual():
return $default(_that.id,_that.syncId,_that.clientId,_that.clientName,_that.type,_that.direction,_that.content,_that.sentAt,_that.status,_that.lastModifiedUtc,_that.lastModifiedBy,_that.isDeleted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String syncId,  int? clientId,  String clientName,  String type,  String direction,  String content,  DateTime sentAt,  String status,  DateTime? lastModifiedUtc,  String lastModifiedBy,  bool isDeleted)?  $default,) {final _that = this;
switch (_that) {
case _CommunicationRitual() when $default != null:
return $default(_that.id,_that.syncId,_that.clientId,_that.clientName,_that.type,_that.direction,_that.content,_that.sentAt,_that.status,_that.lastModifiedUtc,_that.lastModifiedBy,_that.isDeleted);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommunicationRitual implements CommunicationRitual {
  const _CommunicationRitual({required this.id, this.syncId = '', required this.clientId, required this.clientName, required this.type, required this.direction, required this.content, required this.sentAt, this.status = 'SENT', this.lastModifiedUtc, this.lastModifiedBy = '', this.isDeleted = false});
  factory _CommunicationRitual.fromJson(Map<String, dynamic> json) => _$CommunicationRitualFromJson(json);

@override final  int id;
@override@JsonKey() final  String syncId;
@override final  int? clientId;
@override final  String clientName;
@override final  String type;
// SMS, Email, Ritual
@override final  String direction;
// INBOUND, OUTBOUND
@override final  String content;
@override final  DateTime sentAt;
@override@JsonKey() final  String status;
// PENDING, SENT, FAILED
@override final  DateTime? lastModifiedUtc;
@override@JsonKey() final  String lastModifiedBy;
@override@JsonKey() final  bool isDeleted;

/// Create a copy of CommunicationRitual
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommunicationRitualCopyWith<_CommunicationRitual> get copyWith => __$CommunicationRitualCopyWithImpl<_CommunicationRitual>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommunicationRitualToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommunicationRitual&&(identical(other.id, id) || other.id == id)&&(identical(other.syncId, syncId) || other.syncId == syncId)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.clientName, clientName) || other.clientName == clientName)&&(identical(other.type, type) || other.type == type)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.content, content) || other.content == content)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.lastModifiedUtc, lastModifiedUtc) || other.lastModifiedUtc == lastModifiedUtc)&&(identical(other.lastModifiedBy, lastModifiedBy) || other.lastModifiedBy == lastModifiedBy)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,syncId,clientId,clientName,type,direction,content,sentAt,status,lastModifiedUtc,lastModifiedBy,isDeleted);

@override
String toString() {
  return 'CommunicationRitual(id: $id, syncId: $syncId, clientId: $clientId, clientName: $clientName, type: $type, direction: $direction, content: $content, sentAt: $sentAt, status: $status, lastModifiedUtc: $lastModifiedUtc, lastModifiedBy: $lastModifiedBy, isDeleted: $isDeleted)';
}


}

/// @nodoc
abstract mixin class _$CommunicationRitualCopyWith<$Res> implements $CommunicationRitualCopyWith<$Res> {
  factory _$CommunicationRitualCopyWith(_CommunicationRitual value, $Res Function(_CommunicationRitual) _then) = __$CommunicationRitualCopyWithImpl;
@override @useResult
$Res call({
 int id, String syncId, int? clientId, String clientName, String type, String direction, String content, DateTime sentAt, String status, DateTime? lastModifiedUtc, String lastModifiedBy, bool isDeleted
});




}
/// @nodoc
class __$CommunicationRitualCopyWithImpl<$Res>
    implements _$CommunicationRitualCopyWith<$Res> {
  __$CommunicationRitualCopyWithImpl(this._self, this._then);

  final _CommunicationRitual _self;
  final $Res Function(_CommunicationRitual) _then;

/// Create a copy of CommunicationRitual
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? syncId = null,Object? clientId = freezed,Object? clientName = null,Object? type = null,Object? direction = null,Object? content = null,Object? sentAt = null,Object? status = null,Object? lastModifiedUtc = freezed,Object? lastModifiedBy = null,Object? isDeleted = null,}) {
  return _then(_CommunicationRitual(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,syncId: null == syncId ? _self.syncId : syncId // ignore: cast_nullable_to_non_nullable
as String,clientId: freezed == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as int?,clientName: null == clientName ? _self.clientName : clientName // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,sentAt: null == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,lastModifiedUtc: freezed == lastModifiedUtc ? _self.lastModifiedUtc : lastModifiedUtc // ignore: cast_nullable_to_non_nullable
as DateTime?,lastModifiedBy: null == lastModifiedBy ? _self.lastModifiedBy : lastModifiedBy // ignore: cast_nullable_to_non_nullable
as String,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
