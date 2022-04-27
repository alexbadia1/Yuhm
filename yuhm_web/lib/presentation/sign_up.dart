import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:yuhm_web/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuhm_web/logic/blocs/restaurant_bloc.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width * .3;
    final GlobalKey _formKey = GlobalKey();
    return SliverToBoxAdapter(
      child: SizedBox(
        width: _width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SignUpRestaurant(
              formKey: _formKey,
              width: _width,
            ),
          ],
        ),
      ),
    );
  }
}

class SignUpRestaurant extends StatelessWidget {
  final GlobalKey formKey;
  final double width;
  const SignUpRestaurant({
    Key? key,
    required this.formKey,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _vertSpacing(),
        const Text(
          "Restaurant Info",
          style: TextStyle(fontSize: kfontSizeLarge),
        ),
        _vertSpacing(),
        SizedBox(
          width: width,
          child: TextField(
            decoration: _customInputInputDecoration().copyWith(
              hintText: "McKinney & Doyle",
              label: const Text("Restaurant Name"),
            ),
            onChanged: (String val) {
              if (val.isEmpty) return;
              BlocProvider.of<RestaurantBloc>(context)
                  .state
                  .restaurant
                  .copyWith(name: val.trim());
            },
          ),
        ),
        _vertSpacing(),
        SizedBox(
          width: width,
          child: TextField(
            minLines: 3,
            maxLines: 5,
            decoration: _customInputInputDecoration().copyWith(
              hintText: "Serving excellence since 1985!",
              label: const Text("Restaurant Description"),
            ),
            onChanged: (String val) {
              if (val.isEmpty) return;
              BlocProvider.of<RestaurantBloc>(context)
                  .state
                  .restaurant
                  .copyWith(description: val.trim());
            },
          ),
        ),
        _vertSpacing(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: kfontSizeBase * 15,
              width: kfontSizeBase * 15,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.grey.shade200,
                    child: Builder(
                      builder: (context) {
                        final state = context.watch<RestaurantBloc>().state;
                        if (state.restaurant.logo != null) {
                          return AspectRatio(
                            aspectRatio: 4 / 5,
                            child: Image.memory(
                              state.restaurant.logo!,
                              fit: BoxFit.contain,
                            ),
                          );
                        }

                        return const SizedBox();
                      },
                    ),
                  ),
                  Builder(builder: (context) {
                    final state = context.watch<RestaurantBloc>().state;
                    if (state.restaurant.logo == null) {
                      return SizedBox(
                        width: kfontSizeBase * 7,
                        height: kfontSizeBase * 2,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: Colors.deepOrange,
                          ),
                          onPressed: () async {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles();
                            if (result != null) {
                              final r = BlocProvider.of<RestaurantBloc>(context)
                                  .state
                                  .restaurant;
                              BlocProvider.of<RestaurantBloc>(context).add(
                                UpdateRestaurant(
                                  r.copyWith(logo: result.files.single.bytes),
                                ),
                              );
                            } else {
                              // User canceled the picker
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.cloud_upload_outlined,
                                  size: kfontSizeBase * 1.25),
                              SizedBox(width: kfontSizeBase * .5),
                              Text('Upload',
                                  style: TextStyle(fontSize: kfontSizeBase)),
                            ],
                          ),
                        ),
                      );
                    }

                    return const SizedBox();
                  }),
                ],
              ),
            ),
            Builder(builder: (context) {
              final state = context.watch<RestaurantBloc>().state;
              if (state.restaurant.logo != null) {
                return Padding(
                  padding: const EdgeInsets.only(top: kfontSizeBase),
                  child: SizedBox(
                    width: kfontSizeBase * 10,
                    height: kfontSizeBase * 2,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.deepOrange,
                      ),
                      onPressed: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles();
                        if (result != null) {
                          final r = BlocProvider.of<RestaurantBloc>(context)
                              .state
                              .restaurant;
                          BlocProvider.of<RestaurantBloc>(context).add(
                            UpdateRestaurant(
                              r.copyWith(logo: result.files.single.bytes),
                            ),
                          );
                        } else {
                          // User canceled the picker
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.cloud_upload_outlined,
                              size: kfontSizeBase * 1.25),
                          SizedBox(width: kfontSizeBase * .5),
                          Text(
                            'Change Upload',
                            style: TextStyle(fontSize: kfontSizeBase),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }

              return const SizedBox();
            }),
          ],
        ),
      ],
    );
  }

  SizedBox _vertSpacing() {
    return const SizedBox(height: kfontSizeBase * 1.5);
  }

  InputDecoration _customInputInputDecoration() {
    return const InputDecoration(
      border: OutlineInputBorder(),
      alignLabelWithHint: true,
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      floatingLabelAlignment: FloatingLabelAlignment.start,
    );
  }
}

class DraggableListView extends StatefulWidget {
  const DraggableListView({Key? key}) : super(key: key);
  @override
  State<DraggableListView> createState() => _DraggableListViewState();
}

class _DraggableListViewState extends State<DraggableListView> {
  final List<int> _items = List<int>.generate(50, (int index) => index);

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);

    return ReorderableListView(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      children: <Widget>[
        for (int index = 0; index < _items.length; index += 1)
          ListTile(
            key: Key('$index'),
            tileColor: _items[index].isOdd ? oddItemColor : evenItemColor,
            title: Text('Item ${_items[index]}'),
          ),
      ],
      onReorder: (int oldIndex, int newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final int item = _items.removeAt(oldIndex);
          _items.insert(newIndex, item);
        });
      },
    );
  }
}
