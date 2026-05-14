import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';

abstract class ProfileRemoteDataSource {
  Future<Map<String, dynamic>> getProfile();
  Future<Map<String, dynamic>> updateProfile(Map<String, dynamic> body);
  Future<void> updatePayoutDetails(Map<String, dynamic> body);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ApiClient client;
  ProfileRemoteDataSourceImpl(this.client);

  @override
  Future<Map<String, dynamic>> getProfile() =>
      client.get(ApiConstants.profile);

  @override
  Future<Map<String, dynamic>> updateProfile(Map<String, dynamic> body) =>
      client.put(ApiConstants.profile, body: body);

  @override
  Future<void> updatePayoutDetails(Map<String, dynamic> body) =>
      client.put(ApiConstants.payout, body: body);
}
