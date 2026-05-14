import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/error/exceptions.dart';

abstract class HomeLocalDataSource {
  Future<void> cacheStats(Map<String, dynamic> stats);
  Map<String, dynamic> getCachedStats();
  Future<void> cacheOnlineStatus(bool isOnline);
  bool getOnlineStatus();
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  final SharedPreferences prefs;
  HomeLocalDataSourceImpl(this.prefs);

  @override
  Future<void> cacheStats(Map<String, dynamic> stats) =>
      prefs.setString(AppStrings.keyCachedStats, jsonEncode(stats));

  @override
  Map<String, dynamic> getCachedStats() {
    final json = prefs.getString(AppStrings.keyCachedStats);
    if (json == null) throw const CacheException('No cached stats');
    return jsonDecode(json) as Map<String, dynamic>;
  }

  @override
  Future<void> cacheOnlineStatus(bool isOnline) =>
      prefs.setBool(AppStrings.keyIsOnline, isOnline);

  @override
  bool getOnlineStatus() => prefs.getBool(AppStrings.keyIsOnline) ?? false;
}
