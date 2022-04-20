import 'package:flutter/material.dart';

class CustomTabController extends StatefulWidget {
  final int length;

  const CustomTabController({Key? key, required this.length}) : super(key: key);

  @override
  _CustomTabControllerState createState() => _CustomTabControllerState();
}

class _CustomTabControllerState extends State<CustomTabController>
    with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return TabPageSelector(
      controller: _tabController,
      color: Colors.transparent,
      selectedColor: Colors.grey,
    );
  }
}
