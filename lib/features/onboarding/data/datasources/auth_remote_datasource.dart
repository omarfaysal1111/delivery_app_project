import 'package:http/http.dart' as http;
import '../../../../core/constants/api_constants.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_client.dart';

abstract class AuthRemoteDataSource {
  Future<Map<String, dynamic>> sendOtp(String phone);
  Future<Map<String, dynamic>> verifyOtp(String phone, String otp);
  Future<Map<String, dynamic>> registerDriver(Map<String, dynamic> body);
  Future<void> logout();
  Future<Map<String, dynamic>> uploadDocument(String type, String filePath);
  Future<List<dynamic>> getDocuments();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient client;
  AuthRemoteDataSourceImpl(this.client);

  @override
  Future<Map<String, dynamic>> sendOtp(String phone) =>
      client.post(ApiConstants.sendOtp, body: {'phone': phone});

  @override
  Future<Map<String, dynamic>> verifyOtp(String phone, String otp) =>
      client.post(ApiConstants.verifyOtp, body: {'phone': phone, 'otp': otp});

  @override
  Future<Map<String, dynamic>> registerDriver(Map<String, dynamic> body) =>
      client.post(ApiConstants.register, body: body);

  @override
  Future<void> logout() => client.post(ApiConstants.logout);

  @override
  Future<Map<String, dynamic>> uploadDocument(
      String type, String filePath) async {
    final uri =
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.documents}');
    final request = http.MultipartRequest('POST', uri)
      ..fields['type'] = type
      ..files.add(await http.MultipartFile.fromPath('file', filePath));
    final streamed = await request.send();
    final response = await http.Response.fromStream(streamed);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return {'status': 'uploaded'};
    }
    throw ServerException('Document upload failed: ${response.statusCode}');
  }

  @override
  Future<List<dynamic>> getDocuments() async {
    final res = await client.get(ApiConstants.documents);
    return res['data'] as List<dynamic>;
  }
}
