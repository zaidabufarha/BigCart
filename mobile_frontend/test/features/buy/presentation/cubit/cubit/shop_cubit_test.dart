import 'package:big_cart/features/buy/domain/use_cases/get_category_list.dart';
import 'package:big_cart/features/buy/domain/use_cases/get_product_list.dart';
import 'package:big_cart/features/buy/domain/use_cases/toggle_favorite.dart';
import 'package:big_cart/features/buy/presentation/cubit/cubit/shop_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../helpers/test_fixtures.dart';

class MockGetCategoryList extends Mock implements GetCategoryList {}

class MockGetProductList extends Mock implements GetProductList {}

class MockToggleFavorite extends Mock implements ToggleFavorite {}

void main() {
  late MockGetCategoryList mockGetCategoryList;
  late MockGetProductList mockGetProductList;
  late MockToggleFavorite mockToggleFavorite;
  late ShopCubit shopCubit;

  setUpAll(() {
    registerAllFallbackValues();
  });

  setUp(() {
    mockGetCategoryList = MockGetCategoryList();
    mockGetProductList = MockGetProductList();
    mockToggleFavorite = MockToggleFavorite();

    shopCubit = ShopCubit(
      mockGetCategoryList,
      mockGetProductList,
      mockToggleFavorite,
    );
  });

  tearDown(() {
    shopCubit.close();
  });

  test('initial state is ShopState.initial()', () {
    expect(shopCubit.state, const ShopState.initial());
  });

  group('attemptGetCategoryList', () {
    blocTest<ShopCubit, ShopState>(
      'emits [loading, loadedCategories] on success',
      build: () {
        when(
          () => mockGetCategoryList.call(),
        ).thenAnswer((_) async => Right([testCategory]));
        return shopCubit;
      },
      act: (cubit) => cubit.attemptGetCategoryList(),
      expect: () => [
        const ShopState.loading(),
        ShopState.loadedCategories([testCategory]),
      ],
      verify: (_) {
        verify(() => mockGetCategoryList.call()).called(1);
      },
    );

    blocTest<ShopCubit, ShopState>(
      'emits [loading, error] on failure',
      build: () {
        when(
          () => mockGetCategoryList.call(),
        ).thenAnswer((_) async => Left(DummyFailure('Categories error')));
        return shopCubit;
      },
      act: (cubit) => cubit.attemptGetCategoryList(),
      expect: () => [
        const ShopState.loading(),
        const ShopState.error('Categories error'),
      ],
    );
  });

  group('attemptGetProductList', () {
    blocTest<ShopCubit, ShopState>(
      'emits [loading, loadedProducts] on success',
      build: () {
        when(
          () => mockGetProductList.call(),
        ).thenAnswer((_) async => Right([testProduct]));
        return shopCubit;
      },
      act: (cubit) => cubit.attemptGetProductList(),
      expect: () => [
        const ShopState.loading(),
        ShopState.loadedProducts([testProduct]),
      ],
      verify: (_) {
        verify(() => mockGetProductList.call()).called(1);
      },
    );

    blocTest<ShopCubit, ShopState>(
      'emits [loading, error] on failure',
      build: () {
        when(
          () => mockGetProductList.call(),
        ).thenAnswer((_) async => Left(DummyFailure('Products error')));
        return shopCubit;
      },
      act: (cubit) => cubit.attemptGetProductList(),
      expect: () => [
        const ShopState.loading(),
        const ShopState.error('Products error'),
      ],
    );
  });

  group('attemptToggleFavorite', () {
    blocTest<ShopCubit, ShopState>(
      'emits [ShopState.success("Added to favorites")] on success when isFavorite is true without loading',
      build: () {
        when(
          () => mockToggleFavorite.call(any(), true),
        ).thenAnswer((_) async => const Right(unit));
        return shopCubit;
      },
      act: (cubit) => cubit.attemptToggleFavorite('prod_1', true),
      expect: () => [const ShopState.success('Added to favorites')],
      verify: (_) {
        verify(() => mockToggleFavorite.call('prod_1', true)).called(1);
      },
    );

    blocTest<ShopCubit, ShopState>(
      'emits [ShopState.success("Removed from favorites")] on success when isFavorite is false without loading',
      build: () {
        when(
          () => mockToggleFavorite.call(any(), false),
        ).thenAnswer((_) async => const Right(unit));
        return shopCubit;
      },
      act: (cubit) => cubit.attemptToggleFavorite('prod_1', false),
      expect: () => [const ShopState.success('Removed from favorites')],
      verify: (_) {
        verify(() => mockToggleFavorite.call('prod_1', false)).called(1);
      },
    );

    blocTest<ShopCubit, ShopState>(
      'emits [ShopState.error(message)] on failure without loading',
      build: () {
        when(
          () => mockToggleFavorite.call(any(), any()),
        ).thenAnswer((_) async => Left(DummyFailure('Toggle favorite error')));
        return shopCubit;
      },
      act: (cubit) => cubit.attemptToggleFavorite('prod_1', true),
      expect: () => [const ShopState.error('Toggle favorite error')],
    );
  });
}
