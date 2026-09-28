import 'package:big_cart/core/error/failure.dart';
import 'package:big_cart/features/auth/domain/use_cases/clear_credentials.dart';
import 'package:big_cart/features/auth/domain/use_cases/sign_in_with_google.dart';
import 'package:big_cart/features/auth/domain/use_cases/forgot_password.dart';
import 'package:big_cart/features/auth/domain/use_cases/get_saved_credentials.dart';
import 'package:big_cart/features/auth/domain/use_cases/get_token.dart';
import 'package:big_cart/features/auth/domain/use_cases/is_first_time.dart';
import 'package:big_cart/features/auth/domain/use_cases/log_in.dart';
import 'package:big_cart/features/auth/domain/use_cases/save_credentials.dart';
import 'package:big_cart/features/auth/domain/use_cases/send_otp.dart';
import 'package:big_cart/features/auth/domain/use_cases/sign_out.dart';
import 'package:big_cart/features/auth/domain/use_cases/sign_up.dart';
import 'package:big_cart/features/auth/domain/use_cases/verify_otp.dart';
import 'package:big_cart/features/auth/presentation/cubit/cubit/auth_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../helpers/test_fixtures.dart';

class MockGetToken extends Mock implements GetToken {}

class MockLogIn extends Mock implements LogIn {}

class MockSignUp extends Mock implements SignUp {}

class MockSendOtp extends Mock implements SendOtp {}

class MockVerifyOtp extends Mock implements VerifyOtp {}

class MockForgotPassword extends Mock implements ForgotPassword {}

class MockSignOut extends Mock implements SignOut {}

class MockSaveCredentials extends Mock implements SaveCredentials {}

class MockGetSavedCredentials extends Mock implements GetSavedCredentials {}

class MockClearCredentials extends Mock implements ClearCredentials {}

class MockSignInWithGoogle extends Mock implements SignInWithGoogle {}

class MockIsFirstTime extends Mock implements IsFirstTime {}

