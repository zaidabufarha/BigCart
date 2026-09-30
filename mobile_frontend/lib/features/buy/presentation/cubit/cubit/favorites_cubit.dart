import 'package:big_cart/features/buy/domain/entities/product.dart';
import 'package:big_cart/features/buy/domain/use_cases/get_cart_items.dart';
import 'package:big_cart/features/buy/domain/use_cases/toggle_favorite.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'favorites_state.dart';
part 'favorites_cubit.freezed.dart';

/// The account's favorites, for every heart and the Favorites tab, so they
/// always agree. Toggles are optimistic: the heart flips at once, and a
/// refused toggle flips it back and sets [FavoritesState.error].
@injectable
class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit(this.getCartItems, this.toggleFavorite)
    : super(const FavoritesState());
  final GetCartItems getCartItems;
  final ToggleFavorite toggleFavorite;

  /// Until the list has loaded, a product's own flag from the server decides.
  /// Not named 'attempt' because there's no server communication.
  bool isFavorite(Product product) => state.loaded
      ? state.products.containsKey(product.id)
      : product.isFavorite;

  Future<void> attemptGetFavorites() async {
    final result = await getCartItems.call(isFavorites: true);
    result.fold(
      (failure) => emit(state.copyWith(error: failure.message)),
      (items) => emit(
        FavoritesState(
          products: {
            for (final item in items)
              item.product.id: item.product.copyWith(isFavorite: true),
          },
          loaded: true,
        ),
      ),
    );
  }

  Future<void> attemptToggleFavorite(Product product) async {
    final before = state.products;
    final favorite = !isFavorite(product);
    emit(
      state.copyWith(
        products: favorite
            ? {...before, product.id: product.copyWith(isFavorite: true)}
            : (Map.of(before)..remove(product.id)),
        error: null,
      ),
    );
    final result = await toggleFavorite.call(product.id, favorite);
    result.fold(
      // back to how it was, and say why
      (failure) =>
          emit(state.copyWith(products: before, error: failure.message)),
      (_) {},
    );
  }
}
