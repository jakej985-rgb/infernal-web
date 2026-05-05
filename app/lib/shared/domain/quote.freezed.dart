// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quote.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Quote {

/// Primary key
 int get id;/// Optional foreign key to Client (quote may be for walk-in)
 int? get clientId;/// Foreign key to User (Artist who created the quote)
 int get artistId;/// Body placement location
 String get placement;/// Art style (Traditional, Realism, etc.)
 String get style;/// Whether this is a cover-up (adds complexity)
 bool get isCoverUp;/// Width dimension
 double get width;/// Height dimension
 double get height;/// Coverage level (1-5 scale)
 int get coverageLevel;/// Line work complexity (1-5 scale)
 int get lineComplexity;/// Shading complexity (1-5 scale)
 int get shadingComplexity;/// Color work complexity (1-5 scale)
 int get colorComplexity;/// Overall difficulty (1-5 scale)
 int get difficulty;/// Estimated hours - low end
 double get estimatedHoursLow;/// Estimated hours - high end
 double get estimatedHoursHigh;/// Price estimate - low end
 double get priceLow;/// Price estimate - high end
 double get priceHigh;/// Shop minimum rate applied
 double get shopMinimum;/// Recommended deposit amount
 double get recommendedDeposit;/// Confidence score (0-1, how reliable is this estimate)
 double get confidenceScore;/// Number of similar past jobs used for estimation
 int get similarJobsCount;/// Free-form notes
 String? get notes;/// Path to reference photo
 String? get photoPath;/// Quote creation timestamp
 DateTime get createdAt;
/// Create a copy of Quote
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuoteCopyWith<Quote> get copyWith => _$QuoteCopyWithImpl<Quote>(this as Quote, _$identity);

  /// Serializes this Quote to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Quote&&(identical(other.id, id) || other.id == id)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.artistId, artistId) || other.artistId == artistId)&&(identical(other.placement, placement) || other.placement == placement)&&(identical(other.style, style) || other.style == style)&&(identical(other.isCoverUp, isCoverUp) || other.isCoverUp == isCoverUp)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.coverageLevel, coverageLevel) || other.coverageLevel == coverageLevel)&&(identical(other.lineComplexity, lineComplexity) || other.lineComplexity == lineComplexity)&&(identical(other.shadingComplexity, shadingComplexity) || other.shadingComplexity == shadingComplexity)&&(identical(other.colorComplexity, colorComplexity) || other.colorComplexity == colorComplexity)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.estimatedHoursLow, estimatedHoursLow) || other.estimatedHoursLow == estimatedHoursLow)&&(identical(other.estimatedHoursHigh, estimatedHoursHigh) || other.estimatedHoursHigh == estimatedHoursHigh)&&(identical(other.priceLow, priceLow) || other.priceLow == priceLow)&&(identical(other.priceHigh, priceHigh) || other.priceHigh == priceHigh)&&(identical(other.shopMinimum, shopMinimum) || other.shopMinimum == shopMinimum)&&(identical(other.recommendedDeposit, recommendedDeposit) || other.recommendedDeposit == recommendedDeposit)&&(identical(other.confidenceScore, confidenceScore) || other.confidenceScore == confidenceScore)&&(identical(other.similarJobsCount, similarJobsCount) || other.similarJobsCount == similarJobsCount)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.photoPath, photoPath) || other.photoPath == photoPath)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,clientId,artistId,placement,style,isCoverUp,width,height,coverageLevel,lineComplexity,shadingComplexity,colorComplexity,difficulty,estimatedHoursLow,estimatedHoursHigh,priceLow,priceHigh,shopMinimum,recommendedDeposit,confidenceScore,similarJobsCount,notes,photoPath,createdAt]);

