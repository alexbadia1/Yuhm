import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'tab_page_selector_state.dart';

class TabPageSelectorCubit extends Cubit<TabPageSelectorState> {
  TabPageSelectorCubit() : super(TabPageSelectorDead());

  TabController? _tc;

  void setTabController(TabController tc) {
    if (_tc != null) { return; }
    _tc = tc;
    emit(TabPageSelectorAlive(index: 0, tc: _tc!));
  }

  void updateIndex(int index) {
    if (_tc != null) {
      _tc?.index = index;
    }
  }
}
