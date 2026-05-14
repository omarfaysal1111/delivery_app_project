import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/error/exceptions.dart';

abstract class ProfileLocalDataSource {
  Future<void> cacheProfile(Map<String, dynamic> profile);
  Map<String, dynamic> getCachedProfile();
}

class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  final SharedPreferences prefs;
  ProfileLocalDataSourceImpl(this.prefs);

  @override
  Future<void> cacheProfile(Map<String, dynamic> profile) =>
      prefs.setString(AppStrings.keyCachedProfile, jsonEncode(profile));

  @override
  Map<String, dynamic> getCachedProfile() {
    final json = prefs.getString(AppStrings.keyCachedProfile);
    if (json == null) throw const CacheException('No cached profile');
    return jsonDecode(json) as Map<String, dynamic>;
  }
}
