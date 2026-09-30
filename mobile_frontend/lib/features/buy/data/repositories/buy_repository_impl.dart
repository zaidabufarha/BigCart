import 'package:big_cart/core/error/exception.dart';
import 'package:big_cart/core/error/failure.dart';
import 'package:big_cart/core/network/network_info.dart';
import 'package:big_cart/core/session/user_local_data_source.dart';
import 'package:big_cart/features/account/domain/entities/order.dart';
import 'package:big_cart/features/buy/data/data_sources/buy_remote_data_source.dart';
import 'package:big_cart/features/buy/domain/entities/cart_item.dart';
import 'package:big_cart/features/buy/domain/entities/category.dart';
import 'package:big_cart/features/buy/domain/entities/product.dart';
import 'package:big_cart/features/buy/domain/entities/review.dart';
import 'package:big_cart/features/buy/domain/repositories/buy_repository.dart';
import 'package:dartz/dartz.dart' hide Order;
import 'package:injectable/injectable.dart' hide Order;

@LazySingleton(as: BuyRepository)
class BuyRepositoryImpl implements BuyRepository {
  final BuyRemoteDataSource buyRemoteDataSource;
  final UserLocalDataSource userLocalDataSource;
  final NetworkInfo networkInfo;
  BuyRepositoryImpl(
    this.buyRemoteDataSource,
    this.userLocalDataSource,
    this.networkInfo,
  );

  @override
  Future<List<String>> getSearchHistory() =>
      userLocalDataSource.getSearchHistory();

  @override
  Future<void> saveSearchHistory(List<String> history) =>
      userLocalDataSource.saveSearchHistory(history);

  @override
  Future<Either<Failure, Unit>> addReview(String id, Review review) async {
    try {
      await buyRemoteDataSource.addReview(id, review);
      return Right(unit);
    } on NoDataException {
      return Left(NoDataFailure());
    } on NoInternetException {
      return Left(NoInternetFailure());
    } on EmptyCacheException {
      return Left(EmptyCacheFailure());
    } catch (e) {
      return Left(ServerFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }

  @override
  Future<Either<Failure, String>> addToCart(CartItem item) async {
    try {
      return Right(await buyRemoteDataSource.addToCart(item));
    } on NoDataException {
      return Left(NoDataFailure());
    } on NoInternetException {
      return Left(NoInternetFailure());
    } on EmptyCacheException {
      return Left(EmptyCacheFailure());
    } catch (e) {
      return Left(ServerFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }

  @override
  Future<Either<Failure, String>> checkOut(Order order) async {
    try {
      return Right(await buyRemoteDataSource.checkOut(order));
    } on NoDataException {
      return Left(NoDataFailure());
    } on NoInternetException {
      return Left(NoInternetFailure());
    } on EmptyCacheException {
      return Left(EmptyCacheFailure());
    } catch (e) {
      return Left(ServerFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }

  @override
  Future<Either<Failure, List<CartItem>>> getCartItems({
    bool isFavorites = false,
  }) async {
    try {
      return Right(
        await buyRemoteDataSource.getCartItems(isFavorites: isFavorites),
      );
    } on NoDataException {
      return Left(NoDataFailure());
    } on NoInternetException {
      return Left(NoInternetFailure());
    } on EmptyCacheException {
      return Left(EmptyCacheFailure());
    } catch (e) {
      return Left(ServerFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }

  @override
  Future<Either<Failure, List<Category>>> getCategoryList() async {
    try {
      return Right(await buyRemoteDataSource.getCategoryList());
    } on NoDataException {
      return Left(NoDataFailure());
    } on NoInternetException {
      return Left(NoInternetFailure());
    } on EmptyCacheException {
      return Left(EmptyCacheFailure());
    } catch (e) {
      return Left(ServerFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getProductList() async {
    try {
      return Right(await buyRemoteDataSource.getProductList());
    } on NoDataException {
      return Left(NoDataFailure());
    } on NoInternetException {
      return Left(NoInternetFailure());
    } on EmptyCacheException {
      return Left(EmptyCacheFailure());
    } catch (e) {
      return Left(ServerFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }

  @override
  Future<Either<Failure, List<Review>>> getProductReviews(String id) async {
    try {
      return Right(await buyRemoteDataSource.getProductReviews(id));
    } on NoDataException {
      return Left(NoDataFailure());
    } on NoInternetException {
      return Left(NoInternetFailure());
    } on EmptyCacheException {
      return Left(EmptyCacheFailure());
    } catch (e) {
      return Left(ServerFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }

  @override
  Future<Either<Failure, Unit>> removeFromCart(CartItem item) async {
    try {
      await buyRemoteDataSource.removeFromCart(item);
      return Right(unit);
    } on NoDataException {
      return Left(NoDataFailure());
    } on NoInternetException {
      return Left(NoInternetFailure());
    } on EmptyCacheException {
      return Left(EmptyCacheFailure());
    } catch (e) {
      return Left(ServerFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }

  @override
  Future<Either<Failure, Unit>> toggleFavorite(
    String id,
    bool isFavorite,
  ) async {
    try {
      await buyRemoteDataSource.toggleFavorite(id, isFavorite);
      return Right(unit);
    } on NoDataException {
      return Left(NoDataFailure());
    } on NoInternetException {
      return Left(NoInternetFailure());
    } on EmptyCacheException {
      return Left(EmptyCacheFailure());
    } catch (e) {
      return Left(ServerFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateQuantity(
    CartItem item,
    int newQuantity,
  ) async {
    try {
      await buyRemoteDataSource.updateQuantity(item, newQuantity);
      return Right(unit);
    } on NoDataException {
      return Left(NoDataFailure());
    } on NoInternetException {
      return Left(NoInternetFailure());
    } on EmptyCacheException {
      return Left(EmptyCacheFailure());
    } catch (e) {
      return Left(ServerFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }
}
