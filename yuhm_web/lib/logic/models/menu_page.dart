import 'dart:typed_data';

import 'package:equatable/equatable.dart';

import 'menu_section.dart';

/// A Menu consists of MenuPages that have a picture of the menu page [image]
/// and the sections attached to it.
class MenuPage extends Equatable {
  /// Database PK.
  final String? id;

  /// Picture of the menu
  final Uint8List? imageBytes;

  /// Sections of the menuin the image. An image may have the border of two
  /// sections, in which multiple sections must be attached to it.
  final List<MenuSection> menuSections;

  static const String indent = "\t\t\t";
  const MenuPage({
    this.id,
    this.imageBytes,
    required this.menuSections,
  });

  const MenuPage.nullConstructor({
    this.id,
    this.imageBytes,
    this.menuSections = const <MenuSection>[],
  });

  copyWith({String? id, Uint8List? imageBytes, List<MenuSection>? menuSections}) {
    return MenuPage(
      id: id ?? this.id,
      imageBytes: imageBytes ?? this.imageBytes,
      menuSections: menuSections ?? this.menuSections,
    );
  }

  @override
  String toString() {
    String imageBytesText = "";
    if (imageBytes == null) {
      imageBytesText = "";
    } else if (imageBytes!.length > 25) {
      imageBytesText = "${imageBytes.toString().substring(0, 24)}...]";
    }

    return '\n${indent}Menu Page {\n'
        '$indent\t"Doc Id": $id,\n'
        '$indent\t"Image Bytes": $imageBytesText,\n'
        '$indent\t"Menu Sections": ${menuSections.toString()},\n'
        '$indent}\n';
  }

  @override
  List<Object?> get props => [id, imageBytes, menuSections];
}
