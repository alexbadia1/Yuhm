import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

//=============================================================================
// Color Themes
//=============================================================================

const Color ktextColor = Colors.white;
const Color kLandingPageColor = Color(0xFFFF8A65);
const Color kLandingPageColorSecondary = Color(0xfff0f2f5);

//=============================================================================
// Fonts
//=============================================================================

const double kfontSizeXSBase = 12;
const double kfontSizeBase = 16;
const double kfontSizeXLBase = 20;
const double kfontSizeLarge = 24;
const double kfontSizeXLarge = 36;

//=============================================================================
// Gradients
//=============================================================================
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

//=============================================================================
// Form Constants
//=============================================================================

InputDecoration kInputDecoration = const InputDecoration(
  border: OutlineInputBorder(),
  alignLabelWithHint: true,
  floatingLabelBehavior: FloatingLabelBehavior.auto,
  floatingLabelAlignment: FloatingLabelAlignment.start,
);

typedef TextFieldOnChange = void Function(String val);
SignUpTextField({
  Key? key,
  String? hintText,
  String? label,
  TextFieldOnChange? onChange,
}) {
  return TextField(
    key: key,
    decoration: kInputDecoration.copyWith(
      hintText: hintText ?? "",
      label: Text(label ?? ""),
    ),
    onChanged: (String val) {
      if (val.isEmpty) return;
      onChange!(val);
    },
  );
}

//=============================================================================
// Spacing
//=============================================================================
SizedBox kVerticalSpacer() {
  return const SizedBox(height: kfontSizeBase * 1.5);
}

SizedBox kHorizontalSpacer() {
  return const SizedBox(width: kfontSizeBase * 1.5);
}

//=============================================================================
// Buttons
//=============================================================================
typedef ImageUploadButtonOnPress = void Function();
TextButton ImageUploadButton({
  required BuildContext context,
  String? buttonText,
  ImageUploadButtonOnPress? onPress,
}) {
  return TextButton(
    style: TextButton.styleFrom(
      primary: Colors.white,
      backgroundColor: Colors.deepOrange,
    ),
    onPressed: onPress,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.cloud_upload_outlined, size: kfontSizeBase * 1.25),
        const SizedBox(width: kfontSizeBase * .5),
        Text(
          buttonText ?? "",
          style: const TextStyle(fontSize: kfontSizeBase),
        ),
      ],
    ),
  );
}

//=============================================================================
// List Tile
//=============================================================================
ListTile SpecialsListTile(String name, String description, Uint8List imgBytes) {
  return ListTile(
    key: Key(name),
    title: Text(description),
    trailing: Image.memory(imgBytes),
  );
}
