import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yuhm_web/logic/models/menu_section.dart';

part 'menu_sections_state.dart';

class MenuSectionsCubit extends Cubit<MenuSectionsState> {
  MenuSectionsCubit() : super(const MenuSections(<MenuSection>[]));

  void updateMenuSections(List<MenuSection> menuSections) {
    emit(MenuSections(menuSections));
  }
}
