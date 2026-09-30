import 'package:big_cart/features/buy/domain/entities/cart_item.dart';
import 'package:big_cart/features/buy/domain/use_cases/get_cart_items.dart';
import 'package:big_cart/features/buy/domain/use_cases/toggle_favorite.dart';
import 'package:big_cart/features/buy/presentation/cubit/cubit/favorites_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../helpers/test_fixtures.dart';

class MockGetCartItems extends Mock implements GetCartItems {}

class MockToggleFavorite extends Mock implements ToggleFavorite {}

void main() {
  late MockGetCartItems getCartItems;
  late MockToggleFavorite toggleFavorite;
  late FavoritesCubit cubit;

  setUpAll(registerAllFallbackValues);

  setUp(() {
    getCartItems = MockGetCartItems();
    toggleFavorite = MockToggleFavorite();
    cubit = FavoritesCubit(getCartItems, toggleFavorite);
  });

  tearDown(() => cubit.close());

  void favoritesOnServer(List<CartItem> items) => when(
    () => getCartItems.call(isFavorites: true),
  ).thenAnswer((_) async => Right(items));

  test("before loading, a product's own flag decides", () {
    expect(cubit.isFavorite(testProduct.copyWith(isFavorite: true)), isTrue);
    expect(cubit.isFavorite(testProduct), isFalse);
  });

  test('load fills the favorites and then decides every heart', () async {
    favoritesOnServer([CartItem(testProduct, 1)]);

    await cubit.attemptGetFavorites();

    expect(cubit.state.loaded, isTrue);
    expect(cubit.isFavorite(testProduct), isTrue);
  });

  test('a heart flips at once', () async {
    favoritesOnServer([]);
    await cubit.attemptGetFavorites();
    when(
      () => toggleFavorite.call(any(), any()),
    ).thenAnswer((_) async => const Right(unit));

    final pending = cubit.attemptToggleFavorite(testProduct);
    expect(cubit.isFavorite(testProduct), isTrue);
    await pending;

    verify(() => toggleFavorite.call(testProduct.id, true)).called(1);
    expect(cubit.state.error, isNull);
  });

  test('a refused toggle flips back and sets the error', () async {
    favoritesOnServer([CartItem(testProduct, 1)]);
    await cubit.attemptGetFavorites();
    when(
      () => toggleFavorite.call(any(), any()),
    ).thenAnswer((_) async => Left(DummyFailure('Try again')));

    await cubit.attemptToggleFavorite(testProduct);

    expect(cubit.isFavorite(testProduct), isTrue);
    expect(cubit.state.error, 'Try again');
  });
}
