// lib/interceptors/auth_interceptor.dart
import 'package:dio/dio.dart';
import '../services/auth_service.dart';

class AuthInterceptor extends Interceptor {
  final AuthService _authService = AuthService();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _authService.getStoredToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    // Chama o próximo interceptor na cadeia
    handler.next(options);
  }
}