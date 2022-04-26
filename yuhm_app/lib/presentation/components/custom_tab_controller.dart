import 'package:flutter/material.dart';
import 'package:yuhm_app/logic/logic.dart';

class CustomTabController extends StatefulWidget {
  final int length;

  const CustomTabController({Key? key, required this.length}) : super(key: key);

  @override
  _CustomTabControllerState createState() => _CustomTabControllerState();
}

class _CustomTabControllerState extends State<CustomTabController>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TabPageSelectorCubit>(context).setTabController(
      TabController(
        length: widget.length,
        vsync: this,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TabPageSelectorState _state =
        context.watch<TabPageSelectorCubit>().state;

    if (_state is TabPageSelectorAlive) {
      return TabPageSelector(
        controller: _state.tc,
        color: Colors.transparent,
        selectedColor: Colors.grey,
      );
    }
    return const SizedBox();
  }
}
