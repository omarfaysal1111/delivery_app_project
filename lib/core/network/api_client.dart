import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../constants/api_constants.dart';
import '../error/exceptions.dart';

class ApiClient {
  final http.Client client;
  final String? token;

  ApiClient({required this.client, this.token});

  Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

  Future<Map<String, dynamic>> get(String endpoint,
      {Map<String, String>? queryParams}) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}$endpoint')
        .replace(queryParameters: queryParams);
    try {
      final response =
          await client.get(uri, headers: _headers).timeout(ApiConstants.timeout);
      return _handleResponse(response);
    } on SocketException {
      throw const ServerException('No internet connection');
    }
  }

  Future<Map<String, dynamic>> post(String endpoint,
      {Map<String, dynamic>? body}) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}$endpoint');
    try {
      final response = await client
          .post(uri, headers: _headers, body: jsonEncode(body))
          .timeout(ApiConstants.timeout);
      return _handleResponse(response);
    } on SocketException {
      throw const ServerException('No internet connection');
    }
  }

  Future<Map<String, dynamic>> put(String endpoint,
      {Map<String, dynamic>? body}) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}$endpoint');
    try {
      final response = await client
          .put(uri, headers: _headers, body: jsonEncode(body))
          .timeout(ApiConstants.timeout);
      return _handleResponse(response);
    } on SocketException {
      throw const ServerException('No internet connection');
    }
  }

  Future<void> delete(String endpoint) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}$endpoint');
    try {
      final response =
          await client.delete(uri, headers: _headers).timeout(ApiConstants.timeout);
      _handleResponse(response);
    } on SocketException {
      throw const ServerException('No internet connection');
    }
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    }
    final body = jsonDecode(response.body) as Map<String, dynamic>;
    throw ServerException(body['message'] ?? 'Server error ${response.statusCode}');
  }
}
