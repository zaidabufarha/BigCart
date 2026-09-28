import 'package:big_cart/core/session/user_local_data_source.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  late MockSecureStorage secureStorage;
  late SharedPreferences prefs;
  late UserLocalDataSourceImpl session;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    secureStorage = MockSecureStorage();
    when(
      () => secureStorage.write(
        key: any(named: 'key'),
        value: any(named: 'value'),
      ),
    ).thenAnswer((_) async {});
    when(
      () => secureStorage.delete(key: any(named: 'key')),
    ).thenAnswer((_) async {});
    session = UserLocalDataSourceImpl(
      sharedPreferences: prefs,
      secureStorage: secureStorage,
    );
  });

  test('the token goes to secure storage, never to preferences', () async {
    await session.saveToken('jwt');

    verify(
      () => secureStorage.write(key: 'AUTH_TOKEN', value: 'jwt'),
    ).called(1);
    expect(prefs.getString('AUTH_TOKEN'), isNull);
    expect(await session.getToken(), 'jwt');
  });

  test('a token left in preferences by an older version is removed', () async {
    await prefs.setString('AUTH_TOKEN', 'old-plain-token');
    when(
      () => secureStorage.read(key: 'AUTH_TOKEN'),
    ).thenAnswer((_) async => null);

    expect(await session.getToken(), isNull);
    expect(prefs.getString('AUTH_TOKEN'), isNull);
  });

  test('the device is new until the first sign-in saves a token', () async {
    expect(await session.isFirstTime(), isTrue);
    await session.saveToken('jwt');
    expect(await session.isFirstTime(), isFalse);
  });

  test(
    'signing out clears the token and search history, and keeps the rest',
    () async {
      await session.saveToken('jwt');
      await session.saveEmail('zaid@example.com');
      await session.saveSearchHistory(['Organic']);

      await session.clearCache();

      verify(() => secureStorage.delete(key: 'AUTH_TOKEN')).called(1);
      expect(await session.getToken(), isNull);
      expect(await session.getSearchHistory(), isEmpty);
      expect(await session.isFirstTime(), isFalse);
      expect(await session.getSavedEmail(), 'zaid@example.com');
    },
  );
}
