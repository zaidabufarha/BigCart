import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserLocalDataSource {
  /// True until the first sign-in on this device; the welcome slides show only then.
  Future<bool> isFirstTime();

  /// Signs out on this device: the token and search history go, the
  /// first-time flag and remembered email stay.
  Future<Unit> clearCache();
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> clearToken();
  Future<void> saveEmail(String email);
  Future<String?> getSavedEmail();
  Future<void> clearSavedEmail();
  Future<List<String>> getSearchHistory();
  Future<void> saveSearchHistory(List<String> history);
}

// The session token is a credential, so it lives in the platform's secure
// storage (Keystore on Android, Keychain on iOS). Everything else here is a
// plain preference.
@LazySingleton(as: UserLocalDataSource)
class UserLocalDataSourceImpl implements UserLocalDataSource {
  final SharedPreferences sharedPreferences;
  final FlutterSecureStorage secureStorage;

  UserLocalDataSourceImpl({
    required this.sharedPreferences,
    required this.secureStorage,
  });

  static const _authTokenKey = 'AUTH_TOKEN';
  static const _firstTimeKey = 'FIRST_TIME';
  static const _savedEmailKey = 'SAVED_EMAIL';
  static const _searchHistoryKey = 'SEARCH_HISTORY';

  // every request reads the token, so keep it in memory after the first read
  String? _token;
  bool _tokenLoaded = false;

  @override
  Future<Unit> clearCache() async {
    await clearToken();
    await sharedPreferences.remove(_searchHistoryKey);
    return unit;
  }

  @override
  Future<bool> isFirstTime() async {
    return sharedPreferences.getBool(_firstTimeKey) ?? true;
  }

  @override
  Future<void> saveToken(String token) async {
    await secureStorage.write(key: _authTokenKey, value: token);
    _token = token;
    _tokenLoaded = true;
    // every way in (log in, sign up, Google) saves a token, so this is
    // where the device stops being new
    await sharedPreferences.setBool(_firstTimeKey, false);
  }

  @override
  Future<String?> getToken() async {
    if (!_tokenLoaded) {
      _token = await secureStorage.read(key: _authTokenKey);
      _tokenLoaded = true;
      // tokens used to be kept in plain preferences; don't leave one behind
      await sharedPreferences.remove(_authTokenKey);
    }
    return _token;
  }

  @override
  Future<void> clearToken() async {
    await secureStorage.delete(key: _authTokenKey);
    _token = null;
    _tokenLoaded = true;
  }

  @override
  Future<void> saveEmail(String email) async {
    await sharedPreferences.setString(_savedEmailKey, email);
  }

  @override
  Future<String?> getSavedEmail() async {
    return sharedPreferences.getString(_savedEmailKey);
  }

  @override
  Future<void> clearSavedEmail() async {
    await sharedPreferences.remove(_savedEmailKey);
  }

  @override
  Future<List<String>> getSearchHistory() async {
    return sharedPreferences.getStringList(_searchHistoryKey) ?? [];
  }

  @override
  Future<void> saveSearchHistory(List<String> history) async {
    await sharedPreferences.setStringList(_searchHistoryKey, history);
  }
}
