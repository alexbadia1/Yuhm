import 'package:flutter/material.dart';

import '../constants.dart';
import '../custom_clipper.dart';

class Welcome extends StatelessWidget {
  final double height;
  const Welcome(this.height, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Stack(
        children: [
          ClipPath(
            clipper: LandingPageClipper(),
            child: Container(
                height: height,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        kLandingPageColor,
                        Colors.deepOrange.shade500,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomRight,
                      stops: const [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: const SizedBox()),
          ),
          SizedBox(
            height: height,
            width: double.infinity,
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width * .1),
                  Flexible(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * .35,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Your Restaurant Data Processing Solution!",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: kfontSizeXLarge,
                                  color: Colors.white),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Directly connect the Dinee to the Diner "
                                "with digitalized menus, automated customer "
                                "order flows, data analytics and insights.",
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: kfontSizeBase * 1.25,
                                  color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .03,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextButton(
                                  style: TextButton.styleFrom(
                                    primary: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: kfontSizeBase * 1.25,
                                      vertical: kfontSizeBase * 1,
                                    ),
                                    textStyle: const TextStyle(
                                      fontSize: kfontSizeBase,
                                      color: Colors.white,
                                    ),
                                    backgroundColor: Colors.blueAccent,
                                  ),
                                  onPressed: () {},
                                  child: const Text('Request Demo'),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * .02,
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    primary: Colors.black,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: kfontSizeBase * 1.25,
                                      vertical: kfontSizeBase * 1,
                                    ),
                                    textStyle: const TextStyle(
                                      fontSize: kfontSizeBase,
                                      color: Colors.black,
                                    ),
                                    backgroundColor: Colors.white,
                                  ),
                                  onPressed: () {},
                                  child: Row(
                                    children: const [
                                      Text('Learn More'),
                                      Icon(
                                        Icons.chevron_right,
                                        size: kfontSizeBase * 1.25,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset(
                          "images/yuhm-app.png",
                          height: height * .95,
                        ),
                      ],
                    )
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
