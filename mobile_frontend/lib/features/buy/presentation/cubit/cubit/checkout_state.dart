part of 'checkout_cubit.dart';

@freezed
class CheckoutState with _$CheckoutState {
  const factory CheckoutState.initial() = _Initial;
  const factory CheckoutState.placing() = _Placing;
  const factory CheckoutState.orderPlaced(Order order) = _OrderPlaced;
  const factory CheckoutState.error(String message) = _Error;
}
