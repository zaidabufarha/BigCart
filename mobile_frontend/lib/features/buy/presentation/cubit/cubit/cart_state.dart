part of 'cart_cubit.dart';

@freezed
abstract class CartState with _$CartState {
  const factory CartState({
    /// What's in the cart, by product id.
    @Default({}) Map<String, CartItem> items,

    /// False until the first load, so "empty" and "not fetched yet" differ.
    @Default(false) bool loaded,

    /// Set when the server refused a change (the cart is already put back);
    /// the shell shows it. Cleared by the next change.
    String? error,
  }) = _CartState;
}
