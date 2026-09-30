// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Product {

 String get id; String get name; String get imagePath; String get amount; String get description; double get discount; double get price; bool get isNew; bool get isFavorite; Category get category; Color get color;// the average of its reviews, kept up to date by the backend
 double get rating; bool get locallySourced; bool get pesticideFree;
/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductCopyWith<Product> get copyWith => _$ProductCopyWithImpl<Product>(this as Product, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Product&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.description, description) || other.description == description)&&(identical(other.discount, discount) || other.discount == discount)&&(identical(other.price, price) || other.price == price)&&(identical(other.isNew, isNew) || other.isNew == isNew)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&(identical(other.category, category) || other.category == category)&&(identical(other.color, color) || other.color == color)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.locallySourced, locallySourced) || other.locallySourced == locallySourced)&&(identical(other.pesticideFree, pesticideFree) || other.pesticideFree == pesticideFree));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,imagePath,amount,description,discount,price,isNew,isFavorite,category,color,rating,locallySourced,pesticideFree);

@override
String toString() {
  return 'Product(id: $id, name: $name, imagePath: $imagePath, amount: $amount, description: $description, discount: $discount, price: $price, isNew: $isNew, isFavorite: $isFavorite, category: $category, color: $color, rating: $rating, locallySourced: $locallySourced, pesticideFree: $pesticideFree)';
}


}

/// @nodoc
abstract mixin class $ProductCopyWith<$Res>  {
  factory $ProductCopyWith(Product value, $Res Function(Product) _then) = _$ProductCopyWithImpl;
@useResult
$Res call({
 String id, String name, String imagePath, String amount, String description, double discount, double price, bool isNew, bool isFavorite, Category category, Color color, double rating, bool locallySourced, bool pesticideFree
});


$CategoryCopyWith<$Res> get category;

}
/// @nodoc
class _$ProductCopyWithImpl<$Res>
    implements $ProductCopyWith<$Res> {
  _$ProductCopyWithImpl(this._self, this._then);

  final Product _self;
  final $Res Function(Product) _then;

/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? imagePath = null,Object? amount = null,Object? description = null,Object? discount = null,Object? price = null,Object? isNew = null,Object? isFavorite = null,Object? category = null,Object? color = null,Object? rating = null,Object? locallySourced = null,Object? pesticideFree = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,imagePath: null == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,discount: null == discount ? _self.discount : discount // ignore: cast_nullable_to_non_nullable
as double,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,isNew: null == isNew ? _self.isNew : isNew // ignore: cast_nullable_to_non_nullable
as bool,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as Category,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as Color,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,locallySourced: null == locallySourced ? _self.locallySourced : locallySourced // ignore: cast_nullable_to_non_nullable
as bool,pesticideFree: null == pesticideFree ? _self.pesticideFree : pesticideFree // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CategoryCopyWith<$Res> get category {
  
  return $CategoryCopyWith<$Res>(_self.category, (value) {
    return _then(_self.copyWith(category: value));
  });
}
}


/// Adds pattern-matching-related methods to [Product].
extension ProductPatterns on Product {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Product value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Product() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Product value)  $default,){
final _that = this;
switch (_that) {
case _Product():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Product value)?  $default,){
final _that = this;
switch (_that) {
case _Product() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String imagePath,  String amount,  String description,  double discount,  double price,  bool isNew,  bool isFavorite,  Category category,  Color color,  double rating,  bool locallySourced,  bool pesticideFree)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Product() when $default != null:
return $default(_that.id,_that.name,_that.imagePath,_that.amount,_that.description,_that.discount,_that.price,_that.isNew,_that.isFavorite,_that.category,_that.color,_that.rating,_that.locallySourced,_that.pesticideFree);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String imagePath,  String amount,  String description,  double discount,  double price,  bool isNew,  bool isFavorite,  Category category,  Color color,  double rating,  bool locallySourced,  bool pesticideFree)  $default,) {final _that = this;
switch (_that) {
case _Product():
return $default(_that.id,_that.name,_that.imagePath,_that.amount,_that.description,_that.discount,_that.price,_that.isNew,_that.isFavorite,_that.category,_that.color,_that.rating,_that.locallySourced,_that.pesticideFree);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String imagePath,  String amount,  String description,  double discount,  double price,  bool isNew,  bool isFavorite,  Category category,  Color color,  double rating,  bool locallySourced,  bool pesticideFree)?  $default,) {final _that = this;
switch (_that) {
case _Product() when $default != null:
return $default(_that.id,_that.name,_that.imagePath,_that.amount,_that.description,_that.discount,_that.price,_that.isNew,_that.isFavorite,_that.category,_that.color,_that.rating,_that.locallySourced,_that.pesticideFree);case _:
  return null;

}
}

}

