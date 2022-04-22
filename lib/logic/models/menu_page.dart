import 'dart:typed_data';
import 'menu_section.dart';

/// A Menu consists of MenuPages that have a picture of the menu page [image]
/// and the sections attached to it.
class MenuPage {
  /// Database PK.
  final String? id;

  // TODO: Change back to Uint32List
  /// Picture of the menu
  final String? imageBytes;

  /// Sections of the menuin the image. An image may have the border of two
  /// sections, in which multiple sections must be attached to it.
  final List<MenuSection> menuSections;

  const MenuPage({
    this.id,
    this.imageBytes,
    required this.menuSections,
  });

  const MenuPage.nullConstructor({
    this.id = "[Menu Page Id]",
    this.imageBytes,
    this.menuSections = const <MenuSection>[],
  });

  copyWith({String? id, String? imageBytes, List<MenuSection>? menuSections}) {
    return MenuPage(
      id: id ?? this.id,
      imageBytes: imageBytes ?? this.imageBytes,
      menuSections: menuSections ?? this.menuSections,
    );
  }

  @override
  String toString() {
    return "MenuSection {\n"
        "\tDoc Id: $id\n"
        "\tImage Bytes: $imageBytes\n"
        "\tMenu Sections: ${menuSections.toString()}\n"
        "}\n";
  }
}
