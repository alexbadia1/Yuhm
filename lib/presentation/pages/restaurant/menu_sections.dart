import 'package:flutter/material.dart';
import 'package:yuhm/presentation/presentation.dart';

class MenuSections extends StatelessWidget {
  const MenuSections({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final PageController _pg = PageController();

    return LayoutBuilder(builder: (context, constraints) {
      List<int> menuSections = [1, 2, 3, 4];
      int maxItemsInCol = 4;
      if (constraints.maxHeight > _size.height * .35) {
        maxItemsInCol = 3;
      }

      // Generate multiple pages in a page view of columns of menu sections.
      List<Widget> pageViewChildren = [];
      for (int i = 0; i < menuSections.length; i += maxItemsInCol) {

        // Add 3-4 sections per column...
        List<MenuSectionCard> menuSectionCards = [];
        for (int j = i; j < i + maxItemsInCol && j < menuSections.length; ++j) {
          menuSectionCards.add(
            MenuSectionCard(
              name: "Appetizers",
              description: "Breads, fruits, salads, calamaris...",
              onPressed: () {},
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

      return PageView(
        controller: _pg,
        children: pageViewChildren,
      );
    });
  }
}
