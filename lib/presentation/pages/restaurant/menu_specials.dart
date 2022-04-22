import 'package:flutter/material.dart';
import 'package:yuhm/logic/logic.dart';
import 'package:yuhm/presentation/presentation.dart';

class MenuSpecialsPageView extends StatelessWidget {
  /// Ws this a promotion, daily special, or some deal?
  final MenuSpecialType specialType;

  const MenuSpecialsPageView({Key? key, required this.specialType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final RestaurantState _state =
        BlocProvider.of<RestaurantBloc>(context).state;

    if (_state is RestaurantFetchSuccess) {

      List<Widget> menuSpecialCards = [];
      for (Special s in _state.restaurant.specials) {
        menuSpecialCards.add(
          Padding(
            padding: EdgeInsets.only(
              // top: _size.height * .025,
              left: _size.width * .12,
              right: _size.width * .12,
            ),
            child: MenuSpecialCard(
              networkImageSource: s.networkImageSource,
              name: capitalCase(s.name),
              description: capitalize(s.description),
            ),
          ),
        );
      }

      return Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          // Padding(
          //   padding: EdgeInsets.only(
          //     left: _size.width * .1,
          //     top: _size.height * .03,
          //     bottom: _size.height * .01,
          //   ),
          //   child: Container(
          //     alignment: Alignment.centerLeft,
          //     child: Text(
          //       specialType.humanString(),
          //       style: Theme.of(context).textTheme.subtitle1!.copyWith(
          //             fontSize: kFontSizeXLarge,
          //             fontWeight: FontWeight.bold,
          //           ),
          //     ),
          //   ),
          // ),
          Expanded(
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                PageView(
                  scrollDirection: Axis.horizontal,
                  physics: const ScrollPhysics(),
                  children: menuSpecialCards,
                  onPageChanged: (index) {
                    BlocProvider.of<TabPageSelectorCubit>(context)
                        .updateIndex(index);
                  },
                ),
                Column(
                  children: [
                    SizedBox(
                      // Offset size of footer and top padding of MenuSpecialCard.
                      height: _size.height * .24,
                    ),
                    menuSpecialCards.length > 1
                        ? CustomTabController(length: menuSpecialCards.length)
                        : const SizedBox(),
                  ],
                )
              ],
            ),
          ),
        ],
      );
    }

    return const SizedBox();
  }
}
