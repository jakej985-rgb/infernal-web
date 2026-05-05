// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'document.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Document {

/// Primary key
 int get id;/// Sync identifier for multi-device sync
 String get syncId;/// Foreign key to User who uploaded
 int get uploadedByUserId;/// Foreign key to Client
 int get clientId;/// Document title/name
 String get title;/// File storage path
 String get filePath;/// Upload timestamp
 DateTime get createdAt;/// Last modification timestamp (UTC)
 DateTime get lastModifiedUtc;/// User who last modified this record
 String get lastModifiedBy;/// Soft delete flag
 bool get isDeleted;
/// Create a copy of Document
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DocumentCopyWith<Document> get copyWith => _$DocumentCopyWithImpl<Document>(this as Document, _$identity);

  /// Serializes this Document to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Document&&(identical(other.id, id) || other.id == id)&&(identical(other.syncId, syncId) || other.syncId == syncId)&&(identical(other.uploadedByUserId, uploadedByUserId) || other.uploadedByUserId == uploadedByUserId)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.title, title) || other.title == title)&&(identical(other.filePath, filePath) || other.filePath == filePath)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.lastModifiedUtc, lastModifiedUtc) || other.lastModifiedUtc == lastModifiedUtc)&&(identical(other.lastModifiedBy, lastModifiedBy) || other.lastModifiedBy == lastModifiedBy)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,syncId,uploadedByUserId,clientId,title,filePath,createdAt,lastModifiedUtc,lastModifiedBy,isDeleted);

@override
String toString() {
  return 'Document(id: $id, syncId: $syncId, uploadedByUserId: $uploadedByUserId, clientId: $clientId, title: $title, filePath: $filePath, createdAt: $createdAt, lastModifiedUtc: $lastModifiedUtc, lastModifiedBy: $lastModifiedBy, isDeleted: $isDeleted)';
}


}

/// @nodoc
abstract mixin class $DocumentCopyWith<$Res>  {
  factory $DocumentCopyWith(Document value, $Res Function(Document) _then) = _$DocumentCopyWithImpl;
@useResult
$Res call({
 int id, String syncId, int uploadedByUserId, int clientId, String title, String filePath, DateTime createdAt, DateTime lastModifiedUtc, String lastModifiedBy, bool isDeleted
});




}
/// @nodoc
class _$DocumentCopyWithImpl<$Res>
    implements $DocumentCopyWith<$Res> {
  _$DocumentCopyWithImpl(this._self, this._then);

  final Document _self;
  final $Res Function(Document) _then;

/// Create a copy of Document
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? syncId = null,Object? uploadedByUserId = null,Object? clientId = null,Object? title = null,Object? filePath = null,Object? createdAt = null,Object? lastModifiedUtc = null,Object? lastModifiedBy = null,Object? isDeleted = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,syncId: null == syncId ? _self.syncId : syncId // ignore: cast_nullable_to_non_nullable
as String,uploadedByUserId: null == uploadedByUserId ? _self.uploadedByUserId : uploadedByUserId // ignore: cast_nullable_to_non_nullable
as int,clientId: null == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,filePath: null == filePath ? _self.filePath : filePath // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastModifiedUtc: null == lastModifiedUtc ? _self.lastModifiedUtc : lastModifiedUtc // ignore: cast_nullable_to_non_nullable
as DateTime,lastModifiedBy: null == lastModifiedBy ? _self.lastModifiedBy : lastModifiedBy // ignore: cast_nullable_to_non_nullable
as String,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Document].
extension DocumentPatterns on Document {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Document value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Document() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Document value)  $default,){
final _that = this;
switch (_that) {
case _Document():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Document value)?  $default,){
final _that = this;
switch (_that) {
case _Document() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String syncId,  int uploadedByUserId,  int clientId,  String title,  String filePath,  DateTime createdAt,  DateTime lastModifiedUtc,  String lastModifiedBy,  bool isDeleted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Document() when $default != null:
return $default(_that.id,_that.syncId,_that.uploadedByUserId,_that.clientId,_that.title,_that.filePath,_that.createdAt,_that.lastModifiedUtc,_that.lastModifiedBy,_that.isDeleted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String syncId,  int uploadedByUserId,  int clientId,  String title,  String filePath,  DateTime createdAt,  DateTime lastModifiedUtc,  String lastModifiedBy,  bool isDeleted)  $default,) {final _that = this;
switch (_that) {
case _Document():
return $default(_that.id,_that.syncId,_that.uploadedByUserId,_that.clientId,_that.title,_that.filePath,_that.createdAt,_that.lastModifiedUtc,_that.lastModifiedBy,_that.isDeleted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String syncId,  int uploadedByUserId,  int clientId,  String title,  String filePath,  DateTime createdAt,  DateTime lastModifiedUtc,  String lastModifiedBy,  bool isDeleted)?  $default,) {final _that = this;
switch (_that) {
case _Document() when $default != null:
return $default(_that.id,_that.syncId,_that.uploadedByUserId,_that.clientId,_that.title,_that.filePath,_that.createdAt,_that.lastModifiedUtc,_that.lastModifiedBy,_that.isDeleted);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Document extends Document {
  const _Document({required this.id, required this.syncId, required this.uploadedByUserId, required this.clientId, required this.title, required this.filePath, required this.createdAt, required this.lastModifiedUtc, this.lastModifiedBy = '', this.isDeleted = false}): super._();
  factory _Document.fromJson(Map<String, dynamic> json) => _$DocumentFromJson(json);

/// Primary key
@override final  int id;
/// Sync identifier for multi-device sync
@override final  String syncId;
/// Foreign key to User who uploaded
@override final  int uploadedByUserId;
/// Foreign key to Client
@override final  int clientId;
/// Document title/name
@override final  String title;
/// File storage path
@override final  String filePath;
/// Upload timestamp
@override final  DateTime createdAt;
/// Last modification timestamp (UTC)
@override final  DateTime lastModifiedUtc;
/// User who last modified this record
@override@JsonKey() final  String lastModifiedBy;
/// Soft delete flag
@override@JsonKey() final  bool isDeleted;

/// Create a copy of Document
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DocumentCopyWith<_Document> get copyWith => __$DocumentCopyWithImpl<_Document>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DocumentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Document&&(identical(other.id, id) || other.id == id)&&(identical(other.syncId, syncId) || other.syncId == syncId)&&(identical(other.uploadedByUserId, uploadedByUserId) || other.uploadedByUserId == uploadedByUserId)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.title, title) || other.title == title)&&(identical(other.filePath, filePath) || other.filePath == filePath)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.lastModifiedUtc, lastModifiedUtc) || other.lastModifiedUtc == lastModifiedUtc)&&(identical(other.lastModifiedBy, lastModifiedBy) || other.lastModifiedBy == lastModifiedBy)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,syncId,uploadedByUserId,clientId,title,filePath,createdAt,lastModifiedUtc,lastModifiedBy,isDeleted);

