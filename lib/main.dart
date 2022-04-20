import 'package:flutter/material.dart';
import 'package:yuhm/logic/logic.dart';
import 'package:book_painter/book_painter.dart';
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
        body: BlocProvider<AppPageViewCubit>(
            create: (context) => AppPageViewCubit(),
            child: const YuhmPageView()),
      ),
    );
  }
}

class YuhmPageView extends StatelessWidget {
  const YuhmPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _imageKey1 = GlobalKey<ImagePainterState>();
    final _imageKey2 = GlobalKey<ImagePainterState>();
    final _imageKey3 = GlobalKey<ImagePainterState>();

    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: BlocProvider.of<AppPageViewCubit>(context).pageController,
      children: [
        const HomePage(),
        const RestaurantPinPage(),
        const QrScanner(),
        const RestaurantPage(),
        MenuPageView(
          menuPages: [
            ImagePainter.asset(
              "assets/tall_image.png",
              key: _imageKey1,
              scalable: true,
              initialStrokeWidth: 2,
              initialColor: Colors.green,
              initialPaintMode: PaintMode.freeStyle,
            ),
            ImagePainter.asset(
              "assets/tall_image.png",
              key: _imageKey2,
              scalable: true,
              initialStrokeWidth: 2,
              initialColor: Colors.green,
              initialPaintMode: PaintMode.freeStyle,
            ),
            ImagePainter.asset(
              "assets/tall_image.png",
              key: _imageKey3,
              scalable: true,
              initialStrokeWidth: 2,
              initialColor: Colors.green,
              initialPaintMode: PaintMode.freeStyle,
            ),
          ],
        ),
      ],
    );
  }
}
