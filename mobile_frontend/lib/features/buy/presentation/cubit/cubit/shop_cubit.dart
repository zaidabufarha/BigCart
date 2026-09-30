import 'package:big_cart/features/buy/domain/entities/category.dart';
import 'package:big_cart/features/buy/domain/entities/product.dart';
import 'package:big_cart/features/buy/domain/use_cases/get_category_list.dart';
import 'package:big_cart/features/buy/domain/use_cases/get_product_list.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'shop_state.dart';
part 'shop_cubit.freezed.dart';

// The catalogue only. Reviews, favorites and the cart each have their own
// cubit, so changing them never swaps out these lists.
@injectable
class ShopCubit extends Cubit<ShopState> {
  ShopCubit(this.getCategoryList, this.getProductList)
    : super(ShopState.initial());
  final GetCategoryList getCategoryList;
  final GetProductList getProductList;

  void attemptGetCategoryList() async {
    emit(ShopState.loading());
    final result = await getCategoryList.call();
    result.fold(
      (failure) {
        emit(ShopState.error(failure.message));
      },
      (list) {
        emit(ShopState.loadedCategories(list));
      },
    );
  }

  void attemptGetProductList() async {
    emit(ShopState.loading());

    final result = await getProductList.call();
    result.fold(
      (failure) {
        emit(ShopState.error(failure.message));
      },
      (list) {
        emit(ShopState.loadedProducts(list));
      },
    );
  }
}
