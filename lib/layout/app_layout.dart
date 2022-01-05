import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app/models/genre.dart';
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
        var cubit = AppCubit.get(context);
        TabController _tabController;
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              print(cubit.playingNowMovies);
            },
          ),
          backgroundColor: Colors.cyan,
          appBar: AppBar(
            backgroundColor: Colors.cyan,
            elevation: 0.0,
            centerTitle: true,
            leading: Icon(
              EvaIcons.menu2Outline,
              color: Colors.white,
            ),
            title: Text("Movie"),
            actions: <Widget>[
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    EvaIcons.searchOutline,
                    color: Colors.white,
                  ))
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
                      height: 200.0,
                      child: PageIndicatorContainer(
                        align: IndicatorAlign.bottom,
                        length: AppCubit.get(context)
                            .playingNowMovies
                            .results
                            .take(5)
                            .length,
                        indicatorSpace: 8.0,
                        padding: const EdgeInsets.all(5.0),
                        indicatorColor: titleColor,
                        indicatorSelectorColor: secondColor,
                        shape: IndicatorShape.circle(size: 5.0),
                        child: PageView.builder(
                          controller: pageController,
                          scrollDirection: Axis.horizontal,
                          itemCount: AppCubit.get(context)
                              .playingNowMovies
                              .results
                              .take(5)
                              .length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {},
                              child: Stack(
                                children: <Widget>[
                                  Hero(
                                    tag: AppCubit.get(context)
                                        .playingNowMovies
                                        .results[index]
                                        .id,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 220.0,
                                      decoration: new BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        image: new DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                "https://image.tmdb.org/t/p/original/" +
                                                    AppCubit.get(context)
                                                        .playingNowMovies
                                                        .results[index]
                                                        .backdropPath)),
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
                                        padding: EdgeInsets.only(
                                            left: 10.0, right: 10.0),
                                        width: 250.0,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              AppCubit.get(context)
                                                  .playingNowMovies
                                                  .results[index]
                                                  .title,
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
                    Container(
                      height: 307.0,
                      child: DefaultTabController(
                          length: cubit.genre.genres.length,
                          child: Scaffold(
                            backgroundColor: Colors.cyan,
                            appBar: PreferredSize(
                              preferredSize: Size.fromHeight(50.0),
                              child: AppBar(
                                backgroundColor: Colors.cyan,
                                elevation: 0.0,
                                bottom: TabBar(
                                  controller: _tabController,
                                  indicatorColor: secondColor,
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  indicatorWeight: 3.0,
                                  unselectedLabelColor: titleColor,
                                  labelColor: Colors.white,
                                  isScrollable: true,
                                  tabs: cubit.genre.genres.map((genre) {
                                    return Container(
                                        padding: EdgeInsets.only(
                                            bottom: 15.0, top: 10.0),
                                        child:
                                            new Text(genre.name.toUpperCase(),
                                                style: TextStyle(
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.bold,
                                                )));
                                  }).toList(),
                                ),
                              ),
                            ),
                            body: TabBarView(
                              controller: _tabController,
                              physics: NeverScrollableScrollPhysics(),
                              children: cubit.genre.genres.map((genre) {
                                return Container(
                                  height: 270.0,
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        cubit.playingNowMovies.results.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                            top: 10.0,
                                            bottom: 10.0,
                                            right: 15.0),
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              cubit
                                                          .playingNowMovies
                                                          .results[index]
                                                          .posterPath ==
                                                      null
                                                  ? Hero(
                                                      tag: cubit
                                                          .playingNowMovies
                                                          .results[index]
                                                          .id,
                                                      child: Container(
                                                        width: 120.0,
                                                        height: 180.0,
                                                        decoration:
                                                            new BoxDecoration(
                                                          color: secondColor,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          2.0)),
                                                          shape: BoxShape
                                                              .rectangle,
                                                        ),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            Icon(
                                                              EvaIcons
                                                                  .filmOutline,
                                                              color:
                                                                  Colors.white,
                                                              size: 60.0,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  : Hero(
                                                      tag: cubit
                                                          .playingNowMovies
                                                          .results[index]
                                                          .id,
                                                      child: Container(
                                                          width: 120.0,
                                                          height: 180.0,
                                                          decoration:
                                                              new BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            2.0)),
                                                            shape: BoxShape
                                                                .rectangle,
                                                            image: new DecorationImage(
                                                                fit: BoxFit
                                                                    .cover,
                                                                image: NetworkImage("https://image.tmdb.org/t/p/w200/" +
                                                                    cubit
                                                                        .playingNowMovies
                                                                        .results[
                                                                            index]
                                                                        .posterPath)),
                                                          )),
                                                    ),
                                              SizedBox(
                                                height: 10.0,
                                              ),
                                              Container(
                                                width: 100,
                                                child: Text(
                                                  cubit.playingNowMovies
                                                      .results[index].title,
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                      height: 1.4,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 11.0),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    cubit.playingNowMovies
                                                        .results[index]
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10.0,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    width: 5.0,
                                                  ),
                                                  RatingBar(
                                                    ratingWidget: RatingWidget(
                                                      empty: Icon(
                                                        EvaIcons.star,
                                                        color: secondColor,
                                                      ),
                                                      full: Icon(
                                                        EvaIcons.star,
                                                        color: secondColor,
                                                      ),
                                                      half: Icon(
                                                        EvaIcons.star,
                                                        color: secondColor,
                                                      ),
                                                    ),
                                                    itemSize: 8.0,
                                                    initialRating: cubit
                                                            .playingNowMovies
                                                            .results[index]
                                                            .voteAverage /
                                                        2,
                                                    minRating: 1,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    itemPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 2.0),
                                                    onRatingUpdate: (rating) {
                                                      print(rating);
                                                    },
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }).toList(),
                            ),
                          )),
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

/*Container(
height: 270.0,
padding: EdgeInsets.only(left: 10.0),
child: ListView.builder(
scrollDirection: Axis.horizontal,
itemCount: cubit.playingNowMovies.results.length,
itemBuilder: (context, index) {
return Padding(
padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 15.0),
child: GestureDetector(
onTap: () {},
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: <Widget>[
cubit.playingNowMovies.results[index].posterPath == null
? Hero(
tag: cubit.playingNowMovies.results[index].id,
child: Container(
width: 120.0,
height: 180.0,
decoration: new BoxDecoration(
color: secondColor,
borderRadius:
BorderRadius.all(Radius.circular(2.0)),
shape: BoxShape.rectangle,
),
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: <Widget>[
Icon(
EvaIcons.filmOutline,
color: Colors.white,
size: 60.0,
)
],
),
),
)
    : Hero(
tag: cubit.playingNowMovies.results[index].id,
child: Container(
width: 120.0,
height: 180.0,
decoration: new BoxDecoration(
borderRadius:
BorderRadius.all(Radius.circular(2.0)),
shape: BoxShape.rectangle,
image: new DecorationImage(
fit: BoxFit.cover,
image: NetworkImage(
"https://image.tmdb.org/t/p/w200/" +
cubit.playingNowMovies.results[index].posterPath)),
)),
),
SizedBox(
height: 10.0,
),
Container(
width: 100,
child: Text(
cubit.playingNowMovies.results[index].title,
maxLines: 2,
style: TextStyle(
height: 1.4,
color: Colors.white,
fontWeight: FontWeight.bold,
fontSize: 11.0),
),
),
SizedBox(
height: 5.0,
),
Row(
crossAxisAlignment: CrossAxisAlignment.center,
children: <Widget>[
Text(
cubit.playingNowMovies.results[index].toString(),
style: TextStyle(
color: Colors.white,
fontSize: 10.0,
fontWeight: FontWeight.bold),
),
SizedBox(
width: 5.0,
),
RatingBar(
ratingWidget: RatingWidget(
empty: Icon(
EvaIcons.star,
color: secondColor,
),
full: Icon(
EvaIcons.star,
color: secondColor,
),
half: Icon(
EvaIcons.star,
color: secondColor,
),
),
itemSize: 8.0,
initialRating: cubit.playingNowMovies.results[index].voteAverage / 2,
minRating: 1,
direction: Axis.horizontal,
allowHalfRating: true,
itemCount: 5,
itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
onRatingUpdate: (rating) {
print(rating);
},
)
],
)
],
),
),
);
},
),
),*/
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

Widget buildMovieItem(Results model) {
  return Padding(
    padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 15.0),
    child: GestureDetector(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          model.posterPath == null
              ? Hero(
                  tag: model.id,
                  child: Container(
                    width: 120.0,
                    height: 180.0,
                    decoration: new BoxDecoration(
                      color: secondColor,
                      borderRadius: BorderRadius.all(Radius.circular(2.0)),
                      shape: BoxShape.rectangle,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          EvaIcons.filmOutline,
                          color: Colors.white,
                          size: 60.0,
                        )
                      ],
                    ),
                  ),
                )
              : Hero(
                  tag: model.id,
                  child: Container(
                      width: 120.0,
                      height: 180.0,
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(2.0)),
                        shape: BoxShape.rectangle,
                        image: new DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                "https://image.tmdb.org/t/p/w200/" +
                                    model.posterPath)),
                      )),
                ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            width: 100,
            child: Text(
              model.title,
              maxLines: 2,
              style: TextStyle(
                  height: 1.4,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 11.0),
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                model.voteAverage.toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 5.0,
              ),
              RatingBar(
                ratingWidget: RatingWidget(
                  empty: Icon(
                    EvaIcons.star,
                    color: secondColor,
                  ),
                  full: Icon(
                    EvaIcons.star,
                    color: secondColor,
                  ),
                  half: Icon(
                    EvaIcons.star,
                    color: secondColor,
                  ),
                ),
                itemSize: 8.0,
                initialRating: model.voteAverage / 2,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              )
            ],
          )
        ],
      ),
    ),
  );
}
