import 'package:big_cart/core/error/failure.dart';
import 'package:big_cart/features/account/domain/entities/user.dart';
import 'package:big_cart/features/auth/domain/use_cases/sign_in_with_google.dart';
import 'package:big_cart/features/auth/domain/use_cases/forgot_password.dart';
import 'package:big_cart/features/auth/domain/use_cases/get_token.dart';
import 'package:big_cart/features/auth/domain/use_cases/is_first_time.dart';
import 'package:big_cart/features/auth/domain/use_cases/log_in.dart';
import 'package:big_cart/features/auth/domain/use_cases/send_otp.dart';
import 'package:big_cart/features/auth/domain/use_cases/sign_up.dart';
import 'package:big_cart/features/auth/domain/use_cases/verify_otp.dart';
import 'package:big_cart/features/auth/domain/use_cases/sign_out.dart';
import 'package:big_cart/features/auth/domain/use_cases/save_credentials.dart';
import 'package:big_cart/features/auth/domain/use_cases/get_saved_credentials.dart';
import 'package:big_cart/features/auth/domain/use_cases/clear_credentials.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart' show Either;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(
    this.getToken,
    this.logIn,
    this.signUp,
    this.sendOtp,
    this.verifyOtp,
    this.forgotPassword,
    this.signOut,
    this.saveCredentials,
    this.getSavedCredentials,
    this.clearCredentials,
    this.signInWithGoogle,
    this.isFirstTime,
  ) : super(AuthState.initial());
  IsFirstTime isFirstTime;
  GetToken getToken;
  LogIn logIn;
  SignUp signUp;
  SendOtp sendOtp;
  VerifyOtp verifyOtp;
  ForgotPassword forgotPassword;
  SignOut signOut;
  SaveCredentials saveCredentials;
  GetSavedCredentials getSavedCredentials;
  ClearCredentials clearCredentials;
  SignInWithGoogle signInWithGoogle;

  void attemptGoogleSignIn() async {
    if (state is _Loading) return;
    emit(AuthState.loading());
    final result = await signInWithGoogle.call();
    result.fold(
      (failure) => failure is GoogleSignInCancelledFailure
          // closing Google's picker isn't an error, just back to idle
          ? emit(AuthState.initial())
          : emit(AuthState.error(failure.message)),
      (user) => emit(AuthState.success(user)),
    );
  }

  void checkIfLoggedIn() async {
    final token = await getToken.call();
    if (token == null || token.isEmpty) {
      emit(AuthState.signedOut(isFirstTime: await isFirstTime.call()));
    } else {
      emit(AuthState.success(User(name: '', email: '', phone: '')));
    }
  }

  void attemptLogIn(String email, String password, bool remember) async {
    emit(AuthState.loading());
    final result = await logIn.call(
      email: email,
      password: password,
      remember: remember,
    );
    result.fold((failure) => emit(AuthState.error(failure.message)), (
      user,
    ) async {
      if (remember) {
        await saveCredentials.call(email);
      } else {
        await clearCredentials.call();
      }
      emit(AuthState.success(user));
    });
  }

  void sendOtpToUser(String number) async {
    emit(AuthState.loading());
    final result = await sendOtp.call(number: number);
    result.fold(
      (failure) => emit(AuthState.error(failure.message)),
      (unit) => emit(AuthState.initial()),
    );
  }

  /// The end of sign up: the account is only created once the code checks
  /// out, then it signs straight in. Sign up itself just collects the email
  /// and password, and the verify page asks for the number once.
  void verifyUserOtp({
    required String email,
    required String otp,
    required String password,
    required String number,
  }) async {
    if (state is _Loading) return;
    emit(AuthState.loading());
    final verifyFailure = _failureOf(
      await verifyOtp.call(
        email: email,
        otp: otp,
        number: number,
        password: password,
      ),
    );
    if (verifyFailure != null) {
      emit(AuthState.error(verifyFailure.message));
      return;
    }
    final signUpFailure = _failureOf(
      await signUp.call(email: email, password: password, number: number),
    );
    if (signUpFailure != null) {
      emit(AuthState.error(signUpFailure.message));
      return;
    }
    final session = await logIn.call(
      email: email,
      password: password,
      remember: true,
    );
    session.fold(
      (failure) => emit(AuthState.error(failure.message)),
      (user) => emit(AuthState.success(user)),
    );
  }

  Failure? _failureOf(Either<Failure, Object?> result) =>
      result.fold((failure) => failure, (_) => null);

  void userForgotPassword(String email) async {
    emit(AuthState.loading());
    final result = await forgotPassword.call(email: email);
    result.fold(
      (failure) => emit(AuthState.error(failure.message)),
      (unit) => emit(AuthState.initial()),
    );
  }

  Future<void> attemptSignOut() async {
    emit(AuthState.loading());
    await signOut.call();
    emit(AuthState.initial());
  }

  Future<void> attemptGetSavedCredentials() async {
    emit(AuthState.loading());
    final email = await getSavedCredentials.call();
    if (email == null) {
      emit(AuthState.initial());
    } else {
      emit(AuthState.loadedEmail(email));
    }
  }
}
