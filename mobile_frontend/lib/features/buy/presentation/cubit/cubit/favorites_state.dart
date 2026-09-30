part of 'favorites_cubit.dart';

@freezed
abstract class FavoritesState with _$FavoritesState {
  const factory FavoritesState({
    /// Favorited products, by id, in the order they were added.
    @Default({}) Map<String, Product> products,

    /// False until the first load, so "none yet" and "not fetched" differ.
    @Default(false) bool loaded,

    /// Set when the server refused a toggle (the heart is already back);
    /// the shell shows it. Cleared by the next toggle.
    String? error,
  }) = _FavoritesState;
}
