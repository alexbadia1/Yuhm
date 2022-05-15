import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/menu_section.dart';

part 'current_menu_page_section_state.dart';

class CurrentMenuPageSectionCubit extends Cubit<CurrentMenuPageSectionState> {
  CurrentMenuPageSectionCubit()
      : super(
            const CurrentMenuPageSection(MenuSection.nullConstructor()));

  void updateMenuSection(MenuSection menuSection) {
    emit(CurrentMenuPageSection(menuSection));
  }
}
