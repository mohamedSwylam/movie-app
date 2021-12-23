import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/layout/cubit/states.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/shared/network/remote/end_point.dart';
import 'package:movie_app/shared/network/remote/repository.dart';
import 'package:movie_app/shared/network/remote/web_services.dart';

class AppCubit extends Cubit<AppStates> {
  Repository repository;
  List<Movie> playingNowMovies = [];
  AppCubit(repository) : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  List<Movie> getPlayingNow() {
    repository.getPlayingNow().then((value) {
      emit(GetNowPlayingMoviesSuccessState(value));
      playingNowMovies = value;
    });
    return playingNowMovies;
  }
}