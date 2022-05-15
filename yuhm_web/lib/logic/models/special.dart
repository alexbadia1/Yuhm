import 'dart:typed_data';

/// Restaurants usually have specials of some sort, whether is be a daily or
/// weekly special, or some sort of promotion or deal.
class Special {
  /// Database PK.
  final String? id;

  /// Special, promo, deal, etc.
  final String name;

  /// Details of special, promo, deal, etc.
  final String description;

  static const String indent = "\t\t";

  final Uint8List? imageBytes;

  const Special({
    this.id,
    required this.name,
    required this.description,
    required this.imageBytes,
  });

  const Special.nullConstructor({
    this.id,
    this.name = "",
    this.description = "",
    this.imageBytes,
  });

  copyWith(
      {String? id, String? name, String? description, Uint8List? imageBytes}) {
    return Special(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageBytes: imageBytes ?? this.imageBytes,
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
    return '\n$indent"Special" {\n'
        '$indent\t"Doc Id": $id,\n'
        '$indent\t"Name": $name,\n'
        '$indent\t"Description": $description,\n'
        '$indent\t"Image Bytes": $imageBytesText,\n'
        '$indent}';
  }
}
