import 'package:flutter/material.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MovieAppCubit, MovieAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MovieAppCubit.get(context);
        return Scaffold(

        );
      },
    );
  }
}
