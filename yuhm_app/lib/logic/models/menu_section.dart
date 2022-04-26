import 'package:yuhm_app/logic/logic.dart';

class MenuSection extends Equatable{
  /// Database PK.
  final String? id;

  /// Specific section of the menu: "appetizer", "dessert", "entrees".
  final String? name;

  /// Brief details about what's in this particular section of the menu.
  final String? description;

  const MenuSection({
    this.id,
    required this.name,
    required this.description,
  });

  const MenuSection.nullConstructor({
    this.id,
    this.name = "[MenuSection Name]",
    this.description = "[MenuSection Description]",
  });

  copyWith({String? id, String? name, String? description}) {
    return MenuSection(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  @override
  String toString() {
    return "MenuSection {\n"
        "\tDoc Id: $id\n"
        "\tName: $name\n"
        "\tDescription: $description\n"
        "}\n";
  }

  @override
  List<Object?> get props => [id, name, description];
}
