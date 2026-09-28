part of 'reviews_cubit.dart';

@freezed
class ReviewsState with _$ReviewsState {
  const factory ReviewsState.initial() = _Initial;
  const factory ReviewsState.loading() = _Loading;
  const factory ReviewsState.loaded(List<Review> reviews) = _Loaded;
  const factory ReviewsState.added(String message) = _Added;
  const factory ReviewsState.error(String message) = _Error;
}
