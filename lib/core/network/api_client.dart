import 'package:dio/dio.dart';

import '../constants/api_constants.dart';
import '../error/exceptions.dart';
import '../../features/onboarding/data/datasources/auth_local_datasource.dart';

class ApiClient {
  final Dio dio;

  ApiClient({required this.dio, required AuthLocalDataSource localDataSource}) {
    dio.options.baseUrl = ApiConstants.baseUrl;
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 30);

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          options.headers['Accept'] = 'application/json';
          options.headers['Content-Type'] = 'application/json';
          try {
            final token = await localDataSource.getToken();
            options.headers['Authorization'] = 'Bearer $token';
          } catch (_) {
            // No token, proceed without it
          }
          return handler.next(options);
        },
      ),
    );
    
    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        requestHeader: true,
        responseHeader: true,
        error: true,
      ),
    );
  }

  Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final response = await dio.get(
        endpoint,
        queryParameters: queryParams,
      );
      return _extractData(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Map<String, dynamic>> post(
    String endpoint, {
    Map<String, dynamic>? body,
  }) async {
    try {
      final response = await dio.post(
        endpoint,
        data: body,
      );
      return _extractData(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Map<String, dynamic>> postMultipartFile(
    String endpoint, {
    required String filePath,
    String fieldName = 'file',
    Map<String, dynamic>? additionalQuery,
  }) async {
    try {
      final formData = FormData.fromMap({
        fieldName: await MultipartFile.fromFile(filePath),
      });
      final response = await dio.post(
        endpoint,
        data: formData,
        queryParameters: additionalQuery,
      );
      return _extractData(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Map<String, dynamic>> put(
    String endpoint, {
    Map<String, dynamic>? body,
  }) async {
    try {
      final response = await dio.put(
        endpoint,
        data: body,
      );
      return _extractData(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<void> delete(String endpoint) async {
    try {
      await dio.delete(endpoint);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Map<String, dynamic> _extractData(dynamic data) {
    if (data is Map<String, dynamic>) return data;
    if (data == null || data.toString().isEmpty) return {};
    return {'data': data};
  }

  ServerException _handleDioError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.connectionError) {
      return const ServerException('No internet connection');
    }
    
    if (e.response != null && e.response?.data is Map<String, dynamic>) {
      final data = e.response?.data as Map<String, dynamic>;
      final message = data['message'] as String?;
      if (message != null) {
        return ServerException(message);
      }
    }
    return ServerException('Server error ${e.response?.statusCode ?? ''}');
  }
}
