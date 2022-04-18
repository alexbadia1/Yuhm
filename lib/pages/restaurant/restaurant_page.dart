import 'package:flutter/material.dart';
import 'package:yuhm/logic/logic.dart';
import 'restaurant.dart';

/// Home screen for the Restaurant. From here, the user can see a quick bio
/// about the restaurant, choose sections of the menu to order from (or read the
/// menu entirely from the beginning), and see any specials, promo's or deals.
class RestaurantPage extends StatelessWidget {
  const RestaurantPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            /// Layering a cool background behind the Restaurant Info and Menu
            /// Sections.
            Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Container(
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.only(
                      top: _size.height * .12,
                      left: _size.width * .1,
                      right: _size.width * .02),
                  height: _size.height * .48,
                  decoration: const BoxDecoration(
                    // image: DecorationImage(
                    //   image: AssetImage("assets/images/bg.png"),
                    //   fit: BoxFit.fitWidth,
                    // ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ),

                  /// Details about the Restaurant, menus and what not.
                  child: RestaurantInfoCard(
                    size: _size,
                    name: "Olive Garden",
                    description: "unlimited bread sticks!",
                    networkImageSource: "",
                  ),
                ),

                /// Restaurant sections such as "Appetizers", "Entrees",
                /// "Seafood", "Pizzas", "Pastas", "Desserts", "Drinks", etc.
                Padding(
                  padding: EdgeInsets.only(top: _size.height * .48 - 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      MenuSectionCard(
                        name: "Appetizers",
                        description: "Breads, fruits, salads, calamaris...",
                        onPressed: () {
                        },
                      ),
                      MenuSectionCard(
                        name: "Entrees",
                        description: "Pastas, seafood, pastas, and paninis",
                        onPressed: () {},
                      ),
                      MenuSectionCard(
                        name: "Desserts",
                        description:
                            "Chocolates, cakes, ice cream, and more...",
                        onPressed: () {},
                      ),
                      MenuSectionCard(
                        name: "Drinks",
                        description:
                            "Ciders, juices, coffees & teas, and alcohol...",
                        onPressed: () {},
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),

            /// Horizontal scroll view of specials, deals, etc.
            SizedBox(
              height: _size.height * .4,
              child: PageView(
                scrollDirection: Axis.horizontal,
                physics: const ScrollPhysics(),
                children: const [
                  MenuSpecialCard(
                    networkImageSource: '',
                    name: 'Dumplings',
                    description: 'Authentic Asian cuisine!',
                    specialType: MenuSpecialType.special,
                  )
                ],
              ),
            ),

            /// Bottom margins
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
