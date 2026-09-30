import 'package:big_cart/core/error/failure.dart';
import 'package:big_cart/features/buy/domain/entities/cart_item.dart';
import 'package:big_cart/features/buy/domain/entities/product.dart';
import 'package:big_cart/features/buy/domain/use_cases/add_to_cart.dart';
import 'package:big_cart/features/buy/domain/use_cases/get_cart_items.dart';
import 'package:big_cart/features/buy/domain/use_cases/remove_from_cart.dart';
import 'package:big_cart/features/buy/domain/use_cases/update_quantity.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'cart_state.dart';
part 'cart_cubit.freezed.dart';

/// The cart, for every screen that shows or changes it: product cards, the
/// product page and the cart page. Changes are optimistic like the web
/// client's: the number moves at once, and a refused change puts the real
/// cart back and sets [CartState.error].
@injectable
class CartCubit extends Cubit<CartState> {
  CartCubit(
    this.getCartItems,
    this.addToCart,
    this.updateQuantity,
    this.removeFromCart,
  ) : super(const CartState());
  final GetCartItems getCartItems;
  final AddToCart addToCart;
  final UpdateQuantity updateQuantity;
  final RemoveFromCart removeFromCart;

  // Not named 'attempt' because there's no server communication.
  int quantityOf(String productId) => state.items[productId]?.quantity ?? 0;

  Future<void> attemptGetCart() async {
    final result = await getCartItems.call();
    result.fold(
      (failure) => emit(state.copyWith(error: failure.message)),
      (items) => emit(
        CartState(
          items: {for (final item in items) item.product.id: item},
          loaded: true,
        ),
      ),
    );
  }

  /// Sets how many of [product] are in the cart; 0 removes it.
  Future<void> attemptSetQuantity(Product product, int next) async {
    final current = state.items[product.id];
    // still being added: nothing to update until its id comes back
    if (current != null && current.id == null) return;
    if (current == null) {
      if (next <= 0) return;
      _put(product.id, CartItem(product, next));
      final result = await addToCart.call(CartItem(product, next));
      result.fold(
        _revert,
        // the new row's id, so the next tap updates it directly
        (id) => _put(product.id, CartItem(product, next, id: id)),
      );
    } else if (next <= 0) {
      emit(
        state.copyWith(
          items: Map.of(state.items)..remove(product.id),
          error: null,
        ),
      );
      final result = await removeFromCart.call(current);
      result.fold(_revert, (_) {});
    } else {
      _put(product.id, current.copyWith(quantity: next));
      final result = await updateQuantity.call(current, next);
      result.fold(_revert, (_) {});
    }
  }

  void _put(String productId, CartItem item) => emit(
    state.copyWith(items: {...state.items, productId: item}, error: null),
  );

  // say why, then show the cart as the server really has it
  void _revert(Failure failure) {
    emit(state.copyWith(error: failure.message));
    attemptGetCart();
  }
}
