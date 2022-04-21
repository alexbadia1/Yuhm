part of 'tab_page_selector_cubit.dart';

abstract class TabPageSelectorState extends Equatable {
  const TabPageSelectorState();
}

class TabPageSelectorDead extends TabPageSelectorState {
  @override
  List<Object> get props => [];
}

class TabPageSelectorAlive extends TabPageSelectorState {
  final int index;
  final TabController tc;
  const TabPageSelectorAlive({required this.index, required this.tc});

  @override
  List<Object> get props => [index, tc];
}

