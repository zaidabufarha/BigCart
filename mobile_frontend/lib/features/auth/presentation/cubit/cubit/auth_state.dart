part of 'auth_cubit.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  // the start-up check found no session; isFirstTime picks slides or welcome
  const factory AuthState.signedOut({required bool isFirstTime}) = _SignedOut;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.loadedEmail(String email) = _LoadedEmail;
  const factory AuthState.error(String errorMessage) = _Error;
  const factory AuthState.success(User user) = _Success;
}
