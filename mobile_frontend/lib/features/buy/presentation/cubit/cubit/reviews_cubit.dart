import 'package:big_cart/features/account/domain/entities/user.dart';
import 'package:big_cart/features/buy/domain/entities/review.dart';
import 'package:big_cart/features/buy/domain/use_cases/add_review.dart';
import 'package:big_cart/features/buy/domain/use_cases/get_product_reviews.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'reviews_state.dart';
part 'reviews_cubit.freezed.dart';

/// Reviews for the open product. Kept apart from ShopCubit so loading them
/// never replaces the product and category lists the pages underneath show.
@injectable
class ReviewsCubit extends Cubit<ReviewsState> {
  ReviewsCubit(this.getProductReviews, this.addReview)
    : super(const ReviewsState.initial());
  final GetProductReviews getProductReviews;
  final AddReview addReview;

  void attemptGetReviews(String productId) async {
    emit(const ReviewsState.loading());
    final result = await getProductReviews.call(productId);
    result.fold(
      (failure) => emit(ReviewsState.error(failure.message)),
      (reviews) => emit(ReviewsState.loaded(reviews)),
    );
  }

  void attemptAddReview(String productId, String comment, double rating) async {
    emit(const ReviewsState.loading());
    final review = Review(
      // the backend fills in the author from the token
      user: const User(name: '', email: '', phone: ''),
      comment: comment,
      rating: rating,
      createdAt: DateTime.now(),
    );
    final result = await addReview.call(productId, review);
    result.fold(
      (failure) => emit(ReviewsState.error(failure.message)),
      (_) => emit(const ReviewsState.added('Added review successfully')),
    );
  }
}
