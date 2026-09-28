import 'package:big_cart/features/buy/domain/use_cases/add_review.dart';
import 'package:big_cart/features/buy/domain/use_cases/get_product_reviews.dart';
import 'package:big_cart/features/buy/presentation/cubit/cubit/reviews_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../helpers/test_fixtures.dart';

class MockGetProductReviews extends Mock implements GetProductReviews {}

class MockAddReview extends Mock implements AddReview {}

void main() {
  late MockGetProductReviews mockGetProductReviews;
  late MockAddReview mockAddReview;
  late ReviewsCubit reviewsCubit;

  setUpAll(() {
    registerAllFallbackValues();
  });

  setUp(() {
    mockGetProductReviews = MockGetProductReviews();
    mockAddReview = MockAddReview();
    reviewsCubit = ReviewsCubit(mockGetProductReviews, mockAddReview);
  });

  tearDown(() {
    reviewsCubit.close();
  });

  test('initial state is ReviewsState.initial()', () {
    expect(reviewsCubit.state, const ReviewsState.initial());
  });

  group('attemptGetReviews', () {
    blocTest<ReviewsCubit, ReviewsState>(
      'emits [loading, loaded] on success',
      build: () {
        when(
          () => mockGetProductReviews.call(any()),
        ).thenAnswer((_) async => Right([testReview]));
        return reviewsCubit;
      },
      act: (cubit) => cubit.attemptGetReviews('prod_1'),
      expect: () => [
        const ReviewsState.loading(),
        ReviewsState.loaded([testReview]),
      ],
      verify: (_) {
        verify(() => mockGetProductReviews.call('prod_1')).called(1);
      },
    );

    blocTest<ReviewsCubit, ReviewsState>(
      'emits [loading, error] on failure',
      build: () {
        when(
          () => mockGetProductReviews.call(any()),
        ).thenAnswer((_) async => Left(DummyFailure('Reviews error')));
        return reviewsCubit;
      },
      act: (cubit) => cubit.attemptGetReviews('prod_1'),
      expect: () => [
        const ReviewsState.loading(),
        const ReviewsState.error('Reviews error'),
      ],
    );
  });

  group('attemptAddReview', () {
    blocTest<ReviewsCubit, ReviewsState>(
      'emits [loading, added] when the review is saved',
      build: () {
        when(
          () => mockAddReview.call(any(), any()),
        ).thenAnswer((_) async => const Right(unit));
        return reviewsCubit;
      },
      act: (cubit) => cubit.attemptAddReview('prod_1', 'Great product!', 5.0),
      expect: () => [
        const ReviewsState.loading(),
        const ReviewsState.added('Added review successfully'),
      ],
      verify: (_) {
        verify(() => mockAddReview.call('prod_1', any())).called(1);
      },
    );

    blocTest<ReviewsCubit, ReviewsState>(
      'emits [loading, error] when saving fails',
      build: () {
        when(
          () => mockAddReview.call(any(), any()),
        ).thenAnswer((_) async => Left(DummyFailure('Failed to add review')));
        return reviewsCubit;
      },
      act: (cubit) => cubit.attemptAddReview('prod_1', 'Great product!', 5.0),
      expect: () => [
        const ReviewsState.loading(),
        const ReviewsState.error('Failed to add review'),
      ],
    );
  });
}
