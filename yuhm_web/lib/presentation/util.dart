import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuhm_web/constants.dart';
import 'package:yuhm_web/logic/cubits/current_menu_page_section_cubit.dart';
import 'package:yuhm_web/logic/cubits/menu_sections_cubit.dart';

import '../logic/models/menu_section.dart';

typedef DraggableListViewCallback = void Function(int oldIndex, int newIndex);
typedef DraggableListViewAddItemCallback = void Function();
typedef MapItemsToWidgets = List<Widget> Function();

class DraggableListView extends StatefulWidget {
  final String title;
  final double width;
  final MapItemsToWidgets mapItemsToWidgets;
  final String addItemButtonTitle;
  final DraggableListViewAddItemCallback? onAddItem;
  final DraggableListViewCallback onReorder;

  const DraggableListView({
    Key? key,
    this.title = "",
    this.width = kfontSizeBase * 50,
    required this.mapItemsToWidgets,
    this.addItemButtonTitle = "",
    this.onAddItem,
    required this.onReorder,
  }) : super(key: key);
  @override
  State<DraggableListView> createState() => _DraggableListViewState();
}

class _DraggableListViewState extends State<DraggableListView> {
  @override
  Widget build(BuildContext context) {
    List<Widget> items = widget.mapItemsToWidgets();

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              widget.title,
              style: const TextStyle(fontSize: kfontSizeLarge),
            ),
            const Expanded(child: SizedBox()),
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.greenAccent,
                textStyle: const TextStyle(fontSize: kfontSizeBase * 1.2),
              ),
              child: Row(children: [
                const Icon(Icons.add, size: kfontSizeBase * 1.2),
                Text(widget.addItemButtonTitle),
              ]),
              onPressed: widget.onAddItem,
            ),
          ],
        ),
        kVerticalSpacer(),
        Builder(
          builder: (context) {
            if (items.isEmpty) {
              return Container(
                height: kfontSizeBase * 10,
                color: Colors.grey.shade200,
                child: const Center(
                  child: Text("No Specials", style: TextStyle(fontSize: kfontSizeBase)),
                ),
              );
            }
            return Container(
              color: Colors.grey.shade200,
              child: ReorderableListView(
                key: widget.key,
                shrinkWrap: true,
                children: items,
                onReorder: (int oldIndex, int newIndex) {
                  setState(() {
                    widget.onReorder(oldIndex, newIndex);
                  });
                },
              ),
            );
          }
        ),
      ],
    );
  }
}

class ImageUploadBox extends StatelessWidget {
  final double width;
  final double height;
  final Uint8List? imageBytes;
  final bool showButtons;
  final ImageUploadButtonOnPress? imageUploadButtonOnPress;
  final Color? backgroundColor;
  const ImageUploadBox({
    Key? key,
    this.imageBytes,
    this.width = kfontSizeBase * 15,
    this.height = kfontSizeBase * 13,
    this.showButtons = true,
    this.imageUploadButtonOnPress,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: height,
          width: width,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                color: backgroundColor ?? Colors.grey.shade200,
                child: imageBytes == null
                    ? const Center(
                        child: Text(
                          "Image Preview",
                          style: TextStyle(fontSize: kfontSizeBase),
                        ),
                      )
                    : AspectRatio(
                        aspectRatio: 4 / 5,
                        child: Image.memory(
                          imageBytes!,
                          fit: BoxFit.contain,
                        ),
                      ),
              ),
              imageBytes != null
                  ? const SizedBox()
                  : Visibility(
                      visible: showButtons,
                      child: SizedBox(
                        width: kfontSizeBase * 7,
                        height: kfontSizeBase * 2,
                        child: _imageUploadButton(context, "Upload"),
                      ),
                    ),
            ],
          ),
        ),
        imageBytes == null
            ? const SizedBox()
            : Visibility(
                visible: showButtons,
                child: Padding(
                  padding: const EdgeInsets.only(top: kfontSizeBase),
                  child: SizedBox(
                    width: kfontSizeBase * 8,
                    height: kfontSizeBase * 2,
                    child: _imageUploadButton(context, "Re-Upload"),
                  ),
                ),
              ),
      ],
    );
  }

  TextButton _imageUploadButton(BuildContext context, String? buttonText) {
    return ImageUploadButton(
      context: context,
      buttonText: buttonText,
      onPress: imageUploadButtonOnPress,
    );
  }
}

