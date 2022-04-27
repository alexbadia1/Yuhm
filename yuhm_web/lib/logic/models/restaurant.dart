import 'dart:typed_data';

import 'menu.dart';
import 'special.dart';

class Restaurant {
  /// Database PK.
  final String? id;

  /// Restaurant name.
  final String name;

  /// Restaurant description.
  final String description;

  /// Logo is store on the web, no in app.
  final Uint8List? logo;

  /// Specials, promotions, deals, etc.
  final List<Special> specials;

  /// Restaurants may have different multiple menus depending on time of day or
  /// year. This serves as storage for the history of menus too.
  final List<Menu> menus;

  Restaurant({
    this.id,
    required this.name,
    required this.description,
    this.logo,
    required this.specials,
    required this.menus,
  });

  /// Returns an empty
  Restaurant.nullConstructor({
    this.id,
    this.name = "",
    this.description = "",
    this.logo,
    this.specials = const <Special>[],
    this.menus = const <Menu>[],
  });

  copyWith({
    String? id,
    String? name,
    String? description,
    Uint8List? logo,
    List<Special>? specials,
    List<Menu>? menus,
  }) {
    return Restaurant(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      logo: logo ?? this.logo,
      specials: specials ?? this.specials,
      menus: menus ?? this.menus,
    );
  }

  @override
  String toString() {
    return "Restaurant {\n"
        "\tDoc Id: $id\n"
        "\tName: $name\n"
        "\tDescription: $description\n"
        "\tLogo: $logo\n"
        "\tSpecials: ${specials.toString()}\n"
        "\tMenus: ${menus.toString()}\n"
        "}\n";
  }
}
