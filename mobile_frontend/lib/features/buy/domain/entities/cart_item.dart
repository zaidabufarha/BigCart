import 'package:big_cart/features/buy/domain/entities/product.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_item.freezed.dart';

@freezed
abstract class CartItem with _$CartItem {
  // id is the cart row's own id, so updating or removing it is one request.
  // Favorites and order lines reuse CartItem and have none.
  const factory CartItem(Product product, int quantity, {String? id}) =
      _CartItem;
}
