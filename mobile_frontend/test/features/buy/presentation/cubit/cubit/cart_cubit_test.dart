import 'package:big_cart/features/buy/domain/entities/cart_item.dart';
import 'package:big_cart/features/buy/domain/use_cases/add_to_cart.dart';
import 'package:big_cart/features/buy/domain/use_cases/get_cart_items.dart';
import 'package:big_cart/features/buy/domain/use_cases/remove_from_cart.dart';
import 'package:big_cart/features/buy/domain/use_cases/update_quantity.dart';
import 'package:big_cart/features/buy/presentation/cubit/cubit/cart_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../helpers/test_fixtures.dart';

class MockGetCartItems extends Mock implements GetCartItems {}

class MockAddToCart extends Mock implements AddToCart {}

class MockUpdateQuantity extends Mock implements UpdateQuantity {}

class MockRemoveFromCart extends Mock implements RemoveFromCart {}

void main() {
  late MockGetCartItems getCartItems;
  late MockAddToCart addToCart;
  late MockUpdateQuantity updateQuantity;
  late MockRemoveFromCart removeFromCart;
  late CartCubit cubit;
  final productId = testProduct.id;

  setUpAll(registerAllFallbackValues);

  setUp(() {
    getCartItems = MockGetCartItems();
    addToCart = MockAddToCart();
    updateQuantity = MockUpdateQuantity();
    removeFromCart = MockRemoveFromCart();
    cubit = CartCubit(getCartItems, addToCart, updateQuantity, removeFromCart);
  });

  tearDown(() => cubit.close());

  void cartOnServer(List<CartItem> items) => when(
    () => getCartItems.call(),
  ).thenAnswer((_) async => Right(items));

  test('starts empty and not loaded', () {
    expect(cubit.state, const CartState());
    expect(cubit.state.loaded, isFalse);
  });

  test('load keys the cart by product id and marks it loaded', () async {
    cartOnServer([testCartItem]);

    await cubit.attemptGetCart();

    expect(cubit.state.loaded, isTrue);
    expect(cubit.quantityOf(productId), 2);
  });

  test('adding shows the item at once, then keeps the new row id', () async {
    when(
      () => addToCart.call(any()),
    ).thenAnswer((_) async => const Right('cart_9'));

    final pending = cubit.attemptSetQuantity(testProduct, 1);
    // already there before the server has answered
    expect(cubit.quantityOf(productId), 1);

    await pending;
    expect(cubit.state.items[productId]?.id, 'cart_9');
    expect(cubit.state.error, isNull);
  });

  test('changing the quantity is instant and one request', () async {
    cartOnServer([testCartItem]);
    await cubit.attemptGetCart();
    when(
      () => updateQuantity.call(any(), any()),
    ).thenAnswer((_) async => const Right(unit));

    final pending = cubit.attemptSetQuantity(testProduct, 5);
    expect(cubit.quantityOf(productId), 5);
    await pending;

    verify(() => updateQuantity.call(testCartItem, 5)).called(1);
  });

  test('a refused change sets the error and puts the real cart back', () async {
    cartOnServer([testCartItem]);
    await cubit.attemptGetCart();
    when(
      () => updateQuantity.call(any(), any()),
    ).thenAnswer((_) async => Left(DummyFailure('Out of stock')));
    final states = <CartState>[];
    final sub = cubit.stream.listen(states.add);

    await cubit.attemptSetQuantity(testProduct, 5);
    await pumpEventQueue();
    await sub.cancel();

    expect(states.map((s) => s.error), contains('Out of stock'));
    expect(cubit.quantityOf(productId), 2);
  });

  test('zero removes the item at once', () async {
    cartOnServer([testCartItem]);
    await cubit.attemptGetCart();
    when(
      () => removeFromCart.call(any()),
    ).thenAnswer((_) async => const Right(unit));

    final pending = cubit.attemptSetQuantity(testProduct, 0);
    expect(cubit.state.items.containsKey(productId), isFalse);
    await pending;
  });

  test('taps while an add is in flight are ignored', () async {
    when(
      () => addToCart.call(any()),
    ).thenAnswer((_) async => const Right('cart_9'));

    final adding = cubit.attemptSetQuantity(testProduct, 1);
    await cubit.attemptSetQuantity(testProduct, 2);
    await adding;

    verifyNever(() => updateQuantity.call(any(), any()));
    expect(cubit.quantityOf(productId), 1);
  });
}
