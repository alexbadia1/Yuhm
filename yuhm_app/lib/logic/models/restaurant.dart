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
  final String logoUrl;

  /// Specials, promotions, deals, etc.
  final List<Special> specials;

  /// Restaurants may have different multiple menus depending on time of day or
  /// year. This serves as storage for the history of menus too.
  final List<Menu> menus;

  Restaurant({
    this.id,
    required this.name,
    required this.description,
    required this.logoUrl,
    required this.specials,
    required this.menus,
  });

  /// Returns an empty
  Restaurant.nullConstructor({
    this.id,
    this.name = "[Restaurant Name]",
    this.description = "[Restaurant Description]",
    this.logoUrl = "[Restaurant Logo Url]",
    this.specials = const <Special>[],
    this.menus = const <Menu>[],
  });

  /// Returns a Restaurant instance with mock data
  Restaurant.MckinneyAndDoyle({
    this.id = "restaurantId",
    this.name = "Mckinney & Doyle Cafe",
    this.description =
        "Serving Pawling since 1985, we're committed to excellence.",
    this.logoUrl = "logo.jpg",
    this.specials = const <Special>[
      Special.nullConstructor(),
      Special.nullConstructor(),
      Special.nullConstructor(),
    ],
    this.menus = const <Menu>[],
  });

  copyWith({
    String? id,
    String? name,
    String? description,
    String? logoUrl,
    List<Special>? specials,
    List<Menu>? menus,
  }) {
    return Restaurant(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      logoUrl: logoUrl ?? this.logoUrl,
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
        "\tLogo Url: $logoUrl\n"
        "\tSpecials: ${specials.toString()}\n"
        "\tMenus: ${menus.toString()}\n"
        "}\n";
  }
}
