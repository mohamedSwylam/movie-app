import 'package:dio/dio.dart';

import 'end_point.dart';

class WebServices {
  Dio dio;

  WebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3/movie/',
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000, // 60 seconds,
      receiveTimeout: 20 * 1000,
    );

    dio = Dio(options);
  }

  Future<List<dynamic>> getPlayingNow() async {
    try {
      Response response = await dio.get(GET_NOW_PLAYING, queryParameters: {
        'api_key': 'a1ac2387d6e34edc9fb04a22d28198db',
        'language': 'en-US',
        'page': 1
      });
      print(response.data.toString());
      return response.data;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List<dynamic>> getQuotes(String charName) async {
    try {
      Response response =
          await dio.get(GET_Quotes, queryParameters: {'author': charName});
      print(response.data.toString());
      return response.data;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
