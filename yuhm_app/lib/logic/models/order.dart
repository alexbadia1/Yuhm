import 'package:yuhm_app/logic/logic.dart';

class Order {
  /// Database PK.
  final String id;

  /// Orderer's name
  final String fullName;

  /// Users modified menu
  final Uint8List? image;

  /// Order notes
  final String? notes;

  const Order({
    required this.id,
    required this.fullName,
    this.image,
    this.notes,
  });

  const Order.nullConstructor({
    this.id = "[Order Id]",
    this.fullName = "[Menu Name]",
    this.image,
    this.notes,
  });

  copyWith({String? id, String? fullName, Uint8List? image, String? notes}) {
    return Order(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      image: image ?? this.image,
      notes: notes ?? this.notes,
    );
  }

  @override
  String toString() {
    return "Order {\n"
        "\tDoc Id: $id\n"
        "\tName: $fullName\n"
        "\tOrder Notes: $notes\n"
        "\tImage Bytes: ${image.toString()}\n"
        "}\n";
  }
}
