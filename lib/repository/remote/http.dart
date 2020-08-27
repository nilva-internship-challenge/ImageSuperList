import 'package:dio/dio.dart';
import 'package:nilva_image_super_list/repository/remote/url.dart';

class DioClient {
  static BaseOptions options = BaseOptions(
    baseUrl: BASE_URL,
    connectTimeout: 5000,
    receiveTimeout: 5000,
    responseType: ResponseType.json,
    followRedirects: false,
    receiveDataWhenStatusError: true,
  );

  static final DioClient _dioClient = DioClient._internal();
  Dio _dio = new Dio(options);

  Dio get dio => _dio;

  factory DioClient() {
    return _dioClient;
  }

  DioClient._internal() {
    _dio.interceptors.add(LogInterceptor(
      responseBody: true,
      request: false,
      requestHeader: false,
      responseHeader: false,
      requestBody: false,
      error: true,
    ));
  }
}