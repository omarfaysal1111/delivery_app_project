import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exceptions.dart';

abstract class EarningsLocalDataSource {
  Future<void> cacheEarnings(String period, Map<String, dynamic> data);
  Map<String, dynamic> getCachedEarnings(String period);
}

class EarningsLocalDataSourceImpl implements EarningsLocalDataSource {
  final SharedPreferences prefs;
  EarningsLocalDataSourceImpl(this.prefs);

  String _key(String period) => 'cached_earnings_$period';

  @override
  Future<void> cacheEarnings(String period, Map<String, dynamic> data) =>
      prefs.setString(_key(period), jsonEncode(data));

  @override
  Map<String, dynamic> getCachedEarnings(String period) {
    final json = prefs.getString(_key(period));
    if (json == null) throw const CacheException('No cached earnings');
    return jsonDecode(json) as Map<String, dynamic>;
  }
}
