import 'package:flutter/material.dart';
import 'package:yuhm/logic/logic.dart';
import 'package:yuhm/presentation/presentation.dart';

void main() => runApp(Yuhm());

class Yuhm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yuhm. App Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.white,
        textTheme: Theme.of(context).textTheme.apply(
              displayColor: kBlackColor,
            ),
      ),
      home: Scaffold(
        body: BlocProvider<RestaurantBloc>(
          create: (_) => RestaurantBloc(),
          child: Builder(builder: (_context) {
            return BlocProvider<AppPageViewCubit>(
              create: (_) => AppPageViewCubit(
                BlocProvider.of<RestaurantBloc>(_context),
              ),
              child: const YuhmPageView(),
            );
          }),
        ),
      ),
    );
  }
}

class YuhmPageView extends StatelessWidget {
  const YuhmPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: BlocProvider.of<AppPageViewCubit>(context).pageController,
      children: const [
        HomePage(),
        PinPage(),
        QrScanner(),
        RestaurantPage(),
        MenuPageView(),
      ],
    );
  }
}
