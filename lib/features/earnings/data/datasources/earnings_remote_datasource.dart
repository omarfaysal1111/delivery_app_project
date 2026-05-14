import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';

abstract class EarningsRemoteDataSource {
  Future<Map<String, dynamic>> getEarnings(String period);
  Future<List<dynamic>> getEarningsHistory(
      {String? from, String? to});
  Future<List<dynamic>> getIncentives();
  Future<Map<String, dynamic>> getPerformance();
  Future<void> requestWithdrawal();
}

class EarningsRemoteDataSourceImpl implements EarningsRemoteDataSource {
  final ApiClient client;
  EarningsRemoteDataSourceImpl(this.client);

  @override
  Future<Map<String, dynamic>> getEarnings(String period) =>
      client.get(ApiConstants.earnings, queryParams: {'period': period});

  @override
  Future<List<dynamic>> getEarningsHistory({String? from, String? to}) async {
    final res = await client.get(ApiConstants.earningsHistory,
        queryParams: {if (from != null) 'from': from, if (to != null) 'to': to});
    return res['data'] as List<dynamic>;
  }

  @override
  Future<List<dynamic>> getIncentives() async {
    final res = await client.get(ApiConstants.incentives);
    return res['data'] as List<dynamic>;
  }

  @override
  Future<Map<String, dynamic>> getPerformance() =>
      client.get(ApiConstants.performance);

  @override
  Future<void> requestWithdrawal() => client.post(ApiConstants.withdrawal);
}
