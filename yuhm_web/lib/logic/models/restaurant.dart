import 'dart:typed_data';

import 'package:equatable/equatable.dart';

import 'menu.dart';
import 'special.dart';

class Restaurant extends Equatable {
  /// Database PK.
  final String? id;

  /// Restaurant name.
  final String name;

  /// Restaurant description.
  final String description;

  /// Restaurant description.
  final String address;

  /// Logo is store on the web, no in app.
  final Uint8List? logo;

  /// Specials, promotions, deals, etc.
  final List<Special> specials;

  /// Restaurants may have different multiple menus depending on time of day or
  /// year. This serves as storage for the history of menus too.
  final List<Menu> menus;

  final String? pin;

  Restaurant(
      {this.id,
      required this.name,
      required this.description,
      required this.address,
      this.logo, this.pin,
      required this.specials,
      required this.menus});

  /// Returns an empty
  Restaurant.nullConstructor({
    this.id,
    this.name = "",
    this.description = "",
    this.address = "",
    this.logo,
    this.pin,
    this.specials = const <Special>[],
    this.menus = const <Menu>[],
  });

  copyWith({
    String? id,
    String? name,
    String? description,
    String? address,
    Uint8List? logo,
    List<Special>? specials,
    List<Menu>? menus,
    String? pin,
  }) {
    return Restaurant(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      address: address ?? this.address,
      logo: logo ?? this.logo,
      specials: specials ?? this.specials,
      menus: menus ?? this.menus,
      pin: pin ?? this.pin,
    );
  }

  @override
  String toString() {
    String logoText = "";
    if (logo == null) {
      logoText = "";
    } else if (logo!.length > 25) {
      logoText = "${logo.toString().substring(0, 24)}...]";
    }
    return 'Restaurant {\n'
        '\t"Doc Id": $id,\n'
        '\t"Name": $name,\n'
        '\t"Description": $description,\n'
        '\t"Address": $address,\n'
        '\t"Logo": $logoText,\n'
        '\t"Menus": ${menus.toString()},\n'
        '\t"Specials": ${specials.toString()},\n'
        '}\n';
  }

  @override
  List<Object?> get props =>
      [id, name, description, address, logo, specials, menus];
}
