import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exceptions.dart';

abstract class OrderLocalDataSource {
  Future<void> cacheActiveOrder(Map<String, dynamic> order);
  Map<String, dynamic> getCachedActiveOrder();
  Future<void> clearActiveOrder();
}

class OrderLocalDataSourceImpl implements OrderLocalDataSource {
  final SharedPreferences prefs;
  static const _key = 'cached_active_order';
  OrderLocalDataSourceImpl(this.prefs);

  @override
  Future<void> cacheActiveOrder(Map<String, dynamic> order) =>
      prefs.setString(_key, jsonEncode(order));

  @override
  Map<String, dynamic> getCachedActiveOrder() {
    final json = prefs.getString(_key);
    if (json == null) throw const CacheException('No cached active order');
    return jsonDecode(json) as Map<String, dynamic>;
  }

  @override
  Future<void> clearActiveOrder() => prefs.remove(_key);
}
