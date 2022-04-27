import 'dart:html';

/// Restaurants usually have specials of some sort, whether is be a daily or
/// weekly special, or some sort of promotion or deal.
class Special {
  /// Database PK.
  final String? id;

  /// Special, promo, deal, etc.
  final String name;

  /// Details of special, promo, deal, etc.
  final String description;

  final File? imageFile;

  const Special({
    this.id,
    required this.name,
    required this.description,
    required this.imageFile,
  });

  const Special.nullConstructor({
    this.id,
    this.name = "",
    this.description = "",
    this.imageFile,
  });

  copyWith({String? id, String? name, String? description, File? imageFile}) {
    return Special(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageFile: imageFile ?? this.imageFile,
    );
  }

  @override
  String toString() {
    return "Special {\n"
        "\tDoc Id: $id\n"
        "\tName: $name\n"
        "\tDescription: $description\n"
        "\tImage File: $imageFile\n"
        "}\n";
  }
}
