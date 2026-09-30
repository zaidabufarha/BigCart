import 'package:big_cart/features/account/domain/entities/transaction.dart';

/// The card's brand, read off its number like the web client: Visa numbers
/// start with 4, anything else counts as Mastercard. Lenient on purpose, so
/// a made-up test number is never refused for its brand.
PaymentProcessor brandFromCardNumber(String number) =>
    number.replaceAll(' ', '').startsWith('4')
    ? PaymentProcessor.visa
    : PaymentProcessor.mastercard;
