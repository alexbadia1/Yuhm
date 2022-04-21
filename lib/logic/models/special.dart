/// Restaurants usually have specials of some sort, whether is be a daily or
/// weekly special, or some sort of promotion or deal.
class Special {
  /// Database PK.
  final String? id;

  /// Special, promo, deal, etc.
  final String? name;

  /// Details of special, promo, deal, etc.
  final String? description;

  Special({
    this.id,
    required this.name,
    required this.description,
  });

  Special.nullConstructor({
    this.id,
    this.name = "[Special Name]",
    this.description = "[Special Description]",
  });

  copyWith({String? id, String? name, String? description}) {
    return Special(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  @override
  String toString() {
    return "Special {\n"
        "\tDoc Id: $id\n"
        "\tName: $name\n"
        "\tDescription: $description\n"
        "}\n";
  }
}
