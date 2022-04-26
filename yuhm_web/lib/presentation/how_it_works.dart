import 'package:flutter/material.dart';

import '../constants.dart';

class HowItWorks extends StatelessWidget {
  final double height;
  const HowItWorks(this.height, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            HowItWorksCard(
              topCenter:SizedBox(
                height: height * .72,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "images/yuhm-login.png",
                      height: height * .72,
                    ),
                  ],
                ),
              ),
              bottomCenter: Container(
                height: kfontSizeXBase * 16.5,
                alignment: Alignment.topLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _numberGutter("1"),
                    _detailsGutter([
                      "Restaurants sign up with information including name, description, logo, and location.",
                      "We'll generate a QR code and PIN from your uploaded menus, specials, deals, promotions, etc.",
                      "All you have to do is login and check the Chef's Dashboard, that will manage all your customer orders!"
                    ]),
                    const Expanded(
                      flex: 1,
                      child: SizedBox(),
                    )
                  ],
                ),
              ),
            ),
            HowItWorksCard(
              topCenter: SizedBox(
                height: height * .72,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "images/yuhm-login.png",
                      height: height * .72,
                    ),
                  ],
                ),
              ),
              bottomCenter: Container(
                height: kfontSizeXBase * 16.5,
                alignment: Alignment.topLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _numberGutter("2"),
                    _detailsGutter([
                      "Print out the pins and QR codes, post them at tables. Ideally, in locations only accessible from inside the restaurant.",
                      "Using the Yuhm. app, the customer scans the QR code or enters the PIN and can start ordering automatically!"
                    ]),
                    const Expanded(
                      flex: 1,
                      child: SizedBox(),
                    )
                  ],
                ),
              ),
            ),
            HowItWorksCard(
              topCenter: SizedBox(
                height: height * .72,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "images/yuhm-menu-drawing.png",
                      height: height * .72,
                    ),
                  ],
                ),
              ),
              bottomCenter: Container(
                height: kfontSizeXBase * 16.5,
                alignment: Alignment.topLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _numberGutter("3"),
                    _detailsGutter([
                      "The customer circles what they want, and sends the order to the Chef.",
                      "Our system will automatically handle order flows, routing them to the Chefs Dashboard.",
                      "The Chefs dashboard is more than just an \"order queue\", it uses machine learning to provide insight on restaurant business operations."
                    ]),
                    const Expanded(
                      flex: 1,
                      child: SizedBox(),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded _numberGutter(String number) {
    return Expanded(
      flex: 2,
      child: Text(
        number,
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: Colors.black,
            fontSize: kfontSizeLarge,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Expanded _detailsGutter(List<String> details) {
    final List<TextSpan> spans = [];
    for (String d in details) {
      spans.add(TextSpan(
        text: d + "\n\n",
        style: const TextStyle(
          color: Colors.black,
          fontSize: kfontSizeXBase,
        ),
      ));
    }
    return Expanded(flex: 7, child: RichText(text: TextSpan(children: spans)));
  }
}

class HowItWorksCard extends StatelessWidget {
  final Widget topCenter;
  final Widget bottomCenter;
  const HowItWorksCard(
      {Key? key, required this.topCenter, required this.bottomCenter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return AnimatedContainer(
      color: Colors.transparent,
      width: _width * .25,
      duration: const Duration(milliseconds: 250),
      child: Stack(
        children: [
          SizedBox(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                topCenter,
                Padding(
                  padding: EdgeInsets.only(top: _height * .025),
                  child: bottomCenter,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
