import 'package:big_cart/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

/// Whether nobody has signed in on this device yet, which decides between the
/// welcome slides and the welcome page for a signed-out start.
@lazySingleton
class IsFirstTime {
  final AuthRepository repository;
  IsFirstTime({required this.repository});
  Future<bool> call() async {
    return await repository.isFirstTime();
  }
}
