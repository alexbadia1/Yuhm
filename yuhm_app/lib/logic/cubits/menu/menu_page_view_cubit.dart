import 'package:yuhm_app/logic/logic.dart';
import 'package:flutter/material.dart';

part 'menu_page_view_state.dart';

class MenuPageViewCubit extends Cubit<MenuPageViewState> {
  MenuPageViewCubit(this.initialPage)
      : super(MenuPageViewPosition(initialPage)) {
    _pageController = PageController(initialPage: initialPage, keepPage: true);
  }
  final int initialPage;
  final Curve _curve = Curves.easeIn;
  late final PageController _pageController;
  final Duration _duration = const Duration(milliseconds: 150);

  void animateLeft() {
    _pageController.previousPage(duration: _duration, curve: _curve);
  }

  void animateRight() {
    _pageController.nextPage(duration: _duration, curve: _curve);
  }

  void setIndex(int index) {
    _pageController.jumpToPage(index);
  }

  get pageController => _pageController;

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
