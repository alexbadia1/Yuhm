import 'menu_page.dart';
import 'menu_section.dart';

class Menu {
  /// Database PK.
  final String? id;

  /// Restaurant might have a "main" menu and a "wine" or "cocktail" menu.
  final String? name;

  /// Brief details/summary about the menu.
  final String? description;

  /// Images of each page of the menu.
  final List<MenuPage> menuPages;

  const Menu({
    this.id,
    required this.name,
    required this.description,
    required this.menuPages,
  });

  const Menu.nullConstructor({
    this.id,
    this.name = "[Menu Name]",
    this.description = "[Menu Description]",
    this.menuPages = const <MenuPage>[],
  });

  const Menu.drinks({
    this.id = "drinksMenuId",
    this.name = "Cocktail, Beer & Wine Menu",
    this.description = "Appetizers, entrees, seafood, desserts",
    this.menuPages = const <MenuPage>[
      MenuPage.nullConstructor(
        imageBytes: "assets/main-menu.png",
        menuSections: [
          MenuSection.nullConstructor(
            name: "Main Menu",
            description: "Food, drinks, etc",
          ),
        ],
      ),
      MenuPage.nullConstructor(
        imageBytes: "assets/classic-cocktails.png",
        menuSections: [
          MenuSection.nullConstructor(
            name: "Classic Cocktails",
            description: "all fresh house infusions",
          ),
        ],
      ),
      MenuPage.nullConstructor(
        imageBytes: "assets/signature-cocktails.png",
        menuSections: [
          MenuSection.nullConstructor(
            name: "Signature Cocktails",
            description: "all fresh house infusions",
          ),
        ],
      ),
      MenuPage.nullConstructor(
        imageBytes: "assets/wine-by-glass.png",
        menuSections: [
          MenuSection.nullConstructor(
            name: "Wine By Glass",
            description: "listed from light spirited to dark",
          ),
        ],
      ),
      MenuPage.nullConstructor(
        imageBytes: "assets/beer.png",
        menuSections: [
          MenuSection.nullConstructor(
            name: "Beer",
            description: "all fresh house infusions",
          ),
        ],
      ),
    ],
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
    return "Menu {\n"
        "\tDoc Id: $id\n"
        "\tName: $name\n"
        "\tDescription: $description\n"
        "\tMenuPages: ${menuPages.toString()}\n"
        "}\n";
  }
}
