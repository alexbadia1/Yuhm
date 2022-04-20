import 'package:flutter/material.dart';
import 'package:yuhm/presentation/presentation.dart';

/// Home screen for the Restaurant. From here, the user can see a quick bio
/// about the restaurant, choose sections of the menu to order from (or read the
/// menu entirely from the beginning), and see any specials, promo's or deals.
class RestaurantPage extends StatelessWidget {
  const RestaurantPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final double _headerSize = _size.height * .3;
    final double _footerSize = _size.height * .35;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          /// Layering a cool background behind the Restaurant Info and Menu
          /// Sections.
          Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Container(
                height: _headerSize,
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(
                    top: _size.width * .06,
                    left: _size.width * .12,
                    right: _size.width * .12),
                decoration: const BoxDecoration(
                  // image: DecorationImage(
                  //   image: AssetImage("assets/images/bg.png"),
                  //   fit: BoxFit.fitWidth,
                  // ),
                  color: Colors.yellow,
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

              SizedBox(
                height: _size.height,
                width: _size.width,
                child: Column(
                  mainAxisSize:  MainAxisSize.max,
                  children: [
                    SizedBox(height: _headerSize * .9),
                    const Expanded(
                      flex: 1,
                      child: MenuSections()
                    ),
                    const CustomTabController(length: 2),

                    /// Horizontal scroll view of specials, deals, etc.
                    Container(
                      height: _footerSize,
                      padding: EdgeInsets.only(
                          top: _size.height * .025,
                          left: _size.width * .12,
                          right: _size.width * .12),
                      child: PageView(
                        scrollDirection: Axis.horizontal,
                        physics: const ScrollPhysics(),
                        children: const [
                          MenuSpecialCard(
                            networkImageSource: '',
                            name: 'Dumplings',
                            description: 'Authentic Asian cuisine!',
                            specialType: MenuSpecialType.special,
                          ),
                          MenuSpecialCard(
                            networkImageSource: '',
                            name: 'Boba Tea',
                            description: 'Authentic Asian cuisine!',
                            specialType: MenuSpecialType.special,
                          ),
                          MenuSpecialCard(
                            networkImageSource: '',
                            name: 'Dumplings',
                            description: 'Authentic Asian cuisine!',
                            specialType: MenuSpecialType.special,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
