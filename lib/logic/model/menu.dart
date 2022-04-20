import 'menu_page.dart';

class Menu {
  /// Database PK.
  final String? id;

  /// Restaurant might have a "main" menu and a "wine" or "cocktail" menu.
  final String? name;

  /// Brief details/summary about the menu.
  final String? description;

  /// Images of each page of the menu.
  final List<MenuPage> menuPages;

  Menu({
    this.id,
    required this.name,
    required this.description,
    required this.menuPages,
  });

  Menu.nullConstructor({
    this.id,
    this.name = "[Menu Name]",
    this.description = "[Menu Description]",
    this.menuPages = const <MenuPage>[],
  });

  copyWith({String? id, String? name, String? description, List<MenuPage>? menuPages}) {
    return Menu(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      menuPages: menuPages ?? this.menuPages,
    );
  }

  @override
  String toString() {
    return "Menu {\n"
        "\tDoc Id: $id\n"
        "\tName: $name\n"
        "\tDescription: $description\n"
        "\tMenuPages: ${menuPages.toString()}"
        "}\n";
  }
}
