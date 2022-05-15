import 'package:equatable/equatable.dart';

import 'menu_page.dart';

class Menu extends Equatable {
  /// Database PK.
  final String? id;

  /// Restaurant might have a "main" menu and a "wine" or "cocktail" menu.
  final String name;

  /// Brief details/summary about the menu.
  final String description;

  /// Images of each page of the menu.
  final List<MenuPage> menuPages;

  static const String indent = "\t\t";

  const Menu({
    this.id,
    required this.name,
    required this.description,
    required this.menuPages,
  });

  Menu.nullConstructor({
    this.id,
    this.name = "",
    this.description = "",
    this.menuPages = const <MenuPage>[],
  });

  copyWith(
      {String? id,
      String? name,
      String? description,
      List<MenuPage>? menuPages}) {
    return Menu(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      menuPages: menuPages ?? this.menuPages,
    );
  }

  @override
  String toString() {
    return '\n${indent}Menu {\n'
        '$indent\t"Doc Id": $id,\n'
        '$indent\t"Name": $name,\n'
        '$indent\t"Description": $description,\n'
        '$indent\t"MenuPages": ${menuPages.toString()},\n'
        '$indent}';
  }

  @override
  List<Object?> get props => [id, name, description, menuPages];
}
