import 'package:big_cart/features/account/domain/entities/order.dart';
import 'package:big_cart/features/buy/domain/use_cases/check_out.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart' hide Order;

part 'checkout_state.dart';
part 'checkout_cubit.freezed.dart';

/// Places the order at the end of checkout. What's in the cart is CartCubit.
@injectable
class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit(this.checkOut) : super(const CheckoutState.initial());
  final CheckOut checkOut;

  Future<void> attemptCheckOut(Order order) async {
    if (state is _Placing) return;
    emit(const CheckoutState.placing());
    final result = await checkOut.call(order);
    result.fold(
      (failure) => emit(CheckoutState.error(failure.message)),
      // the order now carries its real id, for Track order
      (orderId) => emit(CheckoutState.orderPlaced(order.copyWith(id: orderId))),
    );
  }
}
