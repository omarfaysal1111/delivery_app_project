import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/error/exceptions.dart';

abstract class AuthLocalDataSource {
  Future<void> saveToken(String token);
  String getToken();
  Future<void> saveDriverId(String id);
  String getDriverId();
  Future<void> setOnboardingDone();
  bool isOnboardingDone();
  Future<void> clearSession();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences prefs;
  AuthLocalDataSourceImpl(this.prefs);

  @override
  Future<void> saveToken(String token) =>
      prefs.setString(AppStrings.keyToken, token);

  @override
  String getToken() {
    final token = prefs.getString(AppStrings.keyToken);
    if (token == null) throw const CacheException('No token cached');
    return token;
  }

  @override
  Future<void> saveDriverId(String id) =>
      prefs.setString(AppStrings.keyDriverId, id);

  @override
  String getDriverId() {
    final id = prefs.getString(AppStrings.keyDriverId);
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
    await prefs.remove(AppStrings.keyToken);
    await prefs.remove(AppStrings.keyDriverId);
  }
}
