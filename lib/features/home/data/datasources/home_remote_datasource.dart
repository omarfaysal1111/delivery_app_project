import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';

abstract class HomeRemoteDataSource {
  Future<Map<String, dynamic>> getTodayStats();
  Future<Map<String, dynamic>> toggleOnlineStatus(bool isOnline);
  Future<List<dynamic>> getShifts();
  Future<Map<String, dynamic>> bookShift(Map<String, dynamic> body);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiClient client;
  HomeRemoteDataSourceImpl(this.client);

  @override
  Future<Map<String, dynamic>> getTodayStats() =>
      client.get(ApiConstants.todayStats);

  @override
  Future<Map<String, dynamic>> toggleOnlineStatus(bool isOnline) =>
      client.post(ApiConstants.driverStatus, body: {'is_online': isOnline});

  @override
  Future<List<dynamic>> getShifts() async {
    final res = await client.get(ApiConstants.shifts);
    return res['data'] as List<dynamic>;
  }

  @override
  Future<Map<String, dynamic>> bookShift(Map<String, dynamic> body) =>
      client.post(ApiConstants.shifts, body: body);
}