@override
String toString() {
  return 'Quote(id: $id, clientId: $clientId, artistId: $artistId, placement: $placement, style: $style, isCoverUp: $isCoverUp, width: $width, height: $height, coverageLevel: $coverageLevel, lineComplexity: $lineComplexity, shadingComplexity: $shadingComplexity, colorComplexity: $colorComplexity, difficulty: $difficulty, estimatedHoursLow: $estimatedHoursLow, estimatedHoursHigh: $estimatedHoursHigh, priceLow: $priceLow, priceHigh: $priceHigh, shopMinimum: $shopMinimum, recommendedDeposit: $recommendedDeposit, confidenceScore: $confidenceScore, similarJobsCount: $similarJobsCount, notes: $notes, photoPath: $photoPath, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $QuoteCopyWith<$Res>  {
  factory $QuoteCopyWith(Quote value, $Res Function(Quote) _then) = _$QuoteCopyWithImpl;
@useResult
$Res call({
 int id, int? clientId, int artistId, String placement, String style, bool isCoverUp, double width, double height, int coverageLevel, int lineComplexity, int shadingComplexity, int colorComplexity, int difficulty, double estimatedHoursLow, double estimatedHoursHigh, double priceLow, double priceHigh, double shopMinimum, double recommendedDeposit, double confidenceScore, int similarJobsCount, String? notes, String? photoPath, DateTime createdAt
});




}
/// @nodoc
class _$QuoteCopyWithImpl<$Res>
    implements $QuoteCopyWith<$Res> {
  _$QuoteCopyWithImpl(this._self, this._then);

  final Quote _self;
  final $Res Function(Quote) _then;

/// Create a copy of Quote
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? clientId = freezed,Object? artistId = null,Object? placement = null,Object? style = null,Object? isCoverUp = null,Object? width = null,Object? height = null,Object? coverageLevel = null,Object? lineComplexity = null,Object? shadingComplexity = null,Object? colorComplexity = null,Object? difficulty = null,Object? estimatedHoursLow = null,Object? estimatedHoursHigh = null,Object? priceLow = null,Object? priceHigh = null,Object? shopMinimum = null,Object? recommendedDeposit = null,Object? confidenceScore = null,Object? similarJobsCount = null,Object? notes = freezed,Object? photoPath = freezed,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,clientId: freezed == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as int?,artistId: null == artistId ? _self.artistId : artistId // ignore: cast_nullable_to_non_nullable
as int,placement: null == placement ? _self.placement : placement // ignore: cast_nullable_to_non_nullable
as String,style: null == style ? _self.style : style // ignore: cast_nullable_to_non_nullable
as String,isCoverUp: null == isCoverUp ? _self.isCoverUp : isCoverUp // ignore: cast_nullable_to_non_nullable
as bool,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,coverageLevel: null == coverageLevel ? _self.coverageLevel : coverageLevel // ignore: cast_nullable_to_non_nullable
as int,lineComplexity: null == lineComplexity ? _self.lineComplexity : lineComplexity // ignore: cast_nullable_to_non_nullable
as int,shadingComplexity: null == shadingComplexity ? _self.shadingComplexity : shadingComplexity // ignore: cast_nullable_to_non_nullable
as int,colorComplexity: null == colorComplexity ? _self.colorComplexity : colorComplexity // ignore: cast_nullable_to_non_nullable
as int,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as int,estimatedHoursLow: null == estimatedHoursLow ? _self.estimatedHoursLow : estimatedHoursLow // ignore: cast_nullable_to_non_nullable
as double,estimatedHoursHigh: null == estimatedHoursHigh ? _self.estimatedHoursHigh : estimatedHoursHigh // ignore: cast_nullable_to_non_nullable
as double,priceLow: null == priceLow ? _self.priceLow : priceLow // ignore: cast_nullable_to_non_nullable
as double,priceHigh: null == priceHigh ? _self.priceHigh : priceHigh // ignore: cast_nullable_to_non_nullable
as double,shopMinimum: null == shopMinimum ? _self.shopMinimum : shopMinimum // ignore: cast_nullable_to_non_nullable
as double,recommendedDeposit: null == recommendedDeposit ? _self.recommendedDeposit : recommendedDeposit // ignore: cast_nullable_to_non_nullable
as double,confidenceScore: null == confidenceScore ? _self.confidenceScore : confidenceScore // ignore: cast_nullable_to_non_nullable
as double,similarJobsCount: null == similarJobsCount ? _self.similarJobsCount : similarJobsCount // ignore: cast_nullable_to_non_nullable
as int,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,photoPath: freezed == photoPath ? _self.photoPath : photoPath // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Quote].
extension QuotePatterns on Quote {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Quote value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Quote() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Quote value)  $default,){
final _that = this;
switch (_that) {
case _Quote():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Quote value)?  $default,){
final _that = this;
switch (_that) {
case _Quote() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int? clientId,  int artistId,  String placement,  String style,  bool isCoverUp,  double width,  double height,  int coverageLevel,  int lineComplexity,  int shadingComplexity,  int colorComplexity,  int difficulty,  double estimatedHoursLow,  double estimatedHoursHigh,  double priceLow,  double priceHigh,  double shopMinimum,  double recommendedDeposit,  double confidenceScore,  int similarJobsCount,  String? notes,  String? photoPath,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Quote() when $default != null:
return $default(_that.id,_that.clientId,_that.artistId,_that.placement,_that.style,_that.isCoverUp,_that.width,_that.height,_that.coverageLevel,_that.lineComplexity,_that.shadingComplexity,_that.colorComplexity,_that.difficulty,_that.estimatedHoursLow,_that.estimatedHoursHigh,_that.priceLow,_that.priceHigh,_that.shopMinimum,_that.recommendedDeposit,_that.confidenceScore,_that.similarJobsCount,_that.notes,_that.photoPath,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int? clientId,  int artistId,  String placement,  String style,  bool isCoverUp,  double width,  double height,  int coverageLevel,  int lineComplexity,  int shadingComplexity,  int colorComplexity,  int difficulty,  double estimatedHoursLow,  double estimatedHoursHigh,  double priceLow,  double priceHigh,  double shopMinimum,  double recommendedDeposit,  double confidenceScore,  int similarJobsCount,  String? notes,  String? photoPath,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _Quote():
return $default(_that.id,_that.clientId,_that.artistId,_that.placement,_that.style,_that.isCoverUp,_that.width,_that.height,_that.coverageLevel,_that.lineComplexity,_that.shadingComplexity,_that.colorComplexity,_that.difficulty,_that.estimatedHoursLow,_that.estimatedHoursHigh,_that.priceLow,_that.priceHigh,_that.shopMinimum,_that.recommendedDeposit,_that.confidenceScore,_that.similarJobsCount,_that.notes,_that.photoPath,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int? clientId,  int artistId,  String placement,  String style,  bool isCoverUp,  double width,  double height,  int coverageLevel,  int lineComplexity,  int shadingComplexity,  int colorComplexity,  int difficulty,  double estimatedHoursLow,  double estimatedHoursHigh,  double priceLow,  double priceHigh,  double shopMinimum,  double recommendedDeposit,  double confidenceScore,  int similarJobsCount,  String? notes,  String? photoPath,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Quote() when $default != null:
return $default(_that.id,_that.clientId,_that.artistId,_that.placement,_that.style,_that.isCoverUp,_that.width,_that.height,_that.coverageLevel,_that.lineComplexity,_that.shadingComplexity,_that.colorComplexity,_that.difficulty,_that.estimatedHoursLow,_that.estimatedHoursHigh,_that.priceLow,_that.priceHigh,_that.shopMinimum,_that.recommendedDeposit,_that.confidenceScore,_that.similarJobsCount,_that.notes,_that.photoPath,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Quote extends Quote {
  const _Quote({required this.id, this.clientId, required this.artistId, this.placement = '', this.style = '', this.isCoverUp = false, this.width = 0.0, this.height = 0.0, this.coverageLevel = 3, this.lineComplexity = 3, this.shadingComplexity = 3, this.colorComplexity = 3, this.difficulty = 3, this.estimatedHoursLow = 0.0, this.estimatedHoursHigh = 0.0, this.priceLow = 0.0, this.priceHigh = 0.0, this.shopMinimum = 0.0, this.recommendedDeposit = 0.0, this.confidenceScore = 0.0, this.similarJobsCount = 0, this.notes, this.photoPath, required this.createdAt}): super._();
  factory _Quote.fromJson(Map<String, dynamic> json) => _$QuoteFromJson(json);

/// Primary key
@override final  int id;
/// Optional foreign key to Client (quote may be for walk-in)
@override final  int? clientId;
/// Foreign key to User (Artist who created the quote)
@override final  int artistId;
/// Body placement location
@override@JsonKey() final  String placement;
/// Art style (Traditional, Realism, etc.)
@override@JsonKey() final  String style;
/// Whether this is a cover-up (adds complexity)
@override@JsonKey() final  bool isCoverUp;
/// Width dimension
@override@JsonKey() final  double width;
/// Height dimension
@override@JsonKey() final  double height;
/// Coverage level (1-5 scale)
@override@JsonKey() final  int coverageLevel;
/// Line work complexity (1-5 scale)
@override@JsonKey() final  int lineComplexity;
/// Shading complexity (1-5 scale)
@override@JsonKey() final  int shadingComplexity;
/// Color work complexity (1-5 scale)
@override@JsonKey() final  int colorComplexity;
/// Overall difficulty (1-5 scale)
@override@JsonKey() final  int difficulty;
/// Estimated hours - low end
@override@JsonKey() final  double estimatedHoursLow;
/// Estimated hours - high end
@override@JsonKey() final  double estimatedHoursHigh;
/// Price estimate - low end
@override@JsonKey() final  double priceLow;
/// Price estimate - high end
@override@JsonKey() final  double priceHigh;
/// Shop minimum rate applied
@override@JsonKey() final  double shopMinimum;
/// Recommended deposit amount
@override@JsonKey() final  double recommendedDeposit;
/// Confidence score (0-1, how reliable is this estimate)
@override@JsonKey() final  double confidenceScore;
/// Number of similar past jobs used for estimation
@override@JsonKey() final  int similarJobsCount;
/// Free-form notes
@override final  String? notes;
/// Path to reference photo
@override final  String? photoPath;
/// Quote creation timestamp
@override final  DateTime createdAt;

/// Create a copy of Quote
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuoteCopyWith<_Quote> get copyWith => __$QuoteCopyWithImpl<_Quote>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuoteToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Quote&&(identical(other.id, id) || other.id == id)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.artistId, artistId) || other.artistId == artistId)&&(identical(other.placement, placement) || other.placement == placement)&&(identical(other.style, style) || other.style == style)&&(identical(other.isCoverUp, isCoverUp) || other.isCoverUp == isCoverUp)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.coverageLevel, coverageLevel) || other.coverageLevel == coverageLevel)&&(identical(other.lineComplexity, lineComplexity) || other.lineComplexity == lineComplexity)&&(identical(other.shadingComplexity, shadingComplexity) || other.shadingComplexity == shadingComplexity)&&(identical(other.colorComplexity, colorComplexity) || other.colorComplexity == colorComplexity)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.estimatedHoursLow, estimatedHoursLow) || other.estimatedHoursLow == estimatedHoursLow)&&(identical(other.estimatedHoursHigh, estimatedHoursHigh) || other.estimatedHoursHigh == estimatedHoursHigh)&&(identical(other.priceLow, priceLow) || other.priceLow == priceLow)&&(identical(other.priceHigh, priceHigh) || other.priceHigh == priceHigh)&&(identical(other.shopMinimum, shopMinimum) || other.shopMinimum == shopMinimum)&&(identical(other.recommendedDeposit, recommendedDeposit) || other.recommendedDeposit == recommendedDeposit)&&(identical(other.confidenceScore, confidenceScore) || other.confidenceScore == confidenceScore)&&(identical(other.similarJobsCount, similarJobsCount) || other.similarJobsCount == similarJobsCount)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.photoPath, photoPath) || other.photoPath == photoPath)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,clientId,artistId,placement,style,isCoverUp,width,height,coverageLevel,lineComplexity,shadingComplexity,colorComplexity,difficulty,estimatedHoursLow,estimatedHoursHigh,priceLow,priceHigh,shopMinimum,recommendedDeposit,confidenceScore,similarJobsCount,notes,photoPath,createdAt]);

