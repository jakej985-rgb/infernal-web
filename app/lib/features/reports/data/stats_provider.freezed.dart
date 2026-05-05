// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stats_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ShopOverviewStats {

 double get totalRevenue; int get totalClients; int get completedAppointments; int get upcomingAppointments; Map<String, int> get appointmentsByStatus; List<RevenueDataPoint> get revenueOverTime;
/// Create a copy of ShopOverviewStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShopOverviewStatsCopyWith<ShopOverviewStats> get copyWith => _$ShopOverviewStatsCopyWithImpl<ShopOverviewStats>(this as ShopOverviewStats, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShopOverviewStats&&(identical(other.totalRevenue, totalRevenue) || other.totalRevenue == totalRevenue)&&(identical(other.totalClients, totalClients) || other.totalClients == totalClients)&&(identical(other.completedAppointments, completedAppointments) || other.completedAppointments == completedAppointments)&&(identical(other.upcomingAppointments, upcomingAppointments) || other.upcomingAppointments == upcomingAppointments)&&const DeepCollectionEquality().equals(other.appointmentsByStatus, appointmentsByStatus)&&const DeepCollectionEquality().equals(other.revenueOverTime, revenueOverTime));
}


@override
int get hashCode => Object.hash(runtimeType,totalRevenue,totalClients,completedAppointments,upcomingAppointments,const DeepCollectionEquality().hash(appointmentsByStatus),const DeepCollectionEquality().hash(revenueOverTime));

@override
String toString() {
  return 'ShopOverviewStats(totalRevenue: $totalRevenue, totalClients: $totalClients, completedAppointments: $completedAppointments, upcomingAppointments: $upcomingAppointments, appointmentsByStatus: $appointmentsByStatus, revenueOverTime: $revenueOverTime)';
}


}

/// @nodoc
abstract mixin class $ShopOverviewStatsCopyWith<$Res>  {
  factory $ShopOverviewStatsCopyWith(ShopOverviewStats value, $Res Function(ShopOverviewStats) _then) = _$ShopOverviewStatsCopyWithImpl;
@useResult
$Res call({
 double totalRevenue, int totalClients, int completedAppointments, int upcomingAppointments, Map<String, int> appointmentsByStatus, List<RevenueDataPoint> revenueOverTime
});




}
/// @nodoc
class _$ShopOverviewStatsCopyWithImpl<$Res>
    implements $ShopOverviewStatsCopyWith<$Res> {
  _$ShopOverviewStatsCopyWithImpl(this._self, this._then);

  final ShopOverviewStats _self;
  final $Res Function(ShopOverviewStats) _then;

/// Create a copy of ShopOverviewStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalRevenue = null,Object? totalClients = null,Object? completedAppointments = null,Object? upcomingAppointments = null,Object? appointmentsByStatus = null,Object? revenueOverTime = null,}) {
  return _then(_self.copyWith(
totalRevenue: null == totalRevenue ? _self.totalRevenue : totalRevenue // ignore: cast_nullable_to_non_nullable
as double,totalClients: null == totalClients ? _self.totalClients : totalClients // ignore: cast_nullable_to_non_nullable
as int,completedAppointments: null == completedAppointments ? _self.completedAppointments : completedAppointments // ignore: cast_nullable_to_non_nullable
as int,upcomingAppointments: null == upcomingAppointments ? _self.upcomingAppointments : upcomingAppointments // ignore: cast_nullable_to_non_nullable
as int,appointmentsByStatus: null == appointmentsByStatus ? _self.appointmentsByStatus : appointmentsByStatus // ignore: cast_nullable_to_non_nullable
as Map<String, int>,revenueOverTime: null == revenueOverTime ? _self.revenueOverTime : revenueOverTime // ignore: cast_nullable_to_non_nullable
as List<RevenueDataPoint>,
  ));
}

}


