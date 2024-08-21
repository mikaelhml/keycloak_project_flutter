import 'package:dio/dio.dart';
import '../interceptors/auth_interceptor.dart';

class DioClient {
  final Dio _dio;

  DioClient() : _dio = Dio() {
    _dio.interceptors.add(AuthInterceptor());
  }

  Dio get client => _dio;
}