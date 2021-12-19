

import 'package:bloc/bloc.dart';
import 'package:movie_app/layout/cubit/states.dart';

class MovieAppCubit extends Cubit<MovieAppStates> {
  MovieAppCubit() : super(MovieInitialState());

  static MovieAppCubit get(context) => BlocProvider.of(context);

}


