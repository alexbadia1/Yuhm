import 'package:flutter/material.dart';
import 'package:yuhm/logic/logic.dart';
import 'package:book_painter/book_painter.dart';

/// An interactive restaurant menu, where the user can just circle what they
/// want from the menu. Perhaps add underlines, strikeouts, and other markings
/// to convey extra or no toppings, etc.
class MenuPageView extends StatefulWidget {
  const MenuPageView({Key? key}) : super(key: key);
  @override
  _MenuPageViewState createState() => _MenuPageViewState();
}

class _MenuPageViewState extends State<MenuPageView> {
  @override
  Widget build(BuildContext context) {
    final _state = BlocProvider.of<RestaurantBloc>(context).state;

    if (_state is RestaurantFetchSuccess) {
      List<ImagePainter> imagePainters = <ImagePainter>[];
      for (MenuPage mp in _state.restaurant.menus.first.menuPages) {
        imagePainters.add(
          ImagePainter.asset(
            mp.imageBytes ?? "beer.png",
            key: GlobalKey<ImagePainterState>(),
            scalable: true,
            initialStrokeWidth: 2,
            initialColor: Colors.deepOrangeAccent,
            initialPaintMode: PaintMode.freeStyle,
          ),
        );
      }
      return BlocProvider<MenuPageViewCubit>(
        create: (_) => MenuPageViewCubit(),
        child: Builder(builder: (_context) {
          return PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller:
                BlocProvider.of<MenuPageViewCubit>(_context).pageController,
            children: imagePainters,
          );
        }),
      );
    }
    return const SizedBox();
  }
}
