import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';

abstract class MapRemoteDataSource {
  Future<List<dynamic>> getSurgeZones();
}

class MapRemoteDataSourceImpl implements MapRemoteDataSource {
  final ApiClient client;
  MapRemoteDataSourceImpl(this.client);

  @override
  Future<List<dynamic>> getSurgeZones() async {
    final res = await client.get(ApiConstants.surgeZones);
    return res['data'] as List<dynamic>;
  }
}
