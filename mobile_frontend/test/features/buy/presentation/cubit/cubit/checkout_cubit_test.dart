import 'package:big_cart/features/buy/domain/use_cases/check_out.dart';
import 'package:big_cart/features/buy/presentation/cubit/cubit/checkout_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../helpers/test_fixtures.dart';

class MockCheckOut extends Mock implements CheckOut {}

void main() {
  late MockCheckOut checkOut;

  setUpAll(registerAllFallbackValues);

  setUp(() => checkOut = MockCheckOut());

  blocTest<CheckoutCubit, CheckoutState>(
    'places the order and hands back the order with its new id',
    build: () {
      when(
        () => checkOut.call(any()),
      ).thenAnswer((_) async => const Right('42'));
      return CheckoutCubit(checkOut);
    },
    act: (cubit) => cubit.attemptCheckOut(testOrder),
    expect: () => [
      const CheckoutState.placing(),
      CheckoutState.orderPlaced(testOrder.copyWith(id: '42')),
    ],
  );

  blocTest<CheckoutCubit, CheckoutState>(
    'emits the error when the order is refused',
    build: () {
      when(
        () => checkOut.call(any()),
      ).thenAnswer((_) async => Left(DummyFailure('Payment declined')));
      return CheckoutCubit(checkOut);
    },
    act: (cubit) => cubit.attemptCheckOut(testOrder),
    expect: () => [
      const CheckoutState.placing(),
      const CheckoutState.error('Payment declined'),
    ],
  );

  blocTest<CheckoutCubit, CheckoutState>(
    'ignores a second tap while the order is being placed',
    build: () => CheckoutCubit(checkOut),
    seed: () => const CheckoutState.placing(),
    act: (cubit) => cubit.attemptCheckOut(testOrder),
    expect: () => [],
    verify: (_) => verifyNever(() => checkOut.call(any())),
  );
}
