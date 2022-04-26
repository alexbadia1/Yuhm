import 'package:flutter/material.dart';
import 'package:yuhm_app/logic/logic.dart';
import 'package:yuhm_app/presentation/presentation.dart';

class MenuSectionsPageView extends StatelessWidget {
  const MenuSectionsPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final PageController _pg = PageController();
    final RestaurantState _state =
        BlocProvider.of<RestaurantBloc>(context).state;

    if (_state is RestaurantFetchSuccess) {
      return LayoutBuilder(builder: (context, constraints) {
        int maxItemsInCol = 4;
        if (constraints.maxHeight > _size.height * .35) {
          maxItemsInCol = 3;
        }

        // Get all menu sections, duplicates will be removed later.
        List<MenuSection> menuSections = <MenuSection>[];
        for (MenuPage mp in _state.restaurant.menus.first.menuPages) {
          for (MenuSection ms in mp.menuSections) {
            menuSections.add(ms);
          }
        }

        // Remove duplicate sections by casting types.
        // Note: this on objects works because Equatable!
        //
        // Sections with the same name and description will
        // appear since their id's will always be different.
        menuSections = menuSections.toSet().toList();

        // Generate multiple pages in a page view of columns of menu sections.
        List<Widget> pageViewChildren = [];
        for (int i = 0; i < menuSections.length; i += maxItemsInCol) {
          // Add 3-4 sections per column...
          List<MenuSectionCard> menuSectionCards = [];
          for (int j = i;
              j < i + maxItemsInCol && j < menuSections.length;
              ++j) {
            menuSectionCards.add(
              MenuSectionCard(
                name: capitalize(menuSections[j].name ?? "[Section $j]"),
                description: capitalize(menuSections[j].description ?? "[Description $j]"),
                onPressed: () {
                  BlocProvider.of<AppPageViewCubit>(context).jumpToMenuPage(j);
                }
              ),
            );
          }

          // ...then add each column as it's own page in a PageView
          pageViewChildren.add(
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: menuSectionCards,
            ),
          );
        }

        return Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  PageView(
                    controller: _pg,
                    children: pageViewChildren,
                    onPageChanged: (index) {
                      BlocProvider.of<TabPageSelectorCubit>(context)
                          .updateIndex(index);
                    },
                  ),
                  Column(
                    children: [
                      pageViewChildren.length > 1
                          ? Padding(
                              padding: EdgeInsets.only(
                                // The Menu Sections are in an Expanded Widget,
                                // this calculates the size of the expanded widget
                                // in order to offset the TabPageSelector.
                                top: _size.height - (_size.height * .68),
                              ),
                              child: CustomTabController(
                                length: pageViewChildren.length,
                              ),
                            )
                          : const SizedBox(),
                    ],
                  )
                ],
              ),
            ),
          ],
        );
      });
    }

    return const SizedBox();
  }
}
