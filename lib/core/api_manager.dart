import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'constants.dart' as AppConstants;
import 'dio_interceptor.dart';

@lazySingleton
class ApiManager {
  late final Dio _dio;

  ApiManager() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.BASEURL,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          "x-api-key": AppConstants.APIKEY,
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      ),
    );
    _setupInterceptors();
  }

  void _setupInterceptors() {
    _dio.interceptors.addAll([
      PrettyDioLogger(
        request: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
      ),
      MyInterceptor(),
    ]);
  }

  Future<Response> get(
      String url, {
        Map<String, dynamic>? queryParameters,
        Options? options,
      }) async {
    try {
      return await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> post(
      String url, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
      }) async {
    try {
      return await _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }



  Exception _handleError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return Exception("Request timed out. Please check your connection.");
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final message = e.response?.data?["message"] ?? "Unknown error";
        return Exception("Server error [$statusCode]: $message");
      case DioExceptionType.cancel:
        return Exception("Request was cancelled.");
      case DioExceptionType.connectionError:
        return Exception("No internet connection.");
      default:
        return Exception("Unexpected error: ${e.message}");
    }
  }
}