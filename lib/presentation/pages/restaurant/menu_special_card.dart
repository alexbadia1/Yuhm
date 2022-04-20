import 'package:flutter/material.dart';
import 'package:yuhm/presentation/presentation.dart';

enum MenuSpecialType { deal, special, promotion }

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

  /// WIs this a promotion, daily special, or some deal?
  final MenuSpecialType specialType;

  const MenuSpecialCard(
      {Key? key,
      required this.name,
      required this.description,
      required this.specialType,
      required this.networkImageSource})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.headline5,
            children: const [
              TextSpan(
                text: "Deals ",
              ),
              TextSpan(
                text: "& ",
              ),
              TextSpan(
                text: "Specials...",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Stack(
          children: <Widget>[
            const SizedBox(
              height: 180,
              width: double.infinity,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.only(left: 24, top: 24, right: 150),
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(29),
                  color: const Color(0xFFFFF8F9),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(color: kBlackColor),
                        children: [
                          TextSpan(
                            text: capitalCase(name),
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          TextSpan(
                            text: capitalize(description),
                            style: const TextStyle(color: kLightBlackColor),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        const SizedBox(width: 10),
                        Expanded(
                          child: RoundedButton(
                            text: "Add to Order",
                            onPressed: () {
                              print(
                                  "menu special, promotion, or deal added to order!");
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Image.network(
                networkImageSource,
                width: 150,
                fit: BoxFit.fitWidth,
              ),
            ),
          ],
        )
      ],
    );
  }
}