@override
String toString() {
  return 'Document(id: $id, syncId: $syncId, uploadedByUserId: $uploadedByUserId, clientId: $clientId, title: $title, filePath: $filePath, createdAt: $createdAt, lastModifiedUtc: $lastModifiedUtc, lastModifiedBy: $lastModifiedBy, isDeleted: $isDeleted)';
}


}

/// @nodoc
abstract mixin class _$DocumentCopyWith<$Res> implements $DocumentCopyWith<$Res> {
  factory _$DocumentCopyWith(_Document value, $Res Function(_Document) _then) = __$DocumentCopyWithImpl;
@override @useResult
$Res call({
 int id, String syncId, int uploadedByUserId, int clientId, String title, String filePath, DateTime createdAt, DateTime lastModifiedUtc, String lastModifiedBy, bool isDeleted
});




}
/// @nodoc
class __$DocumentCopyWithImpl<$Res>
    implements _$DocumentCopyWith<$Res> {
  __$DocumentCopyWithImpl(this._self, this._then);

  final _Document _self;
  final $Res Function(_Document) _then;

/// Create a copy of Document
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? syncId = null,Object? uploadedByUserId = null,Object? clientId = null,Object? title = null,Object? filePath = null,Object? createdAt = null,Object? lastModifiedUtc = null,Object? lastModifiedBy = null,Object? isDeleted = null,}) {
  return _then(_Document(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,syncId: null == syncId ? _self.syncId : syncId // ignore: cast_nullable_to_non_nullable
as String,uploadedByUserId: null == uploadedByUserId ? _self.uploadedByUserId : uploadedByUserId // ignore: cast_nullable_to_non_nullable
as int,clientId: null == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,filePath: null == filePath ? _self.filePath : filePath // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastModifiedUtc: null == lastModifiedUtc ? _self.lastModifiedUtc : lastModifiedUtc // ignore: cast_nullable_to_non_nullable
as DateTime,lastModifiedBy: null == lastModifiedBy ? _self.lastModifiedBy : lastModifiedBy // ignore: cast_nullable_to_non_nullable
as String,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
