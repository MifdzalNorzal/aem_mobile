import 'package:dio/dio.dart';
import '../config/constants.dart';
import 'storage_service.dart';

enum Method { get, post }

class ApiService {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: kBaseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );

  static Future<Response> request({
    required Method method,
    required String url,
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    final token = await SecureStorage.getString(kTokenKey);
    final options = Options(
      headers: {
        if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    return method == Method.get
        ? _dio.get(url, queryParameters: queryParameters, options: options)
        : _dio.post(url, data: data, options: options);
  }
}
