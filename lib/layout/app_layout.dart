import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/shared/network/remote/repository.dart';
import 'package:movie_app/shared/network/remote/web_services.dart';
import 'package:movie_app/shared/styles/color.dart';
import 'package:page_indicator/page_indicator.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class AppLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        PageController pageController =
        PageController(viewportFraction: 1, keepPage: true);
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
                    Container(
                  height: 220.0,
                  child: PageIndicatorContainer(
                    align: IndicatorAlign.bottom,
                    length: AppCubit.get(context).playingNowMovies.results.take(5).length,
                    indicatorSpace: 8.0,
                    padding: const EdgeInsets.all(5.0),
                    indicatorColor: titleColor,
                    indicatorSelectorColor: secondColor,
                    shape: IndicatorShape.circle(size: 5.0),
                    child: PageView.builder(
                      controller: pageController,
                      scrollDirection: Axis.horizontal,
                      itemCount: AppCubit.get(context).playingNowMovies.results.take(5).length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {},
                          child: Stack(
                            children: <Widget>[
                              Hero(
                                tag: AppCubit.get(context).playingNowMovies.results[index].id,
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 220.0,
                                  decoration: new BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    image: new DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            "https://image.tmdb.org/t/p/original/" +
                                                AppCubit.get(context).playingNowMovies.results[index].backdropPath)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      stops: [
                                        0.0,
                                        0.9
                                      ],
                                      colors: [
                                        mainColor.withOpacity(1.0),
                                        mainColor.withOpacity(0.0)
                                      ]),
                                ),
                              ),
                              Positioned(
                                bottom: 0.0,
                                top: 0.0,
                                left: 0.0,
                                right: 0.0,
                                child: Icon(
                                  FontAwesomeIcons.playCircle,
                                  color: secondColor,
                                  size: 40.0,
                                ),
                              ),
                              Positioned(
                                  bottom: 30.0,
                                  child: Container(
                                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                                    width: 250.0,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          AppCubit.get(context).playingNowMovies.results[index].title,
                                          style: TextStyle(
                                              height: 1.5,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0),
                                        ),
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
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