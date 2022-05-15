import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/menu_section.dart';

part 'current_menu_section_state.dart';

class CurrentMenuSectionCubit extends Cubit<CurrentMenuSectionState> {
  CurrentMenuSectionCubit()
      : super(const CurrentMenuSection(MenuSection.nullConstructor()));

  void updateMenuSection(MenuSection menuSection) {
    emit(CurrentMenuSection(menuSection));
  }
}
