import 'package:big_cart/core/api/api.dart';
import 'package:big_cart/core/error/exception.dart';
import 'package:big_cart/core/session/user_local_data_source.dart';
import 'package:big_cart/features/account/data/models/user_model.dart';
import 'package:big_cart/features/account/domain/entities/user.dart';
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

  // What logIn and googleSignIn both return: our session token and the full
  // user the app keeps after signing in. One copy, so the two can't drift.
  static const _session = r'''
          token
          user {
            id
            name
            email
            phone
            image_path
            default_address_id
            default_credit_card_id
            address {
              id
              name
              street
              city
              zip_code
              country
              phone
            }
            credit_card {
              id
              card_holder_name
              last4
              expiry_date
              stripe_payment_id
              processor
            }
            order {
              id
              shipping_method
              total_amount
              status
              date_placed
              order_item {
                id
                quantity
                price_at_purchase
                product {
                  id
                  name
                  image_path
                  amount
                  description
                  discount
                  price
                  is_new
                  is_favorite
                  color
                  rating
                }
              }
              address {
                id
                name
                street
                city
                zip_code
                country
                phone
              }
              credit_card {
                id
                card_holder_name
                last4
                expiry_date
                stripe_payment_id
                processor
              }
            }
            transaction {
              id
              amount
              status
              payment_method
              created_at
            }
          }''';

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
    //    exactly what logIn returns.
    const mutation =
        r'''
      mutation GoogleSignIn($idToken: String!) {
        googleSignIn(idToken: $idToken) {'''
        '$_session'
        '''
        }
      }
    ''';
    try {
      final data = await apiConsumer.graphql(
        query: mutation,
        variables: {'idToken': idToken},
      );
      final payload = data['googleSignIn'];
      await userLocalDataSource.saveToken(payload['token'] as String);
      final user = UserModel.fromJson(
        Map<String, dynamic>.from(payload['user']),
      );
      return user.toEntity();
    } on DioException {
      throw NoInternetException();
    }
  }

  @override
  Future<Unit> forgotPassword({required String email}) async {
    const mutation = r'''
      mutation ForgotPassword($email: String!) {
        forgotPassword(email: $email)
      }
    ''';
    try {
      await apiConsumer.graphql(
        query: mutation,
        variables: {'email': email},
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
    const mutation =
        r'''
      mutation LogIn($email: String!, $password: String!) {
        logIn(email: $email, password: $password) {'''
        '$_session'
        '''
        }
      }
    ''';

    try {
      final data = await apiConsumer.graphql(
        query: mutation,
        variables: {
          'email': email,
          'password': password,
        },
      );

      final loginPayload = data['logIn'];
      final token = loginPayload['token'] as String;
      final userMap = Map<String, dynamic>.from(loginPayload['user']);
      userMap['password'] = password;

      // Save token and credentials
      await userLocalDataSource.saveToken(token);
      if (remember) {
        await userLocalDataSource.saveEmail(email);
      } else {
        await userLocalDataSource.clearSavedEmail();
      }

      final user = UserModel.fromJson(userMap);
      return user.toEntity();
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
    const mutation = r'''
      mutation SignUp($email: String!, $number: String!, $password: String!) {
        signUp(email: $email, number: $number, password: $password) {
          id
          name
          email
          phone
        }
      }
    ''';

    try {
      final data = await apiConsumer.graphql(
        query: mutation,
        variables: {
          'email': email,
          'number': number,
          'password': password,
        },
      );

      final userMap = Map<String, dynamic>.from(data['signUp']);
      userMap['password'] = password;
      return UserModel.fromJson(userMap).toEntity();
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
