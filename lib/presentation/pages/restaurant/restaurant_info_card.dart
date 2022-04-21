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
              Stack(
                alignment: AlignmentDirectional.topStart,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: size.height * .0125),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                          maxHeight: size.height * .075,
                      ),
                      child: Text(
                        description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: kFontSizeBase,
                          color: kLightBlackColor,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(height: size.height * .075),
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
                      ),
                    ],
                  ),
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
