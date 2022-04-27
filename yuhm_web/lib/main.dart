import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuhm_web/logic/blocs/restaurant_bloc.dart';
import 'package:yuhm_web/logic/cubits/appbar_cubit.dart';

import 'presentation/landing_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider<RestaurantBloc>(
        create: (_) => RestaurantBloc(),
        child: BlocProvider<AppbarCubit>(
          create: (_) => AppbarCubit(),
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: LandingPage(),
          ),
        ),
      ),
    );
  }
}