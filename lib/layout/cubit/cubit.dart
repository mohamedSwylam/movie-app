import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/layout/cubit/states.dart';
import 'package:movie_app/models/genre.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/shared/network/remote/end_point.dart';
import 'package:movie_app/shared/network/remote/repository.dart';
import 'package:movie_app/shared/network/remote/web_services.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  Movie playingNowMovies;
  Future<Movie> getPlayingNow() {
    emit(GetNowPlayingMoviesLoadingState());
    WebServices.getData(
      url: GET_NOW_PLAYING,
      query: {
        'api_key': 'a1ac2387d6e34edc9fb04a22d28198db',
          'language': 'en-US',
      },
    ).then((value) {
      playingNowMovies = Movie.fromJson(value.data);
    /*  for(var item in playingNowMovies){
        playingNowMovies.add(Movie.fromJson(item));
      }*/
      emit(GetNowPlayingMoviesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetNowPlayingMoviesErrorState(error.toString()));
    });
  }

  Genre genre;
  Future<Genre> getGenre() {
    emit(GetGenreLoadingState());
    WebServices.getData(
      url: GET_GENRE,
      query: {
        'api_key': 'a1ac2387d6e34edc9fb04a22d28198db',
        'language': 'en-US',
      },
    ).then((value) {
      genre = Genre.fromJson(value.data);
      emit(GetGenreSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetGenreErrorState(error.toString()));
    });
  }



}