/// Restaurants usually have specials of some sort, whether is be a daily or
/// weekly special, or some sort of promotion or deal.
class Special {
  /// Database PK.
  final String? id;

  /// Special, promo, deal, etc.
  final String name;

  /// Details of special, promo, deal, etc.
  final String description;

  final String networkImageSource;

  const Special({
    this.id,
    required this.name,
    required this.description,
    required this.networkImageSource,
  });

  const Special.nullConstructor({
    this.id,
    this.name = "Boba Tea",
    this.description = "A cold, frothy drink made with a tea base shaken with "
        "flavors, milk and tapioca pearls at Fat Straw Required.",
    this.networkImageSource = "boba_tea.png",
  });

  copyWith({String? id, String? name, String? description, String? networkImageSource}) {
    return Special(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      networkImageSource: networkImageSource ?? this.networkImageSource,
    );
  }

  @override
  String toString() {
    return "Special {\n"
        "\tDoc Id: $id\n"
        "\tName: $name\n"
        "\tDescription: $description\n"
        "\tNetwork Image Source: $networkImageSource\n"
        "}\n";
  }
}
