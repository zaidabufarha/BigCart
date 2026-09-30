import 'package:big_cart/core/api/api.dart';
import 'package:big_cart/core/error/exception.dart';
import 'package:big_cart/core/graphql/mappers.dart';
import 'package:big_cart/core/graphql/schema.graphql.dart';
import 'package:big_cart/core/session/user_local_data_source.dart';
import 'package:big_cart/features/account/data/graphql/account.graphql.dart';
import 'package:big_cart/features/account/domain/entities/order.dart';
import 'package:big_cart/features/buy/data/graphql/buy.graphql.dart';
import 'package:big_cart/features/buy/domain/entities/cart_item.dart';
import 'package:big_cart/features/buy/domain/entities/category.dart';
import 'package:big_cart/features/buy/domain/entities/product.dart';
import 'package:big_cart/features/buy/domain/entities/review.dart';
import 'package:dartz/dartz.dart' hide Order;
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart' hide Order;

abstract class BuyRemoteDataSource {
  Future<List<Category>> getCategoryList();
  Future<List<Product>> getProductList();
  Future<List<Review>> getProductReviews(String id);
  Future<List<CartItem>> getCartItems({bool isFavorites = false});

  /// Adds the item and returns its new cart row id.
  Future<String> addToCart(CartItem item);
  Future<Unit> addReview(String id, Review review);

  /// Places the order and returns its new id.
  Future<String> checkOut(Order order);
  Future<Unit> toggleFavorite(String id, bool isFavorite);
  Future<Unit> updateQuantity(CartItem item, int newQuantity);
  Future<Unit> removeFromCart(CartItem item);
}

@LazySingleton(as: BuyRemoteDataSource)
class BuyRemoteDataSourceImpl implements BuyRemoteDataSource {
  final ApiConsumer apiConsumer;
  final UserLocalDataSource userLocalDataSource;

  BuyRemoteDataSourceImpl({
    required this.apiConsumer,
    required this.userLocalDataSource,
  });

  @override
  Future<Unit> addReview(String id, Review review) async {
    try {
      await apiConsumer.request(
        documentNodeMutationAddReview,
        variables: Variables$Mutation$AddReview(
          productId: id,
          rating: review.rating,
          comment: review.comment,
        ).toJson(),
      );
      return unit;
    } on DioException {
      throw NoInternetException();
    }
  }

  @override
  Future<String> addToCart(CartItem item) async {
    try {
      final data = await apiConsumer.request(
        documentNodeMutationAddToCart,
        variables: Variables$Mutation$AddToCart(
          productId: item.product.id,
          quantity: item.quantity,
        ).toJson(),
      );
      return Mutation$AddToCart.fromJson(data).addToCart.id;
    } on DioException {
      throw NoInternetException();
    }
  }

  @override
  Future<String> checkOut(Order order) async {
    try {
      // an address or card typed in at checkout is saved first, for its id
      String? addressId = order.address.id;
      if (addressId == null || addressId.isEmpty) {
        final address = order.address;
        final data = await apiConsumer.request(
          documentNodeMutationAddAddress,
          variables: Variables$Mutation$AddAddress(
            input: Input$AddressInput(
              name: address.name,
              street: address.street,
              city: address.city,
              zip_code: address.zipCode,
              country: address.country,
              phone: address.phone,
              is_default: address.isDefault,
            ),
          ).toJson(),
        );
        addressId = Mutation$AddAddress.fromJson(data).addAddress.id;
      }

      String? cardId = order.creditCard.id;
      if (cardId == null || cardId.isEmpty) {
        final card = order.creditCard;
        final data = await apiConsumer.request(
          documentNodeMutationAddCard,
          variables: Variables$Mutation$AddCard(
            input: Input$CardInput(
              card_holder_name: card.cardHolderName,
              last4: card.last4,
              expiry_date: card.expiryDate,
              processor: card.processor.name,
              is_default: card.isDefault,
            ),
          ).toJson(),
        );
        cardId = Mutation$AddCard.fromJson(data).addCard.id;
      }

      final data = await apiConsumer.request(
        documentNodeMutationCreateOrder,
        variables: Variables$Mutation$CreateOrder(
          addressId: addressId,
          cardId: cardId,
          shippingMethod: order.shippingMethod,
        ).toJson(),
      );
      return Mutation$CreateOrder.fromJson(data).createOrder.id;
    } on DioException {
      throw NoInternetException();
    }
  }

  @override
  Future<List<CartItem>> getCartItems({bool isFavorites = false}) async {
    try {
      if (isFavorites) {
        final data = await apiConsumer.request(documentNodeQueryGetFavorites);
        return [
          for (final product in Query$GetFavorites.fromJson(data).me.favorite)
            CartItem(product.toEntity().copyWith(isFavorite: true), 1),
        ];
      }
      final data = await apiConsumer.request(documentNodeQueryGetCart);
      return [
        for (final item in Query$GetCart.fromJson(data).cart)
          CartItem(item.product.toEntity(), item.quantity, id: item.id),
      ];
    } on DioException {
      throw NoInternetException();
    }
  }

  @override
  Future<List<Category>> getCategoryList() async {
    try {
      final data = await apiConsumer.request(documentNodeQueryGetCategories);
      final categories = Query$GetCategories.fromJson(data).categories;
      if (categories.isEmpty) {
        throw NoDataException();
      }
      return categories.map((c) => c.toEntity()).toList();
    } on DioException {
      throw NoInternetException();
    }
  }

  @override
  Future<List<Product>> getProductList() async {
    try {
      final data = await apiConsumer.request(documentNodeQueryGetProducts);
      final products = Query$GetProducts.fromJson(data).products;
      if (products.isEmpty) {
        throw NoDataException();
      }
      return products.map((p) => p.toEntity()).toList();
    } on DioException {
      throw NoInternetException();
    }
  }

  @override
  Future<List<Review>> getProductReviews(String id) async {
    try {
      final data = await apiConsumer.request(
        documentNodeQueryGetProductReviews,
        variables: Variables$Query$GetProductReviews(productId: id).toJson(),
      );
      return Query$GetProductReviews.fromJson(
        data,
      ).productReviews.map((r) => r.toEntity()).toList();
    } on DioException {
      throw NoInternetException();
    }
  }

  @override
  Future<Unit> removeFromCart(CartItem item) async {
    try {
      await apiConsumer.request(
        documentNodeMutationRemoveFromCart,
        variables: Variables$Mutation$RemoveFromCart(
          id: _cartItemId(item),
        ).toJson(),
      );
      return unit;
    } on DioException {
      throw NoInternetException();
    }
  }

  @override
  Future<Unit> toggleFavorite(String id, bool isFavorite) async {
    try {
      await apiConsumer.request(
        documentNodeMutationToggleFavorite,
        variables: Variables$Mutation$ToggleFavorite(productId: id).toJson(),
      );
      return unit;
    } on DioException {
      throw NoInternetException();
    }
  }

  @override
  Future<Unit> updateQuantity(CartItem item, int newQuantity) async {
    try {
      await apiConsumer.request(
        documentNodeMutationUpdateCartItem,
        variables: Variables$Mutation$UpdateCartItem(
          id: _cartItemId(item),
          quantity: newQuantity,
        ).toJson(),
      );
      return unit;
    } on DioException {
      throw NoInternetException();
    }
  }

  // Cart items come from GetCart with their row id, so there's nothing to
  // look up. Only favorites and order lines lack one, and they never get here.
  String _cartItemId(CartItem item) {
    final id = item.id;
    if (id == null) {
      throw ServerException('This item is not in your cart.');
    }
    return id;
  }
}
