import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/error/exceptions.dart';

abstract class AuthLocalDataSource {
  Future<void> saveToken(String token);
  Future<void> saveRefreshToken(String token);
  Future<String> getToken();
  Future<void> saveDriverId(String id);
  Future<String> getDriverId();
  Future<void> setOnboardingDone();
  bool isOnboardingDone();
  Future<void> clearSession();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences prefs;
  final FlutterSecureStorage secureStorage;

  AuthLocalDataSourceImpl(this.prefs, this.secureStorage);

  @override
  Future<void> saveToken(String token) =>
      secureStorage.write(key: AppStrings.keyToken, value: token);

  @override
  Future<void> saveRefreshToken(String token) =>
      secureStorage.write(key: AppStrings.keyRefreshToken, value: token);

  @override
  Future<String> getToken() async {
    final token = await secureStorage.read(key: AppStrings.keyToken);
    if (token == null) throw const CacheException('No token cached');
    return token;
  }

  @override
  Future<void> saveDriverId(String id) =>
      secureStorage.write(key: AppStrings.keyDriverId, value: id);

  @override
  Future<String> getDriverId() async {
    final id = await secureStorage.read(key: AppStrings.keyDriverId);
    if (id == null) throw const CacheException('No driver id cached');
    return id;
  }

  @override
  Future<void> setOnboardingDone() =>
      prefs.setBool(AppStrings.keyOnboardingDone, true);

  @override
  bool isOnboardingDone() =>
      prefs.getBool(AppStrings.keyOnboardingDone) ?? false;

  @override
  Future<void> clearSession() async {
    await secureStorage.delete(key: AppStrings.keyToken);
    await secureStorage.delete(key: AppStrings.keyRefreshToken);
    await secureStorage.delete(key: AppStrings.keyDriverId);
  }
}
