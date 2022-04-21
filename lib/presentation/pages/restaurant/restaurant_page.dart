import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yuhm/logic/logic.dart';
import 'package:yuhm/presentation/presentation.dart';

/// Home screen for the Restaurant. From here, the user can see a quick bio
/// about the restaurant, choose sections of the menu to order from (or read the
/// menu entirely from the beginning), and see any specials, promo's or deals.
class RestaurantPage extends StatelessWidget {
  const RestaurantPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery
        .of(context)
        .size;
    final double _headerSize = _size.height * .3;
    final double _footerSize = _size.height * .3;
    final _realHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom +
        MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
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
                      top: _size.height * .02,
                      left: _size.width * .12,
                      right: _size.width * .12),
                  decoration: const BoxDecoration(
                    // image: DecorationImage(
                    //   image: AssetImage("assets/images/bg.png"),
                    //   fit: BoxFit.fitWidth,
                    // ),
                    color: Colors.green,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ),

                  /// Details about the Restaurant, menus and what not.
                  child: RestaurantInfoCard(
                    size: _size,
                    name: "McKinney & Doyle Cafe",
                    description: "A small town restaurant since 1975.",
                    networkImageSource: "",
                  ),
                ),
                SizedBox(
                  height: _realHeight,
                  width: _size.width,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(height: _headerSize * .94),
                      Expanded(
                        child: BlocProvider<TabPageSelectorCubit>(
                          create: (_) => TabPageSelectorCubit(),
                          child: const MenuSectionsPageView(),
                        ),
                      ),
                      SizedBox(
                        height: _footerSize,
                        child: BlocProvider<TabPageSelectorCubit>(
                          create: (_) => TabPageSelectorCubit(),
                          child: const MenuSpecialsPageView(
                            specialType: MenuSpecialType.dailySpecial,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
