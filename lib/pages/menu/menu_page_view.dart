import 'package:flutter/material.dart';
import 'package:book_painter/book_painter.dart';
import 'package:yuhm/logic/logic.dart';

/// An interactive restaurant menu, where the user can just circle what they
/// want from the menu. Perhaps add underlines, strikeouts, and other markings
/// to convey extra or no toppings, etc.
class MenuPageView extends StatefulWidget {
  const MenuPageView({Key? key, required this.menuPages}) : super(key: key);
  final List<ImagePainter> menuPages;
  @override
  _MenuPageViewState createState() => _MenuPageViewState();
}

class _MenuPageViewState extends State<MenuPageView> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MenuPageViewCubit>(
      create: (_) => MenuPageViewCubit(),
      child: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: BlocProvider.of<MenuPageViewCubit>(context).pageController(),
        children: widget.menuPages,
      ),
    );
  }
}
