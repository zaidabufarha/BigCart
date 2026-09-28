import 'package:big_cart/core/graphql/fragments.graphql.dart';
import 'package:big_cart/features/account/domain/entities/address.dart';
import 'package:big_cart/features/account/domain/entities/credit_card.dart';
import 'package:big_cart/features/account/domain/entities/order.dart';
import 'package:big_cart/features/account/domain/entities/transaction.dart';
import 'package:big_cart/features/account/domain/entities/user.dart';
import 'package:big_cart/features/buy/domain/entities/cart_item.dart';
import 'package:big_cart/features/buy/domain/entities/category.dart';
import 'package:big_cart/features/buy/domain/entities/product.dart';
import 'package:big_cart/features/buy/domain/entities/review.dart';
import 'package:flutter/material.dart';

// Generated GraphQL types → domain entities. One mapper per fragment, so any
// query that spreads a fragment maps the same way (a cart's product and an
// order's product are both Fragment$ProductFields).

/// Colours arrive as strings like "0xFFE6F2EA".
Color parseColor(String value) => Color(int.tryParse(value) ?? 0xFF4CAF50);

/// Card brands and payment methods arrive as plain strings.
PaymentProcessor parseProcessor(String value) {
  final lower = value.toLowerCase();
  if (lower.contains('visa')) return PaymentProcessor.visa;
  if (lower.contains('paypal')) return PaymentProcessor.paypal;
  return PaymentProcessor.mastercard;
}

DateTime? _parseDate(String? value) =>
    value == null ? null : DateTime.tryParse(value);

// the schema allows these to be missing; the UI always needs something
const _noCategory = Category(name: '', imagePath: '', color: Colors.green);
const _noAddress = Address(
  name: '',
  street: '',
  city: '',
  country: '',
  phone: '',
  zipCode: '',
);
const _noCard = CreditCard(
  cardHolderName: '',
  last4: '',
  expiryDate: '',
  processor: PaymentProcessor.mastercard,
);

extension CategoryFieldsMapper on Fragment$CategoryFields {
  Category toEntity() =>
      Category(name: name, imagePath: image_path, color: parseColor(color));
}

extension ProductFieldsMapper on Fragment$ProductFields {
  Product toEntity() => Product(
    id: id,
    name: name,
    imagePath: image_path,
    amount: amount,
    description: description,
    discount: discount,
    price: price,
    isNew: is_new,
    isFavorite: is_favorite,
    rating: rating,
    freeShipping: free_shipping,
    sameDayDelivery: same_day_delivery,
    category: category?.toEntity() ?? _noCategory,
    color: parseColor(color),
  );
}

extension ReviewFieldsMapper on Fragment$ReviewFields {
  Review toEntity() {
    final author = user;
    return Review(
      // reviews only carry the author's name and picture
      user: author == null
          ? const User(name: '', email: '', phone: '')
          : User(
              name: author.name,
              email: '',
              phone: '',
              imagePath: author.image_path,
            ),
      comment: comment,
      rating: rating,
      createdAt: DateTime.parse(created_at),
    );
  }
}

extension UserFieldsMapper on Fragment$UserFields {
  User toEntity() =>
      User(name: name, email: email, phone: phone, imagePath: image_path);
}

extension AddressFieldsMapper on Fragment$AddressFields {
  Address toEntity({bool isDefault = false}) => Address(
    id: id,
    name: name,
    street: street,
    city: city,
    country: country,
    phone: phone,
    zipCode: zip_code,
    isDefault: isDefault,
  );
}

extension CardFieldsMapper on Fragment$CardFields {
  CreditCard toEntity({bool isDefault = false}) => CreditCard(
    id: id,
    cardHolderName: card_holder_name,
    last4: last4,
    expiryDate: expiry_date,
    processor: parseProcessor(processor),
    isDefault: isDefault,
  );
}

extension OrderFieldsMapper on Fragment$OrderFields {
  Order toEntity() => Order(
    id: id,
    orderItem: [
      for (final item in order_item)
        CartItem(item.product.toEntity(), item.quantity),
    ],
    address: address?.toEntity() ?? _noAddress,
    creditCard: credit_card?.toEntity() ?? _noCard,
    shippingMethod: shipping_method,
    datePlaced: DateTime.parse(date_placed),
    dateConfirmed: _parseDate(date_confirmed),
    dateShipped: _parseDate(date_shipped),
    dateOutForDelivery: _parseDate(date_out_for_delivery),
    dateDelivered: _parseDate(date_delivered),
  );
}

extension TransactionFieldsMapper on Fragment$TransactionFields {
  Transaction toEntity() => Transaction(
    amount: amount,
    createdAt: DateTime.parse(created_at),
    paymentMethod: parseProcessor(payment_method),
  );
}
