import 'package:big_cart/core/api/api.dart';
import 'package:big_cart/core/error/exception.dart';
import 'package:big_cart/core/graphql/mappers.dart';
import 'package:big_cart/core/session/user_local_data_source.dart';
import 'package:big_cart/features/account/domain/entities/user.dart';
import 'package:big_cart/features/auth/data/graphql/auth.graphql.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

abstract class AuthRemoteDataSource {
  Future<Unit> sendOtp(String email);
  Future<Unit> verifyOtp({required String email, required String otp});
  Future<User> logIn({
    required String email,
    required String password,
    required bool remember,
  });
  Future<User> signUp({
    required String email,
    required String password,
    required String number,
  });
  Future<Unit> forgotPassword({
    required String email,
  });
  Future<User> googleSignIn();
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiConsumer apiConsumer;
  final UserLocalDataSource userLocalDataSource;

  AuthRemoteDataSourceImpl({
    required this.apiConsumer,
    required this.userLocalDataSource,
  });

  // The BigCart *web* OAuth client's ID (public, not a secret). Asking Google
  // for a token addressed to it means the backend only ever checks one ID,
  // whichever app the token came from. The Android client isn't referenced in
  // code: Google matches this app to it by package name and signing key.
  static const _googleWebClientId =
      '224693958509-p3kik94g234eh37hom8gufrvdumlsv6v.apps.googleusercontent.com';
  bool _googleReady = false;

  @override
  Future<User> googleSignIn() async {
    // 1. Google's own account picker. It returns an ID token: a JWT that
    //    Google signs, holding the account's email and a stable id.
    final google = GoogleSignIn.instance;
    if (!_googleReady) {
      await google.initialize(serverClientId: _googleWebClientId);
      _googleReady = true;
    }
    final String? idToken;
    try {
      idToken = (await google.authenticate()).authentication.idToken;
    } on GoogleSignInException catch (e) {
      // Android reports some setup problems (package name or signing key not
      // matching the Android OAuth client) as "canceled" too, so log the
      // details: they're the only clue when the picker closes and nothing happens
      debugPrint('Google sign-in: ${e.code} — ${e.description}');
      if (e.code == GoogleSignInExceptionCode.canceled) {
        throw GoogleSignInCancelledException();
      }
      throw ServerException('Google sign-in failed. Please try again.');
    }
    if (idToken == null) {
      throw ServerException('Google sign-in failed. Please try again.');
    }

    // 2. The backend verifies the token and swaps it for our own session,
    //    the same SessionFields logIn returns.
    try {
      final data = await apiConsumer.request(
        documentNodeMutationGoogleSignIn,
        variables: Variables$Mutation$GoogleSignIn(idToken: idToken).toJson(),
      );
      final session = Mutation$GoogleSignIn.fromJson(data).googleSignIn;
      await userLocalDataSource.saveToken(session.token);
      return session.user.toEntity();
    } on DioException {
      throw NoInternetException();
    }
  }

  @override
  Future<Unit> forgotPassword({required String email}) async {
    try {
      await apiConsumer.request(
        documentNodeMutationForgotPassword,
        variables: Variables$Mutation$ForgotPassword(email: email).toJson(),
      );
      return unit;
    } on DioException {
      throw NoInternetException();
    }
  }

  @override
  Future<User> logIn({
    required String email,
    required String password,
    required bool remember,
  }) async {
    try {
      final data = await apiConsumer.request(
        documentNodeMutationLogIn,
        variables: Variables$Mutation$LogIn(
          email: email,
          password: password,
        ).toJson(),
      );
      final session = Mutation$LogIn.fromJson(data).logIn;

      await userLocalDataSource.saveToken(session.token);
      if (remember) {
        await userLocalDataSource.saveEmail(email);
      } else {
        await userLocalDataSource.clearSavedEmail();
      }
      return session.user.toEntity();
    } on DioException {
      throw NoInternetException();
    }
  }

  @override
  Future<Unit> sendOtp(String email) async {
    return unit;
  }

  @override
  Future<User> signUp({
    required String email,
    required String password,
    required String number,
  }) async {
    try {
      final data = await apiConsumer.request(
        documentNodeMutationSignUp,
        variables: Variables$Mutation$SignUp(
          email: email,
          number: number,
          password: password,
        ).toJson(),
      );
      return Mutation$SignUp.fromJson(data).signUp.toEntity();
    } on DioException {
      throw NoInternetException();
    }
  }

  @override
  Future<Unit> verifyOtp({required String email, required String otp}) async {
    // SMS isn't implemented, so the code is fixed (the verify page says so)
    if (otp == '123456') {
      return unit;
    } else {
      throw WrongOTPException();
    }
  }
}
