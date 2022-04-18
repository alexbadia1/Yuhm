import 'package:flutter/material.dart';
import 'package:yuhm/constants.dart';
import 'package:yuhm/logic/logic.dart';

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
    return Flex(
      crossAxisAlignment: CrossAxisAlignment.start,
      direction: Axis.horizontal,
      children: <Widget>[
        Expanded(
            flex: 1,
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: size.height * .005),
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(top: 0),
                  child: Text(
                    name,
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: size.width * .3,
                          padding: EdgeInsets.only(top: size.height * .02),
                          child: const Text(
                            "When the earth was flat andeveryone wanted to win the gameof the best and people and winning with an A game with all the things you have.",
                            maxLines: 5,
                            style: TextStyle(
                              fontSize: 10,
                              color: kLightBlackColor,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: size.height * .015),
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: FlatButton(
                            onPressed: () {},
                            child: const Text(
                              "Read",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        IconButton(
                          icon: const Icon(
                            Icons.favorite_border,
                            size: 20,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            BlocProvider.of<AppPageViewCubit>(context).jumpToHomePage();
                          },
                        ),
                      ],
                    )
                  ],
                )
              ],
            )),
        Expanded(
            flex: 1,
            child: Container(
              color: Colors.transparent,
              child: Image.network(
                networkImageSource,
                height: double.infinity,
                alignment: Alignment.topRight,
                fit: BoxFit.fitWidth,
              ),
            )),
      ],
    );
  }
}
