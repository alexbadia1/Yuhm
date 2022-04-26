import 'package:flutter/material.dart';
import 'package:yuhm_app/presentation/presentation.dart';

enum MenuSpecialType { deal, dailySpecial, promotion }

extension ParseToString on MenuSpecialType {
  String humanString() {
    switch (this) {
      case MenuSpecialType.deal:
        return "Deals";
      case MenuSpecialType.dailySpecial:
        return "Daily Specials";
      case MenuSpecialType.promotion:
        return "Promotions";
      default:
        return "Specials";
    }
  }
}

/// Card containing the restaurants daily special, promo, or deals of some sort.
/// It has a name, a brief description, and an image for the special, promo, or
/// deal of some sort.
class MenuSpecialCard extends StatelessWidget {
  /// Name of the promotion, special, deal, etc.
  final String name;

  /// Description of the promotion, special, deal, etc. What's the food made of?
  /// In the case of the special, what's the user getting?
  final String description;

  /// A nice image of the promotion, special, or deal.
  final String networkImageSource;

  const MenuSpecialCard(
      {Key? key,
      required this.name,
      required this.description,
      required this.networkImageSource})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  name,
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontSize: kFontSizeXLarge,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: _size.height * .1,
                    padding: EdgeInsets.only(top: _size.height * .0125),
                    child: Text(
                      capitalize(description),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: kFontSizeBase,
                        color: kLightBlackColor,
                      ),
                    ),
                  ),
                  SizedBox(height: _size.height * .005),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                        child: const Text(
                          "Read Menu",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: kFontSizeBase,
                              fontWeight: FontWeight.bold),
                        ),
                        style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kFontSizeBase * 1.4),
                            backgroundColor: Colors.deepOrangeAccent,
                            shape: const StadiumBorder()),
                        onPressed: () {},
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: kFontSizeLarge * .95),
            child: Image(
              image: AssetImage(networkImageSource),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ],
    );
  }
}
