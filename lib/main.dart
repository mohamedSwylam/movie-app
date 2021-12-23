import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/shared/bloc_observer.dart';
import 'package:movie_app/shared/network/remote/repository.dart';
import 'package:movie_app/shared/network/remote/web_services.dart';
import 'layout/app_layout.dart';
import 'layout/cubit/cubit.dart';
import 'layout/cubit/states.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  WebServices.init();
  runApp(MyApp());}
class MyApp extends StatelessWidget
{
  MyApp(){
    repository=Repository(WebServices());
  }
  Repository repository;
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AppCubit(repository)..getPlayingNow(),
        ),
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            title: 'BreakingBad',
            debugShowCheckedModeBanner: false,
            home: AppLayout(),
          );
        },
      ),
    );
  }
}