/*
  CustomListTile

  Material list tiles have restrictions and alignment issues, this list
  tile implementation allows for more flexibility like adding an Image() as
  the leading widget, and having trailing Icon buttons actually centered correctly.
 */
class CustomListTile extends StatelessWidget {
  final Widget? title;
  final Widget? subtitle;
  final Widget? tag;
  final Widget? trailing;
  final Widget? description;

  const CustomListTile({
    Key? key,
    this.title,
    this.subtitle,
    this.tag,
    this.trailing,
    this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _realHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom +
        MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: kfontSizeBase * 1,
          maxHeight: kfontSizeBase * 30,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomListTileDescription(
                  title: title,
                  subtitle: subtitle,
                  tag: tag,
                  description: description,
                ),
              ],
            ),
            kHorizontalSpacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [trailing ?? const SizedBox()],
            ),
          ],
        ),
      ),
    );
  } // build
} // CustomListTile

class CustomListTileDescription extends StatelessWidget {
  /// Widget shown in the first line.
  final Widget? title;

  /// Widget shown in the second line.
  final Widget? subtitle;

  /// Widget shown in the third line.
  final Widget? tag;

  /// Widget shown in the fourth line.
  final Widget? description;

  const CustomListTileDescription({
    Key? key,
    this.title,
    this.subtitle,
    this.tag,
    this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        title ?? const SizedBox(),
        subtitle != null ? kVerticalSpacer() : const SizedBox(),
        subtitle ?? const SizedBox(),
        tag != null
            ? Column(children: [tag!, kVerticalSpacer()])
            : const SizedBox(),
        description != null ? kVerticalSpacer() : const SizedBox(),
        description ?? const SizedBox(),
      ],
    );
  } // build
} // CustomListTileDescription

class Dropdown extends StatefulWidget {
  final List<String> items;
  const Dropdown({Key? key, required this.items}) : super(key: key);

  @override
  _DropdownState createState() => _DropdownState();
} // DropdownEventsFilter

class _DropdownState extends State<Dropdown> {
  late String dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.items.isEmpty ? "None" : widget.items.first;
    if (dropdownValue != "None") {
      BlocProvider.of<CurrentMenuPageSectionCubit>(context).updateMenuSection(
        BlocProvider.of<MenuSectionsCubit>(context)
            .state
            .menuSections
            .firstWhere((ms) => ms.name == dropdownValue));
    }
  } // initState

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: 10.0,
      alignedDropdown: true,
      child: DropdownButton<String>(
        value: dropdownValue,
        icon: const Icon(Icons.keyboard_arrow_down),
        elevation: 12,
        isDense: true,
        underline: Container(),
        dropdownColor: Colors.grey.shade300,
        selectedItemBuilder: (context) {
          return widget.items.map((String value) {
            return Text(value, style: const TextStyle(fontSize: kfontSizeBase));
          }).toList();
        },
        onChanged: (String? val) {
          BlocProvider.of<CurrentMenuPageSectionCubit>(context)
              .updateMenuSection(
            BlocProvider.of<MenuSectionsCubit>(context)
                .state
                .menuSections
                .firstWhere((MenuSection ms) => ms.name == val),
          );
          setState(() {
            dropdownValue = val!;
          });
        },
        items: widget.items.map<DropdownMenuItem<String>>((String val) {
          return DropdownMenuItem<String>(
              value: val,
              child:
                  Text(val, style: const TextStyle(fontSize: kfontSizeBase)));
        }).toList(),
      ),
    );
  } // build
} // _DropdownEventsFilterState
