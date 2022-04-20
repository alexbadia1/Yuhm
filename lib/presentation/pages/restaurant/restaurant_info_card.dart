import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yuhm/presentation/presentation.dart';

class RestaurantInfoCard extends StatelessWidget {
  /// Restaurant name such as "Olive Garden."
  final String name;

  /// Restaurant description such as "The restaurant known for unlimited
  /// bread sticks!"
  final String description;

  /// Parent widget size.
  final Size size;

  /// Image source of the restaurant's logo.
  final String networkImageSource;

  const RestaurantInfoCard({
    Key? key,
    required this.name,
    required this.description,
    required this.size,
    required this.networkImageSource,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    height: size.height * .1,
                    padding: EdgeInsets.only(top: size.height * .0125),
                    child: const Text(
                      "\"We're all family here\" - serving you the best "
                      "all you can eat bread sticks since 1985.",
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: kFontSizeBase,
                        color: kLightBlackColor,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * .005),
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
                          padding: const EdgeInsets.symmetric(horizontal: kFontSizeBase * 1.4),
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
        const Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: kFontSizeLarge * .95),
            child: Image(
              image: AssetImage('mc.png'),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ],
    );
  }
}
