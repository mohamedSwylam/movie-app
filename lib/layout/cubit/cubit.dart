import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/layout/cubit/states.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/shared/network/remote/end_point.dart';
import 'package:movie_app/shared/network/remote/repository.dart';
import 'package:movie_app/shared/network/remote/web_services.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  Movie playingNowMovies ;
  void getPlayingNow() {
    emit(GetNowPlayingMoviesLoadingState());
    WebServices.getData(
      url: 'now_playing',
      query: {
        'api_key': 'a1ac2387d6e34edc9fb04a22d28198db',
        'language': 'en-US',
      },
    ).then((value) {
      playingNowMovies = Movie.fromJson(value.data);
      emit(GetNowPlayingMoviesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetNowPlayingMoviesErrorState(error.toString()));
    });
  }
}