import 'package:big_cart/features/buy/domain/use_cases/get_category_list.dart';
import 'package:big_cart/features/buy/domain/use_cases/get_product_list.dart';
import 'package:big_cart/features/buy/presentation/cubit/cubit/shop_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../helpers/test_fixtures.dart';

class MockGetCategoryList extends Mock implements GetCategoryList {}

class MockGetProductList extends Mock implements GetProductList {}

void main() {
  late MockGetCategoryList mockGetCategoryList;
  late MockGetProductList mockGetProductList;
  late ShopCubit shopCubit;

  setUpAll(() {
    registerAllFallbackValues();
  });

  setUp(() {
    mockGetCategoryList = MockGetCategoryList();
    mockGetProductList = MockGetProductList();

    shopCubit = ShopCubit(mockGetCategoryList, mockGetProductList);
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
}