@override
String toString() {
  return 'Quote(id: $id, clientId: $clientId, artistId: $artistId, placement: $placement, style: $style, isCoverUp: $isCoverUp, width: $width, height: $height, coverageLevel: $coverageLevel, lineComplexity: $lineComplexity, shadingComplexity: $shadingComplexity, colorComplexity: $colorComplexity, difficulty: $difficulty, estimatedHoursLow: $estimatedHoursLow, estimatedHoursHigh: $estimatedHoursHigh, priceLow: $priceLow, priceHigh: $priceHigh, shopMinimum: $shopMinimum, recommendedDeposit: $recommendedDeposit, confidenceScore: $confidenceScore, similarJobsCount: $similarJobsCount, notes: $notes, photoPath: $photoPath, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$QuoteCopyWith<$Res> implements $QuoteCopyWith<$Res> {
  factory _$QuoteCopyWith(_Quote value, $Res Function(_Quote) _then) = __$QuoteCopyWithImpl;
@override @useResult
$Res call({
 int id, int? clientId, int artistId, String placement, String style, bool isCoverUp, double width, double height, int coverageLevel, int lineComplexity, int shadingComplexity, int colorComplexity, int difficulty, double estimatedHoursLow, double estimatedHoursHigh, double priceLow, double priceHigh, double shopMinimum, double recommendedDeposit, double confidenceScore, int similarJobsCount, String? notes, String? photoPath, DateTime createdAt
});




}
/// @nodoc
class __$QuoteCopyWithImpl<$Res>
    implements _$QuoteCopyWith<$Res> {
  __$QuoteCopyWithImpl(this._self, this._then);

  final _Quote _self;
  final $Res Function(_Quote) _then;

/// Create a copy of Quote
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? clientId = freezed,Object? artistId = null,Object? placement = null,Object? style = null,Object? isCoverUp = null,Object? width = null,Object? height = null,Object? coverageLevel = null,Object? lineComplexity = null,Object? shadingComplexity = null,Object? colorComplexity = null,Object? difficulty = null,Object? estimatedHoursLow = null,Object? estimatedHoursHigh = null,Object? priceLow = null,Object? priceHigh = null,Object? shopMinimum = null,Object? recommendedDeposit = null,Object? confidenceScore = null,Object? similarJobsCount = null,Object? notes = freezed,Object? photoPath = freezed,Object? createdAt = null,}) {
  return _then(_Quote(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,clientId: freezed == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as int?,artistId: null == artistId ? _self.artistId : artistId // ignore: cast_nullable_to_non_nullable
as int,placement: null == placement ? _self.placement : placement // ignore: cast_nullable_to_non_nullable
as String,style: null == style ? _self.style : style // ignore: cast_nullable_to_non_nullable
as String,isCoverUp: null == isCoverUp ? _self.isCoverUp : isCoverUp // ignore: cast_nullable_to_non_nullable
as bool,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,coverageLevel: null == coverageLevel ? _self.coverageLevel : coverageLevel // ignore: cast_nullable_to_non_nullable
as int,lineComplexity: null == lineComplexity ? _self.lineComplexity : lineComplexity // ignore: cast_nullable_to_non_nullable
as int,shadingComplexity: null == shadingComplexity ? _self.shadingComplexity : shadingComplexity // ignore: cast_nullable_to_non_nullable
as int,colorComplexity: null == colorComplexity ? _self.colorComplexity : colorComplexity // ignore: cast_nullable_to_non_nullable
as int,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as int,estimatedHoursLow: null == estimatedHoursLow ? _self.estimatedHoursLow : estimatedHoursLow // ignore: cast_nullable_to_non_nullable
as double,estimatedHoursHigh: null == estimatedHoursHigh ? _self.estimatedHoursHigh : estimatedHoursHigh // ignore: cast_nullable_to_non_nullable
as double,priceLow: null == priceLow ? _self.priceLow : priceLow // ignore: cast_nullable_to_non_nullable
as double,priceHigh: null == priceHigh ? _self.priceHigh : priceHigh // ignore: cast_nullable_to_non_nullable
as double,shopMinimum: null == shopMinimum ? _self.shopMinimum : shopMinimum // ignore: cast_nullable_to_non_nullable
as double,recommendedDeposit: null == recommendedDeposit ? _self.recommendedDeposit : recommendedDeposit // ignore: cast_nullable_to_non_nullable
as double,confidenceScore: null == confidenceScore ? _self.confidenceScore : confidenceScore // ignore: cast_nullable_to_non_nullable
as double,similarJobsCount: null == similarJobsCount ? _self.similarJobsCount : similarJobsCount // ignore: cast_nullable_to_non_nullable
as int,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,photoPath: freezed == photoPath ? _self.photoPath : photoPath // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$QuoteInput {

/// Optional client ID
 int? get clientId;/// Artist ID who is creating the quote
 int get artistId;/// Body placement location
 String get placement;/// Art style
 String get style;/// Whether this is a cover-up
 bool get isCoverUp;/// Width dimension
 double get width;/// Height dimension
 double get height;/// Coverage level (1-5)
 int get coverageLevel;/// Line complexity (1-5)
 int get lineComplexity;/// Shading complexity (1-5)
 int get shadingComplexity;/// Color complexity (1-5)
 int get colorComplexity;/// Overall difficulty (1-5)
 int get difficulty;/// Free-form notes
 String? get notes;/// Reference photo path
 String? get photoPath;
/// Create a copy of QuoteInput
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuoteInputCopyWith<QuoteInput> get copyWith => _$QuoteInputCopyWithImpl<QuoteInput>(this as QuoteInput, _$identity);

  /// Serializes this QuoteInput to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuoteInput&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.artistId, artistId) || other.artistId == artistId)&&(identical(other.placement, placement) || other.placement == placement)&&(identical(other.style, style) || other.style == style)&&(identical(other.isCoverUp, isCoverUp) || other.isCoverUp == isCoverUp)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.coverageLevel, coverageLevel) || other.coverageLevel == coverageLevel)&&(identical(other.lineComplexity, lineComplexity) || other.lineComplexity == lineComplexity)&&(identical(other.shadingComplexity, shadingComplexity) || other.shadingComplexity == shadingComplexity)&&(identical(other.colorComplexity, colorComplexity) || other.colorComplexity == colorComplexity)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.photoPath, photoPath) || other.photoPath == photoPath));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,clientId,artistId,placement,style,isCoverUp,width,height,coverageLevel,lineComplexity,shadingComplexity,colorComplexity,difficulty,notes,photoPath);

@override
String toString() {
  return 'QuoteInput(clientId: $clientId, artistId: $artistId, placement: $placement, style: $style, isCoverUp: $isCoverUp, width: $width, height: $height, coverageLevel: $coverageLevel, lineComplexity: $lineComplexity, shadingComplexity: $shadingComplexity, colorComplexity: $colorComplexity, difficulty: $difficulty, notes: $notes, photoPath: $photoPath)';
}


}

/// @nodoc
abstract mixin class $QuoteInputCopyWith<$Res>  {
  factory $QuoteInputCopyWith(QuoteInput value, $Res Function(QuoteInput) _then) = _$QuoteInputCopyWithImpl;
@useResult
$Res call({
 int? clientId, int artistId, String placement, String style, bool isCoverUp, double width, double height, int coverageLevel, int lineComplexity, int shadingComplexity, int colorComplexity, int difficulty, String? notes, String? photoPath
});




}
/// @nodoc
class _$QuoteInputCopyWithImpl<$Res>
    implements $QuoteInputCopyWith<$Res> {
  _$QuoteInputCopyWithImpl(this._self, this._then);

  final QuoteInput _self;
  final $Res Function(QuoteInput) _then;

/// Create a copy of QuoteInput
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? clientId = freezed,Object? artistId = null,Object? placement = null,Object? style = null,Object? isCoverUp = null,Object? width = null,Object? height = null,Object? coverageLevel = null,Object? lineComplexity = null,Object? shadingComplexity = null,Object? colorComplexity = null,Object? difficulty = null,Object? notes = freezed,Object? photoPath = freezed,}) {
  return _then(_self.copyWith(
clientId: freezed == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as int?,artistId: null == artistId ? _self.artistId : artistId // ignore: cast_nullable_to_non_nullable
as int,placement: null == placement ? _self.placement : placement // ignore: cast_nullable_to_non_nullable
as String,style: null == style ? _self.style : style // ignore: cast_nullable_to_non_nullable
as String,isCoverUp: null == isCoverUp ? _self.isCoverUp : isCoverUp // ignore: cast_nullable_to_non_nullable
as bool,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,coverageLevel: null == coverageLevel ? _self.coverageLevel : coverageLevel // ignore: cast_nullable_to_non_nullable
as int,lineComplexity: null == lineComplexity ? _self.lineComplexity : lineComplexity // ignore: cast_nullable_to_non_nullable
as int,shadingComplexity: null == shadingComplexity ? _self.shadingComplexity : shadingComplexity // ignore: cast_nullable_to_non_nullable
as int,colorComplexity: null == colorComplexity ? _self.colorComplexity : colorComplexity // ignore: cast_nullable_to_non_nullable
as int,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as int,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,photoPath: freezed == photoPath ? _self.photoPath : photoPath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [QuoteInput].
extension QuoteInputPatterns on QuoteInput {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuoteInput value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuoteInput() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuoteInput value)  $default,){
final _that = this;
switch (_that) {
case _QuoteInput():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuoteInput value)?  $default,){
final _that = this;
switch (_that) {
case _QuoteInput() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? clientId,  int artistId,  String placement,  String style,  bool isCoverUp,  double width,  double height,  int coverageLevel,  int lineComplexity,  int shadingComplexity,  int colorComplexity,  int difficulty,  String? notes,  String? photoPath)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuoteInput() when $default != null:
return $default(_that.clientId,_that.artistId,_that.placement,_that.style,_that.isCoverUp,_that.width,_that.height,_that.coverageLevel,_that.lineComplexity,_that.shadingComplexity,_that.colorComplexity,_that.difficulty,_that.notes,_that.photoPath);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? clientId,  int artistId,  String placement,  String style,  bool isCoverUp,  double width,  double height,  int coverageLevel,  int lineComplexity,  int shadingComplexity,  int colorComplexity,  int difficulty,  String? notes,  String? photoPath)  $default,) {final _that = this;
switch (_that) {
case _QuoteInput():
return $default(_that.clientId,_that.artistId,_that.placement,_that.style,_that.isCoverUp,_that.width,_that.height,_that.coverageLevel,_that.lineComplexity,_that.shadingComplexity,_that.colorComplexity,_that.difficulty,_that.notes,_that.photoPath);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? clientId,  int artistId,  String placement,  String style,  bool isCoverUp,  double width,  double height,  int coverageLevel,  int lineComplexity,  int shadingComplexity,  int colorComplexity,  int difficulty,  String? notes,  String? photoPath)?  $default,) {final _that = this;
switch (_that) {
case _QuoteInput() when $default != null:
return $default(_that.clientId,_that.artistId,_that.placement,_that.style,_that.isCoverUp,_that.width,_that.height,_that.coverageLevel,_that.lineComplexity,_that.shadingComplexity,_that.colorComplexity,_that.difficulty,_that.notes,_that.photoPath);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QuoteInput implements QuoteInput {
  const _QuoteInput({this.clientId, required this.artistId, this.placement = '', this.style = '', this.isCoverUp = false, this.width = 0.0, this.height = 0.0, this.coverageLevel = 3, this.lineComplexity = 3, this.shadingComplexity = 3, this.colorComplexity = 3, this.difficulty = 3, this.notes, this.photoPath});
  factory _QuoteInput.fromJson(Map<String, dynamic> json) => _$QuoteInputFromJson(json);

/// Optional client ID
@override final  int? clientId;
/// Artist ID who is creating the quote
@override final  int artistId;
/// Body placement location
@override@JsonKey() final  String placement;
/// Art style
@override@JsonKey() final  String style;
/// Whether this is a cover-up
@override@JsonKey() final  bool isCoverUp;
/// Width dimension
@override@JsonKey() final  double width;
/// Height dimension
@override@JsonKey() final  double height;
/// Coverage level (1-5)
@override@JsonKey() final  int coverageLevel;
/// Line complexity (1-5)
@override@JsonKey() final  int lineComplexity;
/// Shading complexity (1-5)
@override@JsonKey() final  int shadingComplexity;
/// Color complexity (1-5)
@override@JsonKey() final  int colorComplexity;
/// Overall difficulty (1-5)
@override@JsonKey() final  int difficulty;
/// Free-form notes
@override final  String? notes;
/// Reference photo path
@override final  String? photoPath;

/// Create a copy of QuoteInput
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuoteInputCopyWith<_QuoteInput> get copyWith => __$QuoteInputCopyWithImpl<_QuoteInput>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuoteInputToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuoteInput&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.artistId, artistId) || other.artistId == artistId)&&(identical(other.placement, placement) || other.placement == placement)&&(identical(other.style, style) || other.style == style)&&(identical(other.isCoverUp, isCoverUp) || other.isCoverUp == isCoverUp)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.coverageLevel, coverageLevel) || other.coverageLevel == coverageLevel)&&(identical(other.lineComplexity, lineComplexity) || other.lineComplexity == lineComplexity)&&(identical(other.shadingComplexity, shadingComplexity) || other.shadingComplexity == shadingComplexity)&&(identical(other.colorComplexity, colorComplexity) || other.colorComplexity == colorComplexity)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.photoPath, photoPath) || other.photoPath == photoPath));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,clientId,artistId,placement,style,isCoverUp,width,height,coverageLevel,lineComplexity,shadingComplexity,colorComplexity,difficulty,notes,photoPath);

