import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
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

  Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, String>? queryParams,
  }) async {
    final uri = Uri.parse(
      '${ApiConstants.baseUrl}$endpoint',
    ).replace(queryParameters: queryParams);
    try {
      final response = await client
          .get(uri, headers: _headers)
          .timeout(ApiConstants.timeout);
      return _handleResponse(response);
    } on SocketException {
      throw const ServerException('No internet connection');
    }
  }

  Future<Map<String, dynamic>> post(
    String endpoint, {
    Map<String, dynamic>? body,
    String? debugLabel,
  }) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}$endpoint');
    final requestBody = jsonEncode(body);
    _debugLog(debugLabel, 'START');
    _debugLog(debugLabel, 'URL $uri');
    _debugLog(debugLabel, 'REQUEST $requestBody');
    try {
      final response = await client
          .post(uri, headers: _headers, body: requestBody)
          .timeout(ApiConstants.timeout);
      _debugLog(debugLabel, 'STATUS ${response.statusCode}');
      _debugLog(debugLabel, 'RESPONSE ${_maskTokens(response.body)}');
      final result = _handleResponse(response);
      _debugLog(debugLabel, 'SUCCESS');
      return result;
    } catch (error) {
      _debugLog(debugLabel, 'FAILURE $error');
      if (error is SocketException) {
        throw const ServerException('No internet connection');
      }
      rethrow;
    }
  }

  Future<Map<String, dynamic>> postMultipartFile(
    String endpoint, {
    required String filePath,
    String fieldName = 'file',
    String? debugLabel,
  }) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}$endpoint');
    try {
      final request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          'Accept': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        })
        ..files.add(await http.MultipartFile.fromPath(fieldName, filePath));
      final streamed = await client.send(request).timeout(ApiConstants.timeout);
      final response = await http.Response.fromStream(streamed);
      _debugLog(debugLabel, 'END ${response.statusCode}');
      _debugLog(debugLabel, 'RESPONSE ${response.body}');
      return _handleResponse(response);
    } on SocketException {
      throw const ServerException('No internet connection');
    }
  }

  Future<Map<String, dynamic>> put(
    String endpoint, {
    Map<String, dynamic>? body,
  }) async {
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
      final response = await client
          .delete(uri, headers: _headers)
          .timeout(ApiConstants.timeout);
      _handleResponse(response);
    } on SocketException {
      throw const ServerException('No internet connection');
    }
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    }
    try {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      throw ServerException(
        body['message'] ?? 'Server error ${response.statusCode}',
      );
    } on FormatException {
      throw ServerException('Server error ${response.statusCode}');
    }
  }

  // TODO: Remove temporary register-flow API logs before production release.
  void _debugLog(String? label, String message) {
    if (kDebugMode && label != null) {
      debugPrint('[$label] $message');
    }
  }

  String _maskTokens(String body) {
    try {
      return jsonEncode(_maskTokenValues(jsonDecode(body)));
    } catch (_) {
      return body;
    }
  }

  Object? _maskTokenValues(Object? json) {
    if (json is Map<String, dynamic>) {
      return json.map((key, value) {
        if (key == 'accessToken' || key == 'refreshToken') {
          return MapEntry(key, '***');
        }
        return MapEntry(key, _maskTokenValues(value));
      });
    }
    if (json is List<dynamic>) {
      return json.map(_maskTokenValues).toList();
    }
    return json;
  }
}
