import 'package:flutter/material.dart';

const Color ktextColor = Colors.white;
const Color kLandingPageColor = Color(0xFFFF8A65);
const Color kLandingPageColorSecondary = Color(0xfff0f2f5);

const double kfontSizeXSBase = 12;
const double kfontSizeBase = 16;
const double kfontSizeXLBase = 20;
const double kfontSizeLarge = 24;
const double kfontSizeXLarge = 36;

LinearGradient kLinearGradientBlueGrey = LinearGradient(
  colors: [
    Colors.blueGrey.shade50,
    Colors.blueGrey.shade100,
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  stops: const [0.0, 1.0],
  tileMode: TileMode.clamp,
);

LinearGradient kLinearGradientBlue = LinearGradient(
  colors: [
    Colors.blue.shade50,
    Colors.blue.shade100,
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  stops: const [0.0, 1.0],
  tileMode: TileMode.clamp,
);

LinearGradient kLinearGradientDeepOrange = LinearGradient(
  colors: [
    Colors.deepOrange.shade100,
    Colors.deepOrange.shade300,
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomRight,
  stops: const [0.0, 1.0],
  tileMode: TileMode.clamp,
);