/// Adds pattern-matching-related methods to [ShopOverviewStats].
extension ShopOverviewStatsPatterns on ShopOverviewStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShopOverviewStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShopOverviewStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShopOverviewStats value)  $default,){
final _that = this;
switch (_that) {
case _ShopOverviewStats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShopOverviewStats value)?  $default,){
final _that = this;
switch (_that) {
case _ShopOverviewStats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double totalRevenue,  int totalClients,  int completedAppointments,  int upcomingAppointments,  Map<String, int> appointmentsByStatus,  List<RevenueDataPoint> revenueOverTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShopOverviewStats() when $default != null:
return $default(_that.totalRevenue,_that.totalClients,_that.completedAppointments,_that.upcomingAppointments,_that.appointmentsByStatus,_that.revenueOverTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double totalRevenue,  int totalClients,  int completedAppointments,  int upcomingAppointments,  Map<String, int> appointmentsByStatus,  List<RevenueDataPoint> revenueOverTime)  $default,) {final _that = this;
switch (_that) {
case _ShopOverviewStats():
return $default(_that.totalRevenue,_that.totalClients,_that.completedAppointments,_that.upcomingAppointments,_that.appointmentsByStatus,_that.revenueOverTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double totalRevenue,  int totalClients,  int completedAppointments,  int upcomingAppointments,  Map<String, int> appointmentsByStatus,  List<RevenueDataPoint> revenueOverTime)?  $default,) {final _that = this;
switch (_that) {
case _ShopOverviewStats() when $default != null:
return $default(_that.totalRevenue,_that.totalClients,_that.completedAppointments,_that.upcomingAppointments,_that.appointmentsByStatus,_that.revenueOverTime);case _:
  return null;

}
}

}

/// @nodoc


class _ShopOverviewStats implements ShopOverviewStats {
  const _ShopOverviewStats({required this.totalRevenue, required this.totalClients, required this.completedAppointments, required this.upcomingAppointments, required final  Map<String, int> appointmentsByStatus, required final  List<RevenueDataPoint> revenueOverTime}): _appointmentsByStatus = appointmentsByStatus,_revenueOverTime = revenueOverTime;
  

@override final  double totalRevenue;
@override final  int totalClients;
@override final  int completedAppointments;
@override final  int upcomingAppointments;
 final  Map<String, int> _appointmentsByStatus;
@override Map<String, int> get appointmentsByStatus {
  if (_appointmentsByStatus is EqualUnmodifiableMapView) return _appointmentsByStatus;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_appointmentsByStatus);
}

 final  List<RevenueDataPoint> _revenueOverTime;
@override List<RevenueDataPoint> get revenueOverTime {
  if (_revenueOverTime is EqualUnmodifiableListView) return _revenueOverTime;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_revenueOverTime);
}


/// Create a copy of ShopOverviewStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShopOverviewStatsCopyWith<_ShopOverviewStats> get copyWith => __$ShopOverviewStatsCopyWithImpl<_ShopOverviewStats>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShopOverviewStats&&(identical(other.totalRevenue, totalRevenue) || other.totalRevenue == totalRevenue)&&(identical(other.totalClients, totalClients) || other.totalClients == totalClients)&&(identical(other.completedAppointments, completedAppointments) || other.completedAppointments == completedAppointments)&&(identical(other.upcomingAppointments, upcomingAppointments) || other.upcomingAppointments == upcomingAppointments)&&const DeepCollectionEquality().equals(other._appointmentsByStatus, _appointmentsByStatus)&&const DeepCollectionEquality().equals(other._revenueOverTime, _revenueOverTime));
}


@override
int get hashCode => Object.hash(runtimeType,totalRevenue,totalClients,completedAppointments,upcomingAppointments,const DeepCollectionEquality().hash(_appointmentsByStatus),const DeepCollectionEquality().hash(_revenueOverTime));

@override
String toString() {
  return 'ShopOverviewStats(totalRevenue: $totalRevenue, totalClients: $totalClients, completedAppointments: $completedAppointments, upcomingAppointments: $upcomingAppointments, appointmentsByStatus: $appointmentsByStatus, revenueOverTime: $revenueOverTime)';
}


}

/// @nodoc
abstract mixin class _$ShopOverviewStatsCopyWith<$Res> implements $ShopOverviewStatsCopyWith<$Res> {
  factory _$ShopOverviewStatsCopyWith(_ShopOverviewStats value, $Res Function(_ShopOverviewStats) _then) = __$ShopOverviewStatsCopyWithImpl;
@override @useResult
$Res call({
 double totalRevenue, int totalClients, int completedAppointments, int upcomingAppointments, Map<String, int> appointmentsByStatus, List<RevenueDataPoint> revenueOverTime
});




}
/// @nodoc
class __$ShopOverviewStatsCopyWithImpl<$Res>
    implements _$ShopOverviewStatsCopyWith<$Res> {
  __$ShopOverviewStatsCopyWithImpl(this._self, this._then);

  final _ShopOverviewStats _self;
  final $Res Function(_ShopOverviewStats) _then;

/// Create a copy of ShopOverviewStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalRevenue = null,Object? totalClients = null,Object? completedAppointments = null,Object? upcomingAppointments = null,Object? appointmentsByStatus = null,Object? revenueOverTime = null,}) {
  return _then(_ShopOverviewStats(
totalRevenue: null == totalRevenue ? _self.totalRevenue : totalRevenue // ignore: cast_nullable_to_non_nullable
as double,totalClients: null == totalClients ? _self.totalClients : totalClients // ignore: cast_nullable_to_non_nullable
as int,completedAppointments: null == completedAppointments ? _self.completedAppointments : completedAppointments // ignore: cast_nullable_to_non_nullable
as int,upcomingAppointments: null == upcomingAppointments ? _self.upcomingAppointments : upcomingAppointments // ignore: cast_nullable_to_non_nullable
as int,appointmentsByStatus: null == appointmentsByStatus ? _self._appointmentsByStatus : appointmentsByStatus // ignore: cast_nullable_to_non_nullable
as Map<String, int>,revenueOverTime: null == revenueOverTime ? _self._revenueOverTime : revenueOverTime // ignore: cast_nullable_to_non_nullable
as List<RevenueDataPoint>,
  ));
}


}

// dart format on
