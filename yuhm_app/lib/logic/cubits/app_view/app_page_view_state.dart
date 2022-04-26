part of 'app_page_view_cubit.dart';

@immutable
abstract class AppPageViewState extends Equatable {}

/// Keep track of current app page view:
///   - HomePageView
///   - RestaurantPageView
///   - MenuPageView
class AppPageViewPosition extends AppPageViewState {

  /// Page Controller index:
  ///   - HomePageView = 0
  ///   - RestaurantPageView = 1
  ///   - MenuPageView = 2
  final int appPageViewIndex;
  final int initialMenuPage;

  AppPageViewPosition(this.appPageViewIndex, this.initialMenuPage);

  @override
  List<Object?> get props => [appPageViewIndex, initialMenuPage];
}