
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/shared/network/remote/web_services.dart';

class Repository {
  final WebServices webServices;

  Repository(this.webServices);
  Future<List<Movie>> getPlayingNow() async {
    final movies = await webServices.getPlayingNow();
    return movies.map((movie) => Movie.fromJson(movie)).toList();
  }

}