@override
String toString() {
  return 'QuoteInput(clientId: $clientId, artistId: $artistId, placement: $placement, style: $style, isCoverUp: $isCoverUp, width: $width, height: $height, coverageLevel: $coverageLevel, lineComplexity: $lineComplexity, shadingComplexity: $shadingComplexity, colorComplexity: $colorComplexity, difficulty: $difficulty, notes: $notes, photoPath: $photoPath)';
}


}

/// @nodoc
abstract mixin class _$QuoteInputCopyWith<$Res> implements $QuoteInputCopyWith<$Res> {
  factory _$QuoteInputCopyWith(_QuoteInput value, $Res Function(_QuoteInput) _then) = __$QuoteInputCopyWithImpl;
@override @useResult
$Res call({
 int? clientId, int artistId, String placement, String style, bool isCoverUp, double width, double height, int coverageLevel, int lineComplexity, int shadingComplexity, int colorComplexity, int difficulty, String? notes, String? photoPath
});




}
/// @nodoc
class __$QuoteInputCopyWithImpl<$Res>
    implements _$QuoteInputCopyWith<$Res> {
  __$QuoteInputCopyWithImpl(this._self, this._then);

  final _QuoteInput _self;
  final $Res Function(_QuoteInput) _then;

/// Create a copy of QuoteInput
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? clientId = freezed,Object? artistId = null,Object? placement = null,Object? style = null,Object? isCoverUp = null,Object? width = null,Object? height = null,Object? coverageLevel = null,Object? lineComplexity = null,Object? shadingComplexity = null,Object? colorComplexity = null,Object? difficulty = null,Object? notes = freezed,Object? photoPath = freezed,}) {
  return _then(_QuoteInput(
clientId: freezed == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as int?,artistId: null == artistId ? _self.artistId : artistId // ignore: cast_nullable_to_non_nullable
as int,placement: null == placement ? _self.placement : placement // ignore: cast_nullable_to_non_nullable
as String,style: null == style ? _self.style : style // ignore: cast_nullable_to_non_nullable
as String,isCoverUp: null == isCoverUp ? _self.isCoverUp : isCoverUp // ignore: cast_nullable_to_non_nullable
as bool,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,coverageLevel: null == coverageLevel ? _self.coverageLevel : coverageLevel // ignore: cast_nullable_to_non_nullable
as int,lineComplexity: null == lineComplexity ? _self.lineComplexity : lineComplexity // ignore: cast_nullable_to_non_nullable
as int,shadingComplexity: null == shadingComplexity ? _self.shadingComplexity : shadingComplexity // ignore: cast_nullable_to_non_nullable
as int,colorComplexity: null == colorComplexity ? _self.colorComplexity : colorComplexity // ignore: cast_nullable_to_non_nullable
as int,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as int,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,photoPath: freezed == photoPath ? _self.photoPath : photoPath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$QuoteEstimate {

/// Estimated hours - low end
 double get estimatedHoursLow;/// Estimated hours - high end
 double get estimatedHoursHigh;/// Price estimate - low end
 double get priceLow;/// Price estimate - high end
 double get priceHigh;/// Shop minimum applied
 double get shopMinimum;/// Recommended deposit
 double get recommendedDeposit;/// Confidence score (0-1)
 double get confidenceScore;/// Number of similar past jobs
 int get similarJobsCount;
/// Create a copy of QuoteEstimate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuoteEstimateCopyWith<QuoteEstimate> get copyWith => _$QuoteEstimateCopyWithImpl<QuoteEstimate>(this as QuoteEstimate, _$identity);

  /// Serializes this QuoteEstimate to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuoteEstimate&&(identical(other.estimatedHoursLow, estimatedHoursLow) || other.estimatedHoursLow == estimatedHoursLow)&&(identical(other.estimatedHoursHigh, estimatedHoursHigh) || other.estimatedHoursHigh == estimatedHoursHigh)&&(identical(other.priceLow, priceLow) || other.priceLow == priceLow)&&(identical(other.priceHigh, priceHigh) || other.priceHigh == priceHigh)&&(identical(other.shopMinimum, shopMinimum) || other.shopMinimum == shopMinimum)&&(identical(other.recommendedDeposit, recommendedDeposit) || other.recommendedDeposit == recommendedDeposit)&&(identical(other.confidenceScore, confidenceScore) || other.confidenceScore == confidenceScore)&&(identical(other.similarJobsCount, similarJobsCount) || other.similarJobsCount == similarJobsCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,estimatedHoursLow,estimatedHoursHigh,priceLow,priceHigh,shopMinimum,recommendedDeposit,confidenceScore,similarJobsCount);

@override
String toString() {
  return 'QuoteEstimate(estimatedHoursLow: $estimatedHoursLow, estimatedHoursHigh: $estimatedHoursHigh, priceLow: $priceLow, priceHigh: $priceHigh, shopMinimum: $shopMinimum, recommendedDeposit: $recommendedDeposit, confidenceScore: $confidenceScore, similarJobsCount: $similarJobsCount)';
}


}

/// @nodoc
abstract mixin class $QuoteEstimateCopyWith<$Res>  {
  factory $QuoteEstimateCopyWith(QuoteEstimate value, $Res Function(QuoteEstimate) _then) = _$QuoteEstimateCopyWithImpl;
@useResult
$Res call({
 double estimatedHoursLow, double estimatedHoursHigh, double priceLow, double priceHigh, double shopMinimum, double recommendedDeposit, double confidenceScore, int similarJobsCount
});




}
/// @nodoc
class _$QuoteEstimateCopyWithImpl<$Res>
    implements $QuoteEstimateCopyWith<$Res> {
  _$QuoteEstimateCopyWithImpl(this._self, this._then);

  final QuoteEstimate _self;
  final $Res Function(QuoteEstimate) _then;

/// Create a copy of QuoteEstimate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? estimatedHoursLow = null,Object? estimatedHoursHigh = null,Object? priceLow = null,Object? priceHigh = null,Object? shopMinimum = null,Object? recommendedDeposit = null,Object? confidenceScore = null,Object? similarJobsCount = null,}) {
  return _then(_self.copyWith(
estimatedHoursLow: null == estimatedHoursLow ? _self.estimatedHoursLow : estimatedHoursLow // ignore: cast_nullable_to_non_nullable
as double,estimatedHoursHigh: null == estimatedHoursHigh ? _self.estimatedHoursHigh : estimatedHoursHigh // ignore: cast_nullable_to_non_nullable
as double,priceLow: null == priceLow ? _self.priceLow : priceLow // ignore: cast_nullable_to_non_nullable
as double,priceHigh: null == priceHigh ? _self.priceHigh : priceHigh // ignore: cast_nullable_to_non_nullable
as double,shopMinimum: null == shopMinimum ? _self.shopMinimum : shopMinimum // ignore: cast_nullable_to_non_nullable
as double,recommendedDeposit: null == recommendedDeposit ? _self.recommendedDeposit : recommendedDeposit // ignore: cast_nullable_to_non_nullable
as double,confidenceScore: null == confidenceScore ? _self.confidenceScore : confidenceScore // ignore: cast_nullable_to_non_nullable
as double,similarJobsCount: null == similarJobsCount ? _self.similarJobsCount : similarJobsCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [QuoteEstimate].
extension QuoteEstimatePatterns on QuoteEstimate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuoteEstimate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuoteEstimate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuoteEstimate value)  $default,){
final _that = this;
switch (_that) {
case _QuoteEstimate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuoteEstimate value)?  $default,){
final _that = this;
switch (_that) {
case _QuoteEstimate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double estimatedHoursLow,  double estimatedHoursHigh,  double priceLow,  double priceHigh,  double shopMinimum,  double recommendedDeposit,  double confidenceScore,  int similarJobsCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuoteEstimate() when $default != null:
return $default(_that.estimatedHoursLow,_that.estimatedHoursHigh,_that.priceLow,_that.priceHigh,_that.shopMinimum,_that.recommendedDeposit,_that.confidenceScore,_that.similarJobsCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double estimatedHoursLow,  double estimatedHoursHigh,  double priceLow,  double priceHigh,  double shopMinimum,  double recommendedDeposit,  double confidenceScore,  int similarJobsCount)  $default,) {final _that = this;
switch (_that) {
case _QuoteEstimate():
return $default(_that.estimatedHoursLow,_that.estimatedHoursHigh,_that.priceLow,_that.priceHigh,_that.shopMinimum,_that.recommendedDeposit,_that.confidenceScore,_that.similarJobsCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double estimatedHoursLow,  double estimatedHoursHigh,  double priceLow,  double priceHigh,  double shopMinimum,  double recommendedDeposit,  double confidenceScore,  int similarJobsCount)?  $default,) {final _that = this;
switch (_that) {
case _QuoteEstimate() when $default != null:
return $default(_that.estimatedHoursLow,_that.estimatedHoursHigh,_that.priceLow,_that.priceHigh,_that.shopMinimum,_that.recommendedDeposit,_that.confidenceScore,_that.similarJobsCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QuoteEstimate implements QuoteEstimate {
  const _QuoteEstimate({required this.estimatedHoursLow, required this.estimatedHoursHigh, required this.priceLow, required this.priceHigh, required this.shopMinimum, required this.recommendedDeposit, required this.confidenceScore, required this.similarJobsCount});
  factory _QuoteEstimate.fromJson(Map<String, dynamic> json) => _$QuoteEstimateFromJson(json);

/// Estimated hours - low end
@override final  double estimatedHoursLow;
/// Estimated hours - high end
@override final  double estimatedHoursHigh;
/// Price estimate - low end
@override final  double priceLow;
/// Price estimate - high end
@override final  double priceHigh;
/// Shop minimum applied
@override final  double shopMinimum;
/// Recommended deposit
@override final  double recommendedDeposit;
/// Confidence score (0-1)
@override final  double confidenceScore;
/// Number of similar past jobs
@override final  int similarJobsCount;

/// Create a copy of QuoteEstimate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuoteEstimateCopyWith<_QuoteEstimate> get copyWith => __$QuoteEstimateCopyWithImpl<_QuoteEstimate>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuoteEstimateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuoteEstimate&&(identical(other.estimatedHoursLow, estimatedHoursLow) || other.estimatedHoursLow == estimatedHoursLow)&&(identical(other.estimatedHoursHigh, estimatedHoursHigh) || other.estimatedHoursHigh == estimatedHoursHigh)&&(identical(other.priceLow, priceLow) || other.priceLow == priceLow)&&(identical(other.priceHigh, priceHigh) || other.priceHigh == priceHigh)&&(identical(other.shopMinimum, shopMinimum) || other.shopMinimum == shopMinimum)&&(identical(other.recommendedDeposit, recommendedDeposit) || other.recommendedDeposit == recommendedDeposit)&&(identical(other.confidenceScore, confidenceScore) || other.confidenceScore == confidenceScore)&&(identical(other.similarJobsCount, similarJobsCount) || other.similarJobsCount == similarJobsCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,estimatedHoursLow,estimatedHoursHigh,priceLow,priceHigh,shopMinimum,recommendedDeposit,confidenceScore,similarJobsCount);

@override
String toString() {
  return 'QuoteEstimate(estimatedHoursLow: $estimatedHoursLow, estimatedHoursHigh: $estimatedHoursHigh, priceLow: $priceLow, priceHigh: $priceHigh, shopMinimum: $shopMinimum, recommendedDeposit: $recommendedDeposit, confidenceScore: $confidenceScore, similarJobsCount: $similarJobsCount)';
}


}

/// @nodoc
abstract mixin class _$QuoteEstimateCopyWith<$Res> implements $QuoteEstimateCopyWith<$Res> {
  factory _$QuoteEstimateCopyWith(_QuoteEstimate value, $Res Function(_QuoteEstimate) _then) = __$QuoteEstimateCopyWithImpl;
@override @useResult
$Res call({
 double estimatedHoursLow, double estimatedHoursHigh, double priceLow, double priceHigh, double shopMinimum, double recommendedDeposit, double confidenceScore, int similarJobsCount
});




}
/// @nodoc
class __$QuoteEstimateCopyWithImpl<$Res>
    implements _$QuoteEstimateCopyWith<$Res> {
  __$QuoteEstimateCopyWithImpl(this._self, this._then);

  final _QuoteEstimate _self;
  final $Res Function(_QuoteEstimate) _then;

/// Create a copy of QuoteEstimate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? estimatedHoursLow = null,Object? estimatedHoursHigh = null,Object? priceLow = null,Object? priceHigh = null,Object? shopMinimum = null,Object? recommendedDeposit = null,Object? confidenceScore = null,Object? similarJobsCount = null,}) {
  return _then(_QuoteEstimate(
estimatedHoursLow: null == estimatedHoursLow ? _self.estimatedHoursLow : estimatedHoursLow // ignore: cast_nullable_to_non_nullable
as double,estimatedHoursHigh: null == estimatedHoursHigh ? _self.estimatedHoursHigh : estimatedHoursHigh // ignore: cast_nullable_to_non_nullable
as double,priceLow: null == priceLow ? _self.priceLow : priceLow // ignore: cast_nullable_to_non_nullable
as double,priceHigh: null == priceHigh ? _self.priceHigh : priceHigh // ignore: cast_nullable_to_non_nullable
as double,shopMinimum: null == shopMinimum ? _self.shopMinimum : shopMinimum // ignore: cast_nullable_to_non_nullable
as double,recommendedDeposit: null == recommendedDeposit ? _self.recommendedDeposit : recommendedDeposit // ignore: cast_nullable_to_non_nullable
as double,confidenceScore: null == confidenceScore ? _self.confidenceScore : confidenceScore // ignore: cast_nullable_to_non_nullable
as double,similarJobsCount: null == similarJobsCount ? _self.similarJobsCount : similarJobsCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
