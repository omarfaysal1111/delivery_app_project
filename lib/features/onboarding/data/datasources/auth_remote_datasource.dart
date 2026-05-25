import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_client.dart';

abstract class AuthRemoteDataSource {
  Future<Map<String, dynamic>> sendOtp(String phone);
  Future<Map<String, dynamic>> verifyOtp(String phone, String otp);
  Future<Map<String, dynamic>> registerDriver(Map<String, dynamic> body);
  Future<String?> uploadMedia(String filePath);
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
      client.post(
        ApiConstants.registerDriver,
        body: body,
        debugLabel: 'REGISTER_DRIVER',
      );

  @override
  Future<String?> uploadMedia(String filePath) async {
    _debugUpload('START $filePath');
    try {
      final response = await client.postMultipartFile(
        ApiConstants.uploadMedia,
        filePath: filePath,
        debugLabel: 'UPLOAD_MEDIA',
      );
      final nestedData = response['data'];
      final candidates = [
        response['url'],
        response['link'],
        response['mediaUrl'],
        if (nestedData is Map<String, dynamic>) nestedData['url'],
        if (nestedData is Map<String, dynamic>) nestedData['link'],
        if (nestedData is Map<String, dynamic>) nestedData['mediaUrl'],
      ];
      for (final candidate in candidates) {
        if (candidate is String && candidate.trim().isNotEmpty) {
          final url = candidate.trim();
          _debugUpload('EXTRACTED_URL $url');
          return url;
        }
      }
      _debugUpload('EXTRACTED_URL null');
      return null;
    } catch (error) {
      _debugUpload('ERROR $error');
      _debugUpload('EXTRACTED_URL null');
      return null;
    }
  }

  @override
  Future<void> logout() => client.post(ApiConstants.logout);

  @override
  Future<Map<String, dynamic>> uploadDocument(
    String type,
    String filePath,
  ) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.documents}');
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

  // TODO: Remove temporary register-flow API logs before production release.
  void _debugUpload(String message) {
    if (kDebugMode) {
      debugPrint('[UPLOAD_MEDIA] $message');
    }
  }
}
