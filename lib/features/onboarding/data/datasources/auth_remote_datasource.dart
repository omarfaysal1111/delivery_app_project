import '../../../../core/network/api_client.dart';
import '../../../auth/data/models/verify_phone_otp_request.dart';

abstract class AuthRemoteDataSource {
  Future<Map<String, dynamic>> sendDriverLoginOtp(String phone);
  Future<Map<String, dynamic>> verifyDriverLoginOtp(String phone, String otp);
  Future<Map<String, dynamic>> registerDriver(Map<String, dynamic> data);
  Future<Map<String, dynamic>> uploadMedia(String filePath);
  Future<Map<String, dynamic>> uploadDriverDocument(
    String type,
    String filePath,
  );
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSourceImpl(this.apiClient);

  @override
  Future<Map<String, dynamic>> sendDriverLoginOtp(String phone) async {
    return apiClient.post('/api/v2/auth/otp/send', body: {'phone': phone});
  }

  @override
  Future<Map<String, dynamic>> verifyDriverLoginOtp(
    String phone,
    String otp,
  ) async {
    final request = VerifyPhoneOtpRequest(phone: phone, otp: otp);
    return apiClient.post('/api/v2/auth/otp/verify', body: request.toJson());
  }

  @override
  Future<Map<String, dynamic>> registerDriver(Map<String, dynamic> data) async {
    return apiClient.post('/api/v1/auth/register/driver', body: data);
  }

  @override
  Future<Map<String, dynamic>> uploadMedia(String filePath) async {
    return apiClient.postMultipartFile(
      '/api/v1/media/upload',
      filePath: filePath,
      fieldName: 'file',
    );
  }

  @override
  Future<Map<String, dynamic>> uploadDriverDocument(
    String type,
    String filePath,
  ) async {
    return apiClient.postMultipartFile(
      '/api/v1/driver/documents',
      filePath: filePath,
      fieldName: 'file',
      additionalQuery: {'type': type},
    );
  }
}
