import 'package:flutter/material.dart';
import 'package:yuhm/components/components.dart';
import 'package:yuhm/logic/logic.dart';

/// Opening screen where the user is prompted to scan for a QR code at the
/// restaurant. This will bring them to the restaurant page, where they can
/// access the menu and send orders to the chef or bartender.
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.deepOrangeAccent,
        // image: DecorationImage(
        //   image: AssetImage("assets/images/Bitmap.png"),
        //   fit: BoxFit.fill,
        // ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 30),
            child: RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: "Yuhm.",
                    style: TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .6,
            child: RoundedButton(
              text: "Restaurant PIN",
              onPressed: () {
                BlocProvider.of<AppPageViewCubit>(context)
                    .jumpToRestaurantPinPage();
              },
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .6,
            child: RoundedButton(
              text: "Scan QR code",
              onPressed: () {
                BlocProvider.of<AppPageViewCubit>(context)
                    .jumpToQrScannerPage();
              },
            ),
          ),
        ],
      ),
    );
  }
}
