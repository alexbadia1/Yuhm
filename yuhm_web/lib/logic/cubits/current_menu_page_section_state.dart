part of 'current_menu_page_section_cubit.dart';

abstract class CurrentMenuPageSectionState extends Equatable {
  final MenuSection menuSection;
  const CurrentMenuPageSectionState(this.menuSection);

  @override
  List<Object> get props => [menuSection];
}

class CurrentMenuPageSection extends CurrentMenuPageSectionState {
  final MenuSection newMenuSection;
  const CurrentMenuPageSection(this.newMenuSection)
      : super(newMenuSection);

  @override
  List<Object> get props => [newMenuSection];
}
