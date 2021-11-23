import 'package:dio/dio.dart';
import 'package:flutter_nwesapp/network/end_point.dart';
class DioHelper
{
  static late Dio dio;
  static init()
  {
    dio = Dio(
      BaseOptions(
        baseUrl:BASEURL,
        receiveDataWhenStatusError: true,
      ),
    );
  }
  static Future<Response> PostData({
    required url,
    required Map<String , dynamic>data,
    String?token,
}) async {
    dio.options.headers={
      'lang' : 'ar',
      'content-Type':'application/json',
      'Authorization':token??'',
    };
    return dio.post(
      url,
      data: data,
    );
  }
  static Future<Response> GetData({
    required String url,
    String ?token,
    Map<String, dynamic>?query,
  })
  {
    dio.options.headers={
      'lang' : 'ar',
      'content-Type':'application/json',
      'Authorization':token??'',
    };
    return dio.get(
      url,
      queryParameters: query,
    );
  }
}