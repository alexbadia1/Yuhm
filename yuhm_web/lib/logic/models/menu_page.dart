import 'dart:html';

import 'menu_section.dart';

/// A Menu consists of MenuPages that have a picture of the menu page [image]
/// and the sections attached to it.
class MenuPage {
  /// Database PK.
  final String? id;

  /// Picture of the menu
  final File? imageFile;

  /// Sections of the menuin the image. An image may have the border of two
  /// sections, in which multiple sections must be attached to it.
  final List<MenuSection> menuSections;

  const MenuPage({
    this.id,
    this.imageFile,
    required this.menuSections,
  });

  const MenuPage.nullConstructor({
    this.id,
    this.imageFile,
    this.menuSections = const <MenuSection>[],
  });

  copyWith({String? id, File? imageFile, List<MenuSection>? menuSections}) {
    return MenuPage(
      id: id ?? this.id,
      imageFile: imageFile ?? this.imageFile,
      menuSections: menuSections ?? this.menuSections,
    );
  }

  @override
  String toString() {
    return "MenuSection {\n"
        "\tDoc Id: $id\n"
        "\tImage File: $imageFile\n"
        "\tMenu Sections: ${menuSections.toString()}\n"
        "}\n";
  }
}
