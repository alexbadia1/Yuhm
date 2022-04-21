import 'menu.dart';

class Order {
  /// Database PK.
  final String? id;

  /// Restaurant might have a "main" menu and a "wine" or "cocktail" menu.
  final String? name;

  /// Users modified menu
  final Menu menu;

  const Order({
    this.id,
    required this.name,
    required this.menu,
  });

  const Order.nullConstructor({
    this.id,
    this.name = "[Menu Name]",
    this.menu = const Menu.nullConstructor(),
  });

  copyWith({String? id, String? name, Menu? menu}) {
    return Order(
      id: id ?? this.id,
      name: name ?? this.name,
      menu: menu ?? this.menu,
    );
  }

  @override
  String toString() {
    return "Order {\n"
        "\tDoc Id: $id\n"
        "\tName: $name\n"
        "\tMenu: ${menu.toString()}\n"
        "}\n";
  }
}