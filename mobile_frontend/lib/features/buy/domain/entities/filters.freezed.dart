// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'filters.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Filters {

 double get minRating; double? get minPrice; double? get maxPrice; bool get discountOnly; bool get locallySourcedOnly; bool get pesticideFreeOnly;
/// Create a copy of Filters
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FiltersCopyWith<Filters> get copyWith => _$FiltersCopyWithImpl<Filters>(this as Filters, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Filters&&(identical(other.minRating, minRating) || other.minRating == minRating)&&(identical(other.minPrice, minPrice) || other.minPrice == minPrice)&&(identical(other.maxPrice, maxPrice) || other.maxPrice == maxPrice)&&(identical(other.discountOnly, discountOnly) || other.discountOnly == discountOnly)&&(identical(other.locallySourcedOnly, locallySourcedOnly) || other.locallySourcedOnly == locallySourcedOnly)&&(identical(other.pesticideFreeOnly, pesticideFreeOnly) || other.pesticideFreeOnly == pesticideFreeOnly));
}


@override
int get hashCode => Object.hash(runtimeType,minRating,minPrice,maxPrice,discountOnly,locallySourcedOnly,pesticideFreeOnly);

@override
String toString() {
  return 'Filters(minRating: $minRating, minPrice: $minPrice, maxPrice: $maxPrice, discountOnly: $discountOnly, locallySourcedOnly: $locallySourcedOnly, pesticideFreeOnly: $pesticideFreeOnly)';
}


}

/// @nodoc
abstract mixin class $FiltersCopyWith<$Res>  {
  factory $FiltersCopyWith(Filters value, $Res Function(Filters) _then) = _$FiltersCopyWithImpl;
@useResult
$Res call({
 double minRating, double? minPrice, double? maxPrice, bool discountOnly, bool locallySourcedOnly, bool pesticideFreeOnly
});




}
/// @nodoc
class _$FiltersCopyWithImpl<$Res>
    implements $FiltersCopyWith<$Res> {
  _$FiltersCopyWithImpl(this._self, this._then);

  final Filters _self;
  final $Res Function(Filters) _then;

/// Create a copy of Filters
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? minRating = null,Object? minPrice = freezed,Object? maxPrice = freezed,Object? discountOnly = null,Object? locallySourcedOnly = null,Object? pesticideFreeOnly = null,}) {
  return _then(_self.copyWith(
minRating: null == minRating ? _self.minRating : minRating // ignore: cast_nullable_to_non_nullable
as double,minPrice: freezed == minPrice ? _self.minPrice : minPrice // ignore: cast_nullable_to_non_nullable
as double?,maxPrice: freezed == maxPrice ? _self.maxPrice : maxPrice // ignore: cast_nullable_to_non_nullable
as double?,discountOnly: null == discountOnly ? _self.discountOnly : discountOnly // ignore: cast_nullable_to_non_nullable
as bool,locallySourcedOnly: null == locallySourcedOnly ? _self.locallySourcedOnly : locallySourcedOnly // ignore: cast_nullable_to_non_nullable
as bool,pesticideFreeOnly: null == pesticideFreeOnly ? _self.pesticideFreeOnly : pesticideFreeOnly // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Filters].
extension FiltersPatterns on Filters {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Filters value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Filters() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Filters value)  $default,){
final _that = this;
switch (_that) {
case _Filters():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Filters value)?  $default,){
final _that = this;
switch (_that) {
case _Filters() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double minRating,  double? minPrice,  double? maxPrice,  bool discountOnly,  bool locallySourcedOnly,  bool pesticideFreeOnly)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Filters() when $default != null:
return $default(_that.minRating,_that.minPrice,_that.maxPrice,_that.discountOnly,_that.locallySourcedOnly,_that.pesticideFreeOnly);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double minRating,  double? minPrice,  double? maxPrice,  bool discountOnly,  bool locallySourcedOnly,  bool pesticideFreeOnly)  $default,) {final _that = this;
switch (_that) {
case _Filters():
return $default(_that.minRating,_that.minPrice,_that.maxPrice,_that.discountOnly,_that.locallySourcedOnly,_that.pesticideFreeOnly);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double minRating,  double? minPrice,  double? maxPrice,  bool discountOnly,  bool locallySourcedOnly,  bool pesticideFreeOnly)?  $default,) {final _that = this;
switch (_that) {
case _Filters() when $default != null:
return $default(_that.minRating,_that.minPrice,_that.maxPrice,_that.discountOnly,_that.locallySourcedOnly,_that.pesticideFreeOnly);case _:
  return null;

}
}

}

