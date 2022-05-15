part of 'current_menu_section_cubit.dart';

abstract class CurrentMenuSectionState extends Equatable {
  final MenuSection menuSection;
  const CurrentMenuSectionState(this.menuSection);

  @override
  List<Object> get props => [menuSection];
}

class CurrentMenuSection extends CurrentMenuSectionState {
  final MenuSection newMenuSection;
  const CurrentMenuSection(this.newMenuSection) : super(newMenuSection);

  @override
  List<Object> get props => [newMenuSection];
}
