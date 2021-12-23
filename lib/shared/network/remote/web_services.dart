import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'end_point.dart';

class WebServices {
  static Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.themoviedb.org/3/movie/',
        receiveDataWhenStatusError: true,
      ),
    );
  }
  static Future<Response> getData({
    @required String url,
    @required Map <String, dynamic> query,
  }) async{
    return await dio.get(url, queryParameters: query,);
  }
}
