import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  Future<void> saveTokens(String accessToken, String refreshToken);
  Future<void> saveToken(String token);
  Future<void> saveRefreshToken(String token);
  Future<String> getToken();
  Future<String> getRefreshToken();
  Future<void> clearTokens();
  Future<void> clearSession();
  Future<void> saveDriverId(String driverId);
  Future<String> getDriverId();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final FlutterSecureStorage secureStorage;
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl({
    required this.secureStorage,
    required this.sharedPreferences,
  });

  static const _keyToken = 'access_token';
  static const _keyRefreshToken = 'refresh_token';
  static const _keyDriverId = 'driver_id';

  @override
  Future<void> saveTokens(String accessToken, String refreshToken) async {
    await saveToken(accessToken);
    await saveRefreshToken(refreshToken);
  }

  @override
  Future<void> saveToken(String token) async {
    await secureStorage.write(key: _keyToken, value: token);
  }

  @override
  Future<void> saveRefreshToken(String token) async {
    await secureStorage.write(key: _keyRefreshToken, value: token);
  }

  @override
  Future<String> getToken() async {
    final token = await secureStorage.read(key: _keyToken);
    if (token != null) return token;
    throw Exception('Token not found');
  }

  @override
  Future<String> getRefreshToken() async {
    final token = await secureStorage.read(key: _keyRefreshToken);
    if (token != null) return token;
    throw Exception('Refresh token not found');
  }

  @override
  Future<void> clearTokens() async {
    await secureStorage.delete(key: _keyToken);
    await secureStorage.delete(key: _keyRefreshToken);
  }

  @override
  Future<void> clearSession() async {
    await clearTokens();
    await sharedPreferences.remove(_keyDriverId);
  }

  @override
  Future<void> saveDriverId(String driverId) async {
    await sharedPreferences.setString(_keyDriverId, driverId);
  }

  @override
  Future<String> getDriverId() async {
    final driverId = sharedPreferences.getString(_keyDriverId);
    if (driverId != null) return driverId;
    throw Exception('Driver ID not found');
  }
}
