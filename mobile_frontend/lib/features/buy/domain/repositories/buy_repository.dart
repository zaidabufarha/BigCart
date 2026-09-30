import 'package:big_cart/core/error/failure.dart';
import 'package:big_cart/features/account/domain/entities/order.dart';
import 'package:big_cart/features/buy/domain/entities/cart_item.dart';
import 'package:big_cart/features/buy/domain/entities/category.dart';
import 'package:big_cart/features/buy/domain/entities/product.dart';
import 'package:big_cart/features/buy/domain/entities/review.dart';
import 'package:dartz/dartz.dart' hide Order;

abstract class BuyRepository {
  Future<Either<Failure, List<Category>>> getCategoryList();
  Future<Either<Failure, List<Product>>> getProductList();
  Future<Either<Failure, List<Review>>> getProductReviews(String id);
  Future<Either<Failure, List<CartItem>>> getCartItems({
    bool isFavorites = false,
  });

  /// Adds the item; on success, its new cart row id.
  Future<Either<Failure, String>> addToCart(CartItem item);
  Future<Either<Failure, Unit>> addReview(String id, Review review);

  /// Places the order; on success, the new order's id.
  Future<Either<Failure, String>> checkOut(Order order);
  Future<Either<Failure, Unit>> toggleFavorite(String id, bool isFavorite);
  Future<Either<Failure, Unit>> updateQuantity(
    CartItem cart,
    int newQuantity,
  );
  Future<Either<Failure, Unit>> removeFromCart(CartItem item);

  // Kept on the device only and cleared on sign-out; nothing to fail on
  Future<List<String>> getSearchHistory();
  Future<void> saveSearchHistory(List<String> history);
}
