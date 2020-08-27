import 'package:dio/dio.dart';
import 'package:nilva_image_super_list/repository/model/photo_model.dart';
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


Future<PhotosList> getPhotoList(int page, int limit) async {
  Response response;
  try {
    response = await DioClient().dio.get(BASE_URL + LIST,
        queryParameters: {
          "page": page,
          "limit": limit
        });
    if (response.statusCode == 200) {
      return PhotosList.fromJson(response.data);
    } else {
      return null;
    }
  } on DioError catch (error, stacktrace) {
    throw Exception("Exception occurred: $error stackTrace: $stacktrace");
  }
}
