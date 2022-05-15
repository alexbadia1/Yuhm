import 'package:equatable/equatable.dart';

class MenuSection extends Equatable {
  /// Database PK.
  final String? id;

  /// Specific section of the menu: "appetizer", "dessert", "entrees".
  final String? name;

  /// Brief details about what's in this particular section of the menu.
  final String? description;

  static const String indent = "\t\t\t\t";

  const MenuSection({
    this.id,
    required this.name,
    required this.description,
  });

  const MenuSection.nullConstructor({
    this.id,
    this.name = "",
    this.description = "",
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
    return '\n${indent}Menu Section {\n'
        '$indent\t"Id": $id,\n'
        '$indent\t"Name": $name,\n'
        '$indent\t"Description": $description,\n'
        '$indent}';
  }

  @override
  List<Object?> get props => [id, name, description];
}