/// @nodoc


class _Filters implements Filters {
  const _Filters({required this.minRating, this.minPrice, this.maxPrice, this.discountOnly = false, this.locallySourcedOnly = false, this.pesticideFreeOnly = false});
  

@override final  double minRating;
@override final  double? minPrice;
@override final  double? maxPrice;
@override@JsonKey() final  bool discountOnly;
@override@JsonKey() final  bool locallySourcedOnly;
@override@JsonKey() final  bool pesticideFreeOnly;

/// Create a copy of Filters
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FiltersCopyWith<_Filters> get copyWith => __$FiltersCopyWithImpl<_Filters>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Filters&&(identical(other.minRating, minRating) || other.minRating == minRating)&&(identical(other.minPrice, minPrice) || other.minPrice == minPrice)&&(identical(other.maxPrice, maxPrice) || other.maxPrice == maxPrice)&&(identical(other.discountOnly, discountOnly) || other.discountOnly == discountOnly)&&(identical(other.locallySourcedOnly, locallySourcedOnly) || other.locallySourcedOnly == locallySourcedOnly)&&(identical(other.pesticideFreeOnly, pesticideFreeOnly) || other.pesticideFreeOnly == pesticideFreeOnly));
}


@override
int get hashCode => Object.hash(runtimeType,minRating,minPrice,maxPrice,discountOnly,locallySourcedOnly,pesticideFreeOnly);

@override
String toString() {
  return 'Filters(minRating: $minRating, minPrice: $minPrice, maxPrice: $maxPrice, discountOnly: $discountOnly, locallySourcedOnly: $locallySourcedOnly, pesticideFreeOnly: $pesticideFreeOnly)';
}


}

/// @nodoc
abstract mixin class _$FiltersCopyWith<$Res> implements $FiltersCopyWith<$Res> {
  factory _$FiltersCopyWith(_Filters value, $Res Function(_Filters) _then) = __$FiltersCopyWithImpl;
@override @useResult
$Res call({
 double minRating, double? minPrice, double? maxPrice, bool discountOnly, bool locallySourcedOnly, bool pesticideFreeOnly
});




}
/// @nodoc
class __$FiltersCopyWithImpl<$Res>
    implements _$FiltersCopyWith<$Res> {
  __$FiltersCopyWithImpl(this._self, this._then);

  final _Filters _self;
  final $Res Function(_Filters) _then;

/// Create a copy of Filters
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? minRating = null,Object? minPrice = freezed,Object? maxPrice = freezed,Object? discountOnly = null,Object? locallySourcedOnly = null,Object? pesticideFreeOnly = null,}) {
  return _then(_Filters(
minRating: null == minRating ? _self.minRating : minRating // ignore: cast_nullable_to_non_nullable
as double,minPrice: freezed == minPrice ? _self.minPrice : minPrice // ignore: cast_nullable_to_non_nullable
as double?,maxPrice: freezed == maxPrice ? _self.maxPrice : maxPrice // ignore: cast_nullable_to_non_nullable
as double?,discountOnly: null == discountOnly ? _self.discountOnly : discountOnly // ignore: cast_nullable_to_non_nullable
as bool,locallySourcedOnly: null == locallySourcedOnly ? _self.locallySourcedOnly : locallySourcedOnly // ignore: cast_nullable_to_non_nullable
as bool,pesticideFreeOnly: null == pesticideFreeOnly ? _self.pesticideFreeOnly : pesticideFreeOnly // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
