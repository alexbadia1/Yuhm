import 'package:flutter/material.dart';

class LandingPageClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // Starting at the top left (0, 0)...
    Path path = Path();

    // Draw a straight line to the bottom left corner...
    path.lineTo(0.0, size.height);

    // Draw a straight line from the bottom left hand corner 2/3rds right...
    path.lineTo(size.width * .6, size.height);

    // // Draw a curved line from mid bottom to mid right...
    Offset offset = Offset(size.width, size.height * .5);
    path.arcToPoint(offset);
    //
    // // Starting from halfway up right side, draw a straight line up to the top
    // right corner
    path.lineTo(size.width, 0.0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}