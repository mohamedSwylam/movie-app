import 'package:movie_app/models/movie.dart';

abstract class AppStates {}

class AppInitialState extends AppStates {}

class GetNowPlayingMoviesLoadingState extends AppStates {}

class GetNowPlayingMoviesSuccessState extends AppStates {
  final List<Movie> nowPlaying;

  GetNowPlayingMoviesSuccessState(this.nowPlaying);
}

class GetNowPlayingMoviesErrorState extends AppStates {
  final String error;

  GetNowPlayingMoviesErrorState(this.error);
}
