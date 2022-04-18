import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

part 'app_page_view_state.dart';

class AppPageViewCubit extends Cubit<AppPageViewState> {
  static const int homePageIndex = 0;
  static const int restaurantPinPageIndex = 1;
  static const int qrScannerPageIndex = 2;
  static const int restaurantPageIndex = 3;
  static const int menuPageIndex = 4;
  final PageController _pageController = PageController(initialPage: homePageIndex, keepPage: true);

  AppPageViewCubit() : super(AppPageViewPosition(homePageIndex));

  void jumpToHomePage() {
    if (_pageController.hasClients) {
      _pageController.jumpToPage(homePageIndex);
      emit(AppPageViewPosition(homePageIndex));
    }
  }

  void jumpToRestaurantPinPage() {
    if (_pageController.hasClients) {
      _pageController.jumpToPage(restaurantPinPageIndex);
      emit(AppPageViewPosition(restaurantPinPageIndex));
    }
  }

  void jumpToQrScannerPage() {
    if (_pageController.hasClients) {
      _pageController.jumpToPage(qrScannerPageIndex);
      emit(AppPageViewPosition(qrScannerPageIndex));
    }
  }

  void jumpToRestaurantPage() {
    if (_pageController.hasClients) {
      _pageController.jumpToPage(restaurantPageIndex);
      emit(AppPageViewPosition(restaurantPageIndex));
    }
  }

  void jumpToMenuPage() {
    if (_pageController.hasClients) {
      _pageController.jumpToPage(menuPageIndex);
      emit(AppPageViewPosition(menuPageIndex));
    }
  }

  get pageController => _pageController;

  @override
  Future<void> close() {
    _pageController.dispose();
    return super.close();
  }
}
