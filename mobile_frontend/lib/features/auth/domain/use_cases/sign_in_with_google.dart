import 'package:big_cart/core/error/failure.dart';
import 'package:big_cart/features/account/domain/entities/user.dart';
import 'package:big_cart/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

// Named SignInWithGoogle, not GoogleSignIn, so it doesn't clash with the
// google_sign_in package's class of that name.
@lazySingleton
class SignInWithGoogle {
  final AuthRepository authRepository;
  SignInWithGoogle({required this.authRepository});
  Future<Either<Failure, User>> call() async {
    return await authRepository.googleSignIn();
  }
}
