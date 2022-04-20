import 'package:flutter/material.dart';

/*
  CustomListTile

  Material list tiles have restrictions and alignment issues, this list
  tile implementation allows for more flexibility like adding an Image() as
  the leading widget, and having trailing Icon buttons actually centered correctly.
 */
class CustomListTile extends StatelessWidget {
  final Widget title;
  final Widget description;
  final Widget trailing;

  /// Adds a thin light gray top and
  /// bottom border to the custom list title.
  ///
  /// Defaults to true.
  final bool enableBorders;

  const CustomListTile({
    Key? key,
    required this.title,
    required this.description,
    required this.trailing,
    this.enableBorders = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _realHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom +
        MediaQuery.of(context).viewInsets.bottom;

    return ConstrainedBox(
      constraints: const BoxConstraints(
          minWidth: double.infinity),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 9,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomListTileDescription(
                  title: title,
                  description: description,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [trailing],
            ),
          ),
        ],
      ),
    );
  } // build
} // CustomListTile

class CustomListTileDescription extends StatelessWidget {
  /// Widget shown in the first line.
  final Widget title;

  /// Widget shown in the third line.
  final Widget description;

  const CustomListTileDescription({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          title,
          const SizedBox(height: 3.0),
          description,
        ],
      ),
    );
  } // build
} // CustomListTileDescription
