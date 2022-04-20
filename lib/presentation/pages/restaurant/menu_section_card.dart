import 'package:flutter/material.dart';
import 'package:yuhm/presentation/presentation.dart';

/// Card containing a specific section of the menu (i.e. "Appetizers"). It has
/// a name and a brief description for the menu section.
class MenuSectionCard extends StatelessWidget {
  /// Section of a restaurant menu such as "Appetizers", "Entrees", "Seafood", "Desserts"
  final String name;

  /// A brief description of thh section, for example:
  ///
  /// Name: "Drinks"
  /// Description: "Juices, sodas, alcohols, etc."
  final String description;

  /// Callback function, when the card is pressed...
  final Function onPressed;

  const MenuSectionCard({
    Key? key,
    required this.name,
    required this.description,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      /// Borders, outlines, shadows, margins, padding, etc.
      padding: const EdgeInsets.symmetric(vertical: kFontSizeBase * .75, horizontal: kFontSizeBase * 2),
      margin: EdgeInsets.only(bottom: size.height * .015),
      width: size.width * .85,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: const StadiumBorder(),
        shadows: [
          BoxShadow(
            offset: const Offset(0, 10),
            blurRadius: 33,
            color: kShadowColor,
          ),
        ],
      ),

      /// Name, description, onPressed
      child: CustomListTile(
        title: Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: kFontSizeLarge,
          ),
        ),
        description: Text(
          description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: kFontSizeBase,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.chevron_right),
          iconSize: 18,
          onPressed: () {
            onPressed();
          },
        ),
      ),
    );
  }
}
