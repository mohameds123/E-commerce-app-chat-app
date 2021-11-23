import 'package:dio/dio.dart';
class DioHelperNews
{
  static late Dio dio;
  static init()
  {
    dio = Dio(
      BaseOptions(
        baseUrl:'https://newsapi.org/' ,
        receiveDataWhenStatusError: true,
      ),
    );
  }
  static Future<Response> getData({
    required String url,
    Map<String, dynamic>?query,
  })
  {
    return dio.get(
      url,
      queryParameters: query,
    );
  }
}