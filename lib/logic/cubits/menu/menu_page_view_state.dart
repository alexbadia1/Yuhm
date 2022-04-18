part of 'menu_page_view_cubit.dart';

@immutable
abstract class MenuPageViewState {}

/// Keep track of current menu page view.
class MenuPageViewPosition extends MenuPageViewState {

  /// Menu page index.
  final int index;

  MenuPageViewPosition(this.index);
}