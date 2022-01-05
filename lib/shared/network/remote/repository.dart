/*

import 'package:movie_app/models/movie.dart';
import 'package:movie_app/shared/network/remote/web_services.dart';

class Repository {
  final WebServices webServices;

  Repository(this.webServices);

  Future<List<Movie>> getPlayingNow() {
    WebServices.getData(
      url: 'now_playing',
      query: {
        'api_key': 'a1ac2387d6e34edc9fb04a22d28198db',
        'language': 'en-US',
      },
    ).then((value) {
      value.data['results'].map((movie) => Movie.fromJson(movie)).toList();
      print(value.data['results']);
    }).catchError((error) {
      print(error.toString());
    });
  }

}*/
