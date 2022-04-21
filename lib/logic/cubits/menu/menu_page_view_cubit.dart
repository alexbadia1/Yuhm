import 'package:yuhm/logic/logic.dart';
import 'package:flutter/material.dart';

part 'menu_page_view_state.dart';

class MenuPageViewCubit extends Cubit<MenuPageViewState> {

  MenuPageViewCubit() : super(MenuPageViewPosition(0));

  final Curve _curve = Curves.easeIn;
  final Duration _duration = const Duration(milliseconds: 150);
  final PageController _pageController = PageController(initialPage: 0, keepPage: true);

  void animateLeft() {
    _pageController.previousPage(duration: _duration, curve: _curve);
  }

  void animateRight() {
    _pageController.nextPage(duration: _duration, curve: _curve);
  }

  get pageController => _pageController;

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