void main() {
  late MockIsFirstTime mockIsFirstTime;
  late MockGetToken mockGetToken;
  late MockLogIn mockLogIn;
  late MockSignUp mockSignUp;
  late MockSendOtp mockSendOtp;
  late MockVerifyOtp mockVerifyOtp;
  late MockForgotPassword mockForgotPassword;
  late MockSignOut mockSignOut;
  late MockSaveCredentials mockSaveCredentials;
  late MockGetSavedCredentials mockGetSavedCredentials;
  late MockClearCredentials mockClearCredentials;
  late MockSignInWithGoogle mockSignInWithGoogle;
  late AuthCubit authCubit;

  setUpAll(() {
    registerAllFallbackValues();
  });

  setUp(() {
    mockGetToken = MockGetToken();
    mockLogIn = MockLogIn();
    mockSignUp = MockSignUp();
    mockSendOtp = MockSendOtp();
    mockVerifyOtp = MockVerifyOtp();
    mockForgotPassword = MockForgotPassword();
    mockSignOut = MockSignOut();
    mockSaveCredentials = MockSaveCredentials();
    mockGetSavedCredentials = MockGetSavedCredentials();
    mockClearCredentials = MockClearCredentials();
    mockSignInWithGoogle = MockSignInWithGoogle();
    mockIsFirstTime = MockIsFirstTime();

    authCubit = AuthCubit(
      mockGetToken,
      mockLogIn,
      mockSignUp,
      mockSendOtp,
      mockVerifyOtp,
      mockForgotPassword,
      mockSignOut,
      mockSaveCredentials,
      mockGetSavedCredentials,
      mockClearCredentials,
      mockSignInWithGoogle,
      mockIsFirstTime,
    );
  });

  group('attemptGoogleSignIn', () {
    blocTest<AuthCubit, AuthState>(
      'emits [loading, success] when Google and the backend accept',
      build: () {
        when(
          () => mockSignInWithGoogle.call(),
        ).thenAnswer((_) async => Right(testUser));
        return authCubit;
      },
      act: (cubit) => cubit.attemptGoogleSignIn(),
      expect: () => [const AuthState.loading(), AuthState.success(testUser)],
    );

    blocTest<AuthCubit, AuthState>(
      'goes back to initial, with no error, when the picker is closed',
      build: () {
        when(
          () => mockSignInWithGoogle.call(),
        ).thenAnswer((_) async => Left(GoogleSignInCancelledFailure()));
        return authCubit;
      },
      act: (cubit) => cubit.attemptGoogleSignIn(),
      expect: () => [const AuthState.loading(), const AuthState.initial()],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [loading, error] when sign-in fails',
      build: () {
        when(() => mockSignInWithGoogle.call()).thenAnswer(
          (_) async =>
              Left(ServerFailure('Google sign-in failed. Please try again.')),
        );
        return authCubit;
      },
      act: (cubit) => cubit.attemptGoogleSignIn(),
      expect: () => [
        const AuthState.loading(),
        const AuthState.error('Google sign-in failed. Please try again.'),
      ],
    );
  });

  tearDown(() {
    authCubit.close();
  });

  test('initial state is AuthState.initial()', () {
    expect(authCubit.state, const AuthState.initial());
  });

  group('checkIfLoggedIn', () {
    blocTest<AuthCubit, AuthState>(
      'emits [AuthState.success(user)] when token exists',
      build: () {
        when(() => mockGetToken.call()).thenAnswer((_) async => 'sample_token');
        return authCubit;
      },
      act: (cubit) => cubit.checkIfLoggedIn(),
      expect: () => [
        predicate<AuthState>(
          (state) => state.maybeWhen(
            success: (_) => true,
            orElse: () => false,
          ),
        ),
      ],
      verify: (_) {
        verify(() => mockGetToken.call()).called(1);
      },
    );

    blocTest<AuthCubit, AuthState>(
      'emits signedOut(isFirstTime: true) with no token on a new device',
      build: () {
        when(() => mockGetToken.call()).thenAnswer((_) async => null);
        when(() => mockIsFirstTime.call()).thenAnswer((_) async => true);
        return authCubit;
      },
      act: (cubit) => cubit.checkIfLoggedIn(),
      expect: () => [const AuthState.signedOut(isFirstTime: true)],
      verify: (_) {
        verify(() => mockGetToken.call()).called(1);
      },
    );

    blocTest<AuthCubit, AuthState>(
      'emits signedOut(isFirstTime: false) with no token after an earlier sign-in',
      build: () {
        when(() => mockGetToken.call()).thenAnswer((_) async => null);
        when(() => mockIsFirstTime.call()).thenAnswer((_) async => false);
        return authCubit;
      },
      act: (cubit) => cubit.checkIfLoggedIn(),
      expect: () => [const AuthState.signedOut(isFirstTime: false)],
    );
  });

  group('attemptLogIn', () {
    blocTest<AuthCubit, AuthState>(
      'emits [loading, success] and saves credentials when remember is true',
      build: () {
        when(
          () => mockLogIn.call(
            email: 'john@example.com',
            password: 'password123',
            remember: true,
          ),
        ).thenAnswer((_) async => Right(testUser));
        when(() => mockSaveCredentials.call(any())).thenAnswer((_) async {});
        return authCubit;
      },
      act: (cubit) =>
          cubit.attemptLogIn('john@example.com', 'password123', true),
      expect: () => [
        const AuthState.loading(),
        AuthState.success(testUser),
      ],
      verify: (_) {
        verify(
          () => mockLogIn.call(
            email: 'john@example.com',
            password: 'password123',
            remember: true,
          ),
        ).called(1);
        verify(() => mockSaveCredentials.call('john@example.com')).called(1);
      },
    );

    blocTest<AuthCubit, AuthState>(
      'emits [loading, success] and clears credentials when remember is false',
      build: () {
        when(
          () => mockLogIn.call(
            email: 'john@example.com',
            password: 'password123',
            remember: false,
          ),
        ).thenAnswer((_) async => Right(testUser));
        when(() => mockClearCredentials.call()).thenAnswer((_) async {});
        return authCubit;
      },
      act: (cubit) =>
          cubit.attemptLogIn('john@example.com', 'password123', false),
      expect: () => [
        const AuthState.loading(),
        AuthState.success(testUser),
      ],
      verify: (_) {
        verify(
          () => mockLogIn.call(
            email: 'john@example.com',
            password: 'password123',
            remember: false,
          ),
        ).called(1);
        verify(() => mockClearCredentials.call()).called(1);
      },
    );

    blocTest<AuthCubit, AuthState>(
      'emits [loading, error] when logIn returns Failure',
      build: () {
        when(
          () => mockLogIn.call(
            email: any(named: 'email'),
            password: any(named: 'password'),
            remember: any(named: 'remember'),
          ),
        ).thenAnswer((_) async => Left(DummyFailure('Invalid credentials')));
        return authCubit;
      },
      act: (cubit) =>
          cubit.attemptLogIn('john@example.com', 'wrongpass', false),
      expect: () => [
        const AuthState.loading(),
        const AuthState.error('Invalid credentials'),
      ],
    );
  });

  group('sendOtpToUser', () {
    blocTest<AuthCubit, AuthState>(
      'emits [loading, initial] when sendOtp succeeds',
      build: () {
        when(
          () => mockSendOtp.call(number: '+1234567890'),
        ).thenAnswer((_) async => const Right(unit));
        return authCubit;
      },
      act: (cubit) => cubit.sendOtpToUser('+1234567890'),
      expect: () => [
        const AuthState.loading(),
        const AuthState.initial(),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [loading, error] when sendOtp returns Failure',
      build: () {
        when(
          () => mockSendOtp.call(number: any(named: 'number')),
        ).thenAnswer((_) async => Left(DummyFailure('OTP failed')));
        return authCubit;
      },
      act: (cubit) => cubit.sendOtpToUser('+1234567890'),
      expect: () => [
        const AuthState.loading(),
        const AuthState.error('OTP failed'),
      ],
    );
  });

  group('verifyUserOtp', () {
    blocTest<AuthCubit, AuthState>(
      'checks the code, then creates the account, then signs in',
      build: () {
        when(
          () => mockVerifyOtp.call(
            email: 'john@example.com',
            otp: '123456',
            number: '+1234567890',
            password: 'password123',
          ),
        ).thenAnswer((_) async => Right(testUser));
        when(
          () => mockSignUp.call(
            email: 'john@example.com',
            password: 'password123',
            number: '+1234567890',
          ),
        ).thenAnswer((_) async => Right(testUser));
        when(
          () => mockLogIn.call(
            email: 'john@example.com',
            password: 'password123',
            remember: true,
          ),
        ).thenAnswer((_) async => Right(testUser));
        return authCubit;
      },
      act: (cubit) => cubit.verifyUserOtp(
        email: 'john@example.com',
        otp: '123456',
        number: '+1234567890',
        password: 'password123',
      ),
      expect: () => [
        const AuthState.loading(),
        AuthState.success(testUser),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [loading, error] when verifyOtp fails',
      build: () {
        when(
          () => mockVerifyOtp.call(
            email: any(named: 'email'),
            otp: any(named: 'otp'),
            number: any(named: 'number'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => Left(DummyFailure('Incorrect OTP')));
        return authCubit;
      },
      act: (cubit) => cubit.verifyUserOtp(
        email: 'john@example.com',
        otp: '000000',
        number: '+1234567890',
        password: 'password123',
      ),
      expect: () => [
        const AuthState.loading(),
        const AuthState.error('Incorrect OTP'),
      ],
      // a wrong code never creates an account
      verify: (_) {
        verifyNever(
          () => mockSignUp.call(
            email: any(named: 'email'),
            password: any(named: 'password'),
            number: any(named: 'number'),
          ),
        );
      },
    );

    blocTest<AuthCubit, AuthState>(
      'emits [loading, error] when the code is right but the account cannot be created',
      build: () {
        when(
          () => mockVerifyOtp.call(
            email: any(named: 'email'),
            otp: any(named: 'otp'),
            number: any(named: 'number'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => Right(testUser));
        when(
          () => mockSignUp.call(
            email: any(named: 'email'),
            password: any(named: 'password'),
            number: any(named: 'number'),
          ),
        ).thenAnswer((_) async => Left(DummyFailure('Email in use')));
        return authCubit;
      },
      act: (cubit) => cubit.verifyUserOtp(
        email: 'john@example.com',
        otp: '123456',
        number: '+1234567890',
        password: 'password123',
      ),
      expect: () => [
        const AuthState.loading(),
        const AuthState.error('Email in use'),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'does nothing when already loading (double tap on Next)',
      seed: () => const AuthState.loading(),
      build: () => authCubit,
      act: (cubit) => cubit.verifyUserOtp(
        email: 'john@example.com',
        otp: '123456',
        number: '+1234567890',
        password: 'password123',
      ),
      expect: () => [],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [loading, error] when the account is created but login fails',
      build: () {
        when(
          () => mockVerifyOtp.call(
            email: any(named: 'email'),
            otp: any(named: 'otp'),
            number: any(named: 'number'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => Right(testUser));
        when(
          () => mockSignUp.call(
            email: any(named: 'email'),
            password: any(named: 'password'),
            number: any(named: 'number'),
          ),
        ).thenAnswer((_) async => Right(testUser));
        when(
          () => mockLogIn.call(
            email: any(named: 'email'),
            password: any(named: 'password'),
            remember: any(named: 'remember'),
          ),
        ).thenAnswer((_) async => Left(DummyFailure('Auto login failed')));
        return authCubit;
      },
      act: (cubit) => cubit.verifyUserOtp(
        email: 'john@example.com',
        otp: '123456',
        number: '+1234567890',
        password: 'password123',
      ),
      expect: () => [
        const AuthState.loading(),
        const AuthState.error('Auto login failed'),
      ],
    );
  });

  group('userForgotPassword', () {
    blocTest<AuthCubit, AuthState>(
      'emits [loading, initial] when forgotPassword succeeds',
      build: () {
        when(
          () => mockForgotPassword.call(email: 'john@example.com'),
        ).thenAnswer((_) async => const Right(unit));
        return authCubit;
      },
      act: (cubit) => cubit.userForgotPassword('john@example.com'),
      expect: () => [
        const AuthState.loading(),
        const AuthState.initial(),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [loading, error] when forgotPassword fails',
      build: () {
        when(
          () => mockForgotPassword.call(email: any(named: 'email')),
        ).thenAnswer((_) async => Left(DummyFailure('Email not found')));
        return authCubit;
      },
      act: (cubit) => cubit.userForgotPassword('unknown@example.com'),
      expect: () => [
        const AuthState.loading(),
        const AuthState.error('Email not found'),
      ],
    );
  });

  group('attemptSignOut', () {
    blocTest<AuthCubit, AuthState>(
      'emits [loading, initial] when signOut called',
      build: () {
        when(() => mockSignOut.call()).thenAnswer((_) async {});
        return authCubit;
      },
      act: (cubit) => cubit.attemptSignOut(),
      expect: () => [
        const AuthState.loading(),
        const AuthState.initial(),
      ],
      verify: (_) {
        verify(() => mockSignOut.call()).called(1);
      },
    );
  });

  group('attemptGetSavedCredentials', () {
    blocTest<AuthCubit, AuthState>(
      'emits [loading, loadedEmail] when credentials exist',
      build: () {
        when(
          () => mockGetSavedCredentials.call(),
        ).thenAnswer((_) async => 'saved@example.com');
        return authCubit;
      },
      act: (cubit) => cubit.attemptGetSavedCredentials(),
      expect: () => [
        const AuthState.loading(),
        const AuthState.loadedEmail('saved@example.com'),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [loading, initial] when credentials return null',
      build: () {
        when(
          () => mockGetSavedCredentials.call(),
        ).thenAnswer((_) async => null);
        return authCubit;
      },
      act: (cubit) => cubit.attemptGetSavedCredentials(),
      expect: () => [
        const AuthState.loading(),
        const AuthState.initial(),
      ],
    );
  });
}
