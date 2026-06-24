import 'package:dio/dio.dart';
import '../storage/storage_service.dart';

class ApiService {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://test-demo.aemenersol.com/api',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  static Dio get dio {
    _dio.interceptors.clear();
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await StorageService.getToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onError: (error, handler) {
          handler.next(error);
        },
      ),
    );
    return _dio;
  }
}
