import 'package:flutter/material.dart';

import '../constants.dart';

class Footer extends StatelessWidget {
  final double height;
  const Footer({Key? key, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: height,
        color: kLandingPageColorSecondary,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "TODO: Add an awesome footer",
            )
          ],
        ),
      ),
    );
  }
}
