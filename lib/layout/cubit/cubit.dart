import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/layout/cubit/states.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/shared/network/remote/repository.dart';

class AppCubit extends Cubit<AppStates> {
  Repository repository;
  AppCubit(repository) : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  List<Movie> movies = [];
  List<Movie> getPlayingNow() {
    repository.getPlayingNow().then((movies) {
      emit(GetNowPlayingMoviesSuccessState(movies));
      this.movies = movies;
    });
    return movies;
  }
}
