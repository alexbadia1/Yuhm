part of 'menu_sections_cubit.dart';

abstract class MenuSectionsState extends Equatable {
  final List<MenuSection> menuSections;
  const MenuSectionsState(this.menuSections);

  @override
  List<Object> get props => [menuSections];
}

class MenuSections extends MenuSectionsState {
  final List<MenuSection> newMenuSections;
  const MenuSections(this.newMenuSections) : super(newMenuSections);

  @override
  List<Object> get props => [newMenuSections];
}
