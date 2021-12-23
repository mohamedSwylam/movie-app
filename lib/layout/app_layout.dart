import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/shared/network/remote/repository.dart';
import 'package:movie_app/shared/network/remote/web_services.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class AppLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.cyan,
          appBar: AppBar(
            backgroundColor: Colors.cyan,
            elevation: 0.0,
            centerTitle: true,
            leading: Icon(EvaIcons.menu2Outline, color: Colors.white,),
            title: Text("Movie"),
            actions: <Widget>[
              IconButton(
                  onPressed: () {
                    print(Repository(WebServices()).getPlayingNow());
                  },
                  icon: Icon(EvaIcons.searchOutline, color: Colors.white,)
              )
            ],
          ),
          body: OfflineBuilder(
            connectivityBuilder: (
                BuildContext context,
                ConnectivityResult connectivity,
                Widget child,
                ) {
              final bool connected = connectivity != ConnectivityResult.none;

              if (connected) {
                return Column(
                  children: [

                  ],
                );
              } else {
                return buildNoInternetWidget();
              }
            },
            child: showLoadingIndicator(),
          ),
         );
      },
    );
  }
}


Widget showLoadingIndicator() {
  return Center(
    child: CircularProgressIndicator(
      color: Colors.yellow,
    ),
  );
}
Widget buildNoInternetWidget() {
  return Center(
    child: Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            'Can\'t connect .. check internet',
            style: TextStyle(
              fontSize: 22,
              color: Colors.black,
            ),
          ),
          Image.asset('assets/images/no_internet.png')
        ],
      ),
    ),
  );
}