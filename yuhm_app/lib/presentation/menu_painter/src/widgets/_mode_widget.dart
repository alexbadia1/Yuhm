import 'package:flutter/material.dart';
import 'package:yuhm_app/presentation/presentation.dart';

class SelectionItems extends StatelessWidget {
  final bool? isSelected;
  final ModeData? data;
  final VoidCallback? onTap;

  const SelectionItems({Key? key, this.isSelected, this.data, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: isSelected! ? Colors.blue : Colors.transparent),
      child: ListTile(
        leading: IconTheme(
          data: const IconThemeData(opacity: 1.0),
          child:
              Icon(data!.icon, color: isSelected! ? Colors.white : Colors.black),
        ),
        title: Text(
          data!.label!,
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
              color: isSelected!
                  ? Colors.white
                  : Theme.of(context).textTheme.bodyText1!.color),
        ),
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
        selected: isSelected!,
      ),
    );
  }
}

const List<ModeData> paintModes = [
  ModeData(icon: Icons.edit, mode: PaintMode.freeStyle, label: "Drawing"),
  ModeData(
      icon: Icons.zoom_out_map, mode: PaintMode.none, label: "None / Zoom"),
];

@immutable
class ModeData {
  final IconData? icon;
  final PaintMode? mode;
  final String? label;
  const ModeData({
    this.icon,
    this.mode,
    this.label,
  });
}