/// @nodoc


class _Product implements Product {
  const _Product({required this.id, required this.name, required this.imagePath, required this.amount, required this.description, required this.discount, required this.price, required this.isNew, this.isFavorite = false, required this.category, required this.color, this.rating = 0, this.locallySourced = false, this.pesticideFree = false});
  

@override final  String id;
@override final  String name;
@override final  String imagePath;
@override final  String amount;
@override final  String description;
@override final  double discount;
@override final  double price;
@override final  bool isNew;
@override@JsonKey() final  bool isFavorite;
@override final  Category category;
@override final  Color color;
// the average of its reviews, kept up to date by the backend
@override@JsonKey() final  double rating;
@override@JsonKey() final  bool locallySourced;
@override@JsonKey() final  bool pesticideFree;

/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductCopyWith<_Product> get copyWith => __$ProductCopyWithImpl<_Product>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Product&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.description, description) || other.description == description)&&(identical(other.discount, discount) || other.discount == discount)&&(identical(other.price, price) || other.price == price)&&(identical(other.isNew, isNew) || other.isNew == isNew)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&(identical(other.category, category) || other.category == category)&&(identical(other.color, color) || other.color == color)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.locallySourced, locallySourced) || other.locallySourced == locallySourced)&&(identical(other.pesticideFree, pesticideFree) || other.pesticideFree == pesticideFree));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,imagePath,amount,description,discount,price,isNew,isFavorite,category,color,rating,locallySourced,pesticideFree);

@override
String toString() {
  return 'Product(id: $id, name: $name, imagePath: $imagePath, amount: $amount, description: $description, discount: $discount, price: $price, isNew: $isNew, isFavorite: $isFavorite, category: $category, color: $color, rating: $rating, locallySourced: $locallySourced, pesticideFree: $pesticideFree)';
}


}

/// @nodoc
abstract mixin class _$ProductCopyWith<$Res> implements $ProductCopyWith<$Res> {
  factory _$ProductCopyWith(_Product value, $Res Function(_Product) _then) = __$ProductCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String imagePath, String amount, String description, double discount, double price, bool isNew, bool isFavorite, Category category, Color color, double rating, bool locallySourced, bool pesticideFree
});


@override $CategoryCopyWith<$Res> get category;

}
/// @nodoc
class __$ProductCopyWithImpl<$Res>
    implements _$ProductCopyWith<$Res> {
  __$ProductCopyWithImpl(this._self, this._then);

  final _Product _self;
  final $Res Function(_Product) _then;

/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? imagePath = null,Object? amount = null,Object? description = null,Object? discount = null,Object? price = null,Object? isNew = null,Object? isFavorite = null,Object? category = null,Object? color = null,Object? rating = null,Object? locallySourced = null,Object? pesticideFree = null,}) {
  return _then(_Product(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,imagePath: null == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,discount: null == discount ? _self.discount : discount // ignore: cast_nullable_to_non_nullable
as double,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,isNew: null == isNew ? _self.isNew : isNew // ignore: cast_nullable_to_non_nullable
as bool,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as Category,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as Color,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,locallySourced: null == locallySourced ? _self.locallySourced : locallySourced // ignore: cast_nullable_to_non_nullable
as bool,pesticideFree: null == pesticideFree ? _self.pesticideFree : pesticideFree // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CategoryCopyWith<$Res> get category {
  
  return $CategoryCopyWith<$Res>(_self.category, (value) {
    return _then(_self.copyWith(category: value));
  });
}
}

// dart format on
