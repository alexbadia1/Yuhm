part of 'app_page_view_cubit.dart';

@immutable
abstract class AppPageViewState {}

/// Keep track of current app page view:
///   - HomePageView
///   - RestaurantPageView
///   - MenuPageView
class AppPageViewPosition extends AppPageViewState {

  /// Page Controller index:
  ///   - HomePageView = 0
  ///   - RestaurantPageView = 1
  ///   - MenuPageView = 2
  final int index;

  AppPageViewPosition(this.index);
}
