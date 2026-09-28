import 'package:big_cart/features/buy/domain/entities/category.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';

@freezed
abstract class Product with _$Product {
  const factory Product({
    required String id,
    required String name,
    required String imagePath,
    required String amount,
    required String description,
    required double discount,
    required double price,
    required bool isNew,
    @Default(false) bool isFavorite,
    required Category category,
    required Color color,
    // the average of its reviews, kept up to date by the backend
    @Default(0) double rating,
    @Default(false) bool sameDayDelivery,
    @Default(false) bool freeShipping,
  }) = _Product;
}
