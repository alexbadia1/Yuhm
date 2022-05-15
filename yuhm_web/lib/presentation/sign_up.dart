import 'dart:convert';
import 'package:crclib/catalog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:yuhm_web/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuhm_web/logic/blocs/restaurant_bloc.dart';
import 'package:yuhm_web/logic/cubits/current_menu_page_section_cubit.dart';
import 'package:yuhm_web/logic/cubits/menu_sections_cubit.dart';
import 'package:yuhm_web/logic/models/menu.dart';
import 'package:yuhm_web/presentation/util.dart';
import '../logic/cubits/current_menu_section_cubit.dart';
import '../logic/models/menu_page.dart';
import '../logic/models/menu_section.dart';
import '../logic/models/restaurant.dart';
import '../logic/models/special.dart';
import 'package:qr_flutter/qr_flutter.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final double sectionHeight = (MediaQuery.of(context).size.height * .9) - 16;
    return SliverToBoxAdapter(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: MultiBlocProvider(
          providers: [
            BlocProvider<MenuSectionsCubit>(create: (_) => MenuSectionsCubit()),
            BlocProvider<CurrentMenuSectionCubit>(
                create: (_) => CurrentMenuSectionCubit()),
          ],
          child: Column(
            children: [
              kVerticalSpacer(),
              const Text(
                "Restaurant Sign up Form",
                style: TextStyle(
                  fontSize: kfontSizeLarge,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width * .17),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      kVerticalSpacer(),
                      kVerticalSpacer(),
                      const RestaurantInfo(),
                      kVerticalSpacer(),
                      kVerticalSpacer(),
                      const MenuSections(),
                      kVerticalSpacer(),
                      const AddMenus(),
                      kVerticalSpacer(),
                      kVerticalSpacer(),
                      const SignUpSpecials(),
                      kVerticalSpacer(),
                      kVerticalSpacer(),
                      Builder(builder: (_) {
                        final state = _.watch<RestaurantBloc>().state;
                        if (state is RestaurantSubmitting) {
                          return SizedBox(
                            width: MediaQuery.of(_).size.width * .66,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Submitting",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: kfontSizeBase),
                                ),
                                JumpingDotsProgressIndicator(
                                  fontSize: kfontSizeBase,
                                ),
                              ],
                            ),
                          );
                        }
                        return Visibility(
                          visible: state is RestaurantInitial,
                          child: SizedBox(
                            width: MediaQuery.of(_).size.width * .66,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                primary: Colors.white,
                                backgroundColor: Colors.deepOrange,
                              ),
                              child: const Text(
                                "Submit",
                                style: TextStyle(fontSize: kfontSizeBase),
                              ),
                              onPressed: () async {
                                final restaurant =
                                    BlocProvider.of<RestaurantBloc>(_)
                                        .state
                                        .restaurant;
                                final String pin = Crc32Xz()
                                    .convert(utf8.encode(restaurant.toString()))
                                    .toRadixString(16);
                                final updatedRestaurant =
                                    restaurant.copyWith(pin: pin);
                                BlocProvider.of<RestaurantBloc>(_).add(
                                  UpdateRestaurant(updatedRestaurant),
                                );
                                BlocProvider.of<RestaurantBloc>(_).add(
                                  SubmitRestaurant(updatedRestaurant),
                                );
                              },
                            ),
                          ),
                        );
                      }),
                      kVerticalSpacer(),
                      kVerticalSpacer(),
                    ],
                  ),
                ],
              ),
              Builder(builder: (_) {
                final state = _.watch<RestaurantBloc>().state;

                return Visibility(
                  visible: state is RestaurantSubmitSuccess,
                  child: SizedBox(
                    height: sectionHeight * .5,
                    width: MediaQuery.of(_).size.width * .5,
                    child: Column(
                      children: [
                        const Text(
                          "You Unique Restaurant PIN and QR Code:",
                          style: TextStyle(
                            fontSize: kfontSizeLarge,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        kVerticalSpacer(),
                        kVerticalSpacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // Pin
                            SizedBox(
                              width: kfontSizeBase * 10,
                              height: kfontSizeBase * 10,
                              child: Center(
                                child: Text(
                                  BlocProvider.of<RestaurantBloc>(_)
                                          .state
                                          .restaurant
                                          .pin ??
                                      "[PIN]",
                                  style: const TextStyle(
                                      fontSize: kfontSizeLarge,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),

                            // Qr Code
                            SizedBox(
                              width: kfontSizeBase * 10,
                              height: kfontSizeBase * 10,
                              child: Center(
                                child: QrImage(
                                  data: BlocProvider.of<RestaurantBloc>(_)
                                          .state
                                          .restaurant
                                          .pin ??
                                      "[PIN]",
                                  version: QrVersions.auto,
                                  size: 320,
                                  gapless: false,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class RestaurantInfo extends StatelessWidget {
  const RestaurantInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width * .3;
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Restaurant Info",
          style: TextStyle(fontSize: kfontSizeLarge),
        ),
        const SizedBox(height: kfontSizeBase),
        const Text(
          "*Please tell us about your restaurant and upload a logo.",
          style: TextStyle(fontSize: kfontSizeBase),
        ),
        kVerticalSpacer(),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: _width,
                  child: SignUpTextField(
                    label: "Restaurant Name",
                    hintText: "McKinney & Doyle",
                    onChange: (String val) {
                      BlocProvider.of<RestaurantBloc>(context).add(
                        UpdateRestaurant(
                          BlocProvider.of<RestaurantBloc>(context)
                              .state
                              .restaurant
                              .copyWith(name: val.trim()),
                        ),
                      );
                    },
                  ),
                ),
                kVerticalSpacer(),
                SizedBox(
                  width: _width,
                  child: SignUpTextField(
                    label: "Restaurant Description",
                    hintText: "Serving excellence since 1985!",
                    onChange: (String val) {
                      BlocProvider.of<RestaurantBloc>(context).add(
                        UpdateRestaurant(
                          BlocProvider.of<RestaurantBloc>(context)
                              .state
                              .restaurant
                              .copyWith(description: val.trim()),
                        ),
                      );
                    },
                  ),
                ),
                kVerticalSpacer(),
                SizedBox(
                  width: _width,
                  child: SignUpTextField(
                    label: "Restaurant Full Address",
                    hintText: "123 Main Street",
                    onChange: (String val) {
                      BlocProvider.of<RestaurantBloc>(context).add(
                        UpdateRestaurant(
                          BlocProvider.of<RestaurantBloc>(context)
                              .state
                              .restaurant
                              .copyWith(address: val.trim()),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            kHorizontalSpacer(),
            ImageUploadBox(
              imageBytes: context.watch<RestaurantBloc>().state.restaurant.logo,
              imageUploadButtonOnPress: () async {
                FilePickerResult? result =
                    await FilePicker.platform.pickFiles();
                if (result != null) {
                  final r =
                      BlocProvider.of<RestaurantBloc>(context).state.restaurant;
                  BlocProvider.of<RestaurantBloc>(context).add(
                    UpdateRestaurant(
                      r.copyWith(logo: result.files.single.bytes),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}

/// Menu Sections
///
/// User declares New Menu Sections that can be assigned to menu pages later in
/// the form. The Pool of Menu Sections are listed off to the right in a "tag"
/// like widget that has an "x" on it to delete them.
class MenuSections extends StatelessWidget {
  const MenuSections({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final _width = MediaQuery.of(context).size.width * .3;
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Menu Sections",
            style: TextStyle(fontSize: kfontSizeLarge),
          ),
          const SizedBox(height: kfontSizeBase),
          const Text(
            "*Please name and describe each section of your menu.",
            style: TextStyle(fontSize: kfontSizeBase),
          ),
          SizedBox(
            height: kfontSizeBase * 17.5,
            child: CustomListTile(
              //================================================================
              // Menu Section Name
              //================================================================
              title: SizedBox(
                width: _width,
                child: TextFormField(
                  decoration: kInputDecoration.copyWith(
                    label: const Text("New Menu Section Name"),
                    hintText: "Appetizers",
                  ),
                  validator: (String? val) {
                    if (val == null) return 'Name cannot be null';
                    if (val.isEmpty) return 'Name cannot be empty';
                    final currMenuSections =
                        BlocProvider.of<MenuSectionsCubit>(context)
                            .state
                            .menuSections;
                    if (!currMenuSections.every((e) => e.name != val)) {
                      return 'Section name already exists';
                    }
                    return null;
                  },
                  onChanged: (String newName) {
                    BlocProvider.of<CurrentMenuSectionCubit>(context)
                        .updateMenuSection(
                      BlocProvider.of<CurrentMenuSectionCubit>(context)
                          .state
                          .menuSection
                          .copyWith(name: newName),
                    );
                  },
                ),
              ),

              //================================================================
              // Menu Section Description
              //================================================================
              subtitle: SizedBox(
                width: _width,
                child: TextFormField(
                  decoration: kInputDecoration.copyWith(
                    label: const Text("New Menu Section Description"),
                    hintText: "Unlimited breadsticks!",
                  ),
                  validator: (String? val) {
                    if (val == null) return 'Description cannot be null';
                    if (val.isEmpty) return 'Description cannot be empty';
                    return null;
                  },
                  onChanged: (String newDescription) {
                    BlocProvider.of<CurrentMenuSectionCubit>(context)
                        .updateMenuSection(
                      BlocProvider.of<CurrentMenuSectionCubit>(context)
                          .state
                          .menuSection
                          .copyWith(description: newDescription),
                    );
                  },
                ),
              ),

              //==================================================================
              // Menu Section Create Button
              //==================================================================
              description: SizedBox(
                width: _width,
                height: kfontSizeBase * 1.8,
                child: TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.deepOrange,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Add New Menu Section",
                        style: TextStyle(fontSize: kfontSizeBase),
                      ),
                      SizedBox(width: kfontSizeBase * .5),
                      Icon(Icons.chevron_right, size: kfontSizeBase * 1.25),
                    ],
                  ),
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) return;
                    final currMenuSections =
                        BlocProvider.of<MenuSectionsCubit>(context)
                            .state
                            .menuSections;
                    final currMenuSection =
                        BlocProvider.of<CurrentMenuSectionCubit>(context)
                            .state
                            .menuSection;
                    List<MenuSection> mutableMenuSections =
                        List<MenuSection>.from(currMenuSections);
                    mutableMenuSections.add(currMenuSection.copyWith(
                        id: "Menu Section ${UniqueKey().hashCode}"));
                    BlocProvider.of<MenuSectionsCubit>(context)
                        .updateMenuSections(mutableMenuSections);
                  },
                ),
              ),

              //========================================================================
              // Window of All created Menu Sections
              //========================================================================
              trailing: const MenuSectionListView(),
            ),
          ),
        ],
      ),
    );
  }
}

class MenuSectionListView extends StatelessWidget {
  const MenuSectionListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const _width = kfontSizeBase * 30;
    const _height = kfontSizeBase * 15;
    final currMenuSections =
        context.watch<MenuSectionsCubit>().state.menuSections;

    if (currMenuSections.isEmpty) {
      return Container(
        height: _height,
        width: _width,
        color: Colors.grey.shade200,
        child: const Center(
          child: Text("No Menu Sections",
              style: TextStyle(fontSize: kfontSizeBase)),
        ),
      );
    }

    // Only declare a scroll controller, if it's going to be attached
    final ScrollController _sc = ScrollController();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _sc.animateTo(
        _sc.position.maxScrollExtent,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeIn,
      );
    });

    return Container(
      height: _height,
      width: _width,
      color: Colors.grey.shade200,
      child: ListView.builder(
        // TODO: Add logic to automatically scroll to the bottom of the list view
        controller: _sc,
        shrinkWrap: true,
        itemCount: currMenuSections.length,
        itemBuilder: (BuildContext context, int index) {
          return SizedBox(
            key: Key("Menu Sections section id ${currMenuSections[index].id}"),
            height: _height * .25,
            child: ListTile(
              title: Text(currMenuSections[index].name ?? "",
                  style: const TextStyle(fontSize: kfontSizeBase)),
              subtitle: Text(currMenuSections[index].description ?? "",
                  style: const TextStyle(fontSize: kfontSizeBase)),
              trailing: TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.red.shade400,
                  textStyle: const TextStyle(fontSize: kfontSizeBase),
                ),
                child: const Icon(Icons.delete),
                onPressed: () {
                  final currMenuSections =
                      BlocProvider.of<MenuSectionsCubit>(context)
                          .state
                          .menuSections;
                  List<MenuSection> mutableMenuSections =
                      List<MenuSection>.from(currMenuSections);
                  mutableMenuSections.removeAt(index);
                  BlocProvider.of<MenuSectionsCubit>(context)
                      .updateMenuSections(mutableMenuSections);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

///=============================================================================
/// Menus
///
/// Enables user to upload multiple menus. Each menu has it's own menu pages.
///=============================================================================
class AddMenus extends StatelessWidget {
  const AddMenus({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width * .3;
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: _width + kfontSizeBase * 30 + kfontSizeBase * 4.5,
          child: Row(
            children: [
              const Text(
                "Menus",
                style: TextStyle(fontSize: kfontSizeLarge),
              ),
              const Expanded(child: SizedBox()),
              TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.greenAccent,
                  textStyle: const TextStyle(fontSize: kfontSizeBase * 1.2),
                ),
                child: Row(children: const [
                  Icon(Icons.add, size: kfontSizeBase * 1.2),
                  Text("New Menu"),
                ]),
                onPressed: () {
                  final menus = BlocProvider.of<RestaurantBloc>(context)
                      .state
                      .restaurant
                      .menus
                      .toList();
                  menus.add(
                      Menu.nullConstructor(id: "Menu ${UniqueKey().hashCode}"));
                  BlocProvider.of<RestaurantBloc>(context).add(
                    UpdateRestaurant(
                      BlocProvider.of<RestaurantBloc>(context)
                          .state
                          .restaurant
                          .copyWith(menus: menus),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        kVerticalSpacer(),
        const MenusListView(),
      ],
    );
  }
}

class MenusListView extends StatelessWidget {
  const MenusListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const _width = kfontSizeBase * 30;
    const _height = kfontSizeBase * 13;
    final menus =
        context.watch<RestaurantBloc>().state.restaurant.menus.toList();

    if (menus.isEmpty) {
      return Container(
        height: _height,
        width: _width * 2.1,
        color: Colors.grey.shade200,
        child: const Center(
          child: Text("No Menus", style: TextStyle(fontSize: kfontSizeBase)),
        ),
      );
    }

    return Container(
      width: _width * 2.1,
      color: Colors.grey.shade200,
      child: ListView.builder(
        controller: ScrollController(),
        shrinkWrap: true,
        itemCount: menus.length,
        itemBuilder: (BuildContext context, int index) {
          return MenuCard(
            key: Key("Menu Card ${menus[index].id}"),
            index: index,
            width: _width,
          );
        },
      ),
    );
  }
}

class MenuCard extends StatelessWidget {
  final int index;
  final double width;

  const MenuCard({
    Key? key,
    required this.index,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //==================================================================
          // Menu Index
          //==================================================================
          SizedBox(
            width: width + kfontSizeBase * 30 + kfontSizeBase * 1.5,
            child: Row(
              children: [
                Text(
                  "Menu ${index + 1}",
                  style: const TextStyle(fontSize: kfontSizeBase * 1.2),
                ),
                const Expanded(child: SizedBox()),
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.redAccent,
                    textStyle: const TextStyle(fontSize: kfontSizeBase),
                  ),
                  child: Row(children: const [
                    Icon(Icons.delete, size: kfontSizeBase * 1.2),
                    Text("Delete Menu"),
                  ]),
                  onPressed: () {
                    final menus = BlocProvider.of<RestaurantBloc>(context)
                        .state
                        .restaurant
                        .menus
                        .toList();
                    menus.removeAt(index);
                    BlocProvider.of<RestaurantBloc>(context).add(
                      UpdateRestaurant(
                        BlocProvider.of<RestaurantBloc>(context)
                            .state
                            .restaurant
                            .copyWith(menus: menus),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: kfontSizeBase),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  //============================================================
                  // Menu Name
                  //============================================================
                  SizedBox(
                    width: width,
                    child: TextFormField(
                      initialValue: BlocProvider.of<RestaurantBloc>(context)
                          .state
                          .restaurant
                          .menus[index]
                          .name,
                      decoration: kInputDecoration.copyWith(
                        label: const Text("New Menu Name"),
                        hintText: "Dinner Menu",
                      ),
                      validator: (String? val) {
                        if (val == null) return 'Name cannot be null';
                        if (val.isEmpty) return 'Name cannot be empty';
                        return null;
                      },
                      onChanged: (String newName) {
                        if (newName.trim().isEmpty) {
                          return;
                        }
                        final r = BlocProvider.of<RestaurantBloc>(context)
                            .state
                            .restaurant;
                        final updatedMenus =
                            BlocProvider.of<RestaurantBloc>(context)
                                .state
                                .restaurant
                                .menus
                                .toList();
                        updatedMenus[index] =
                            updatedMenus[index].copyWith(name: newName);
                        BlocProvider.of<RestaurantBloc>(context).add(
                          UpdateRestaurant(
                            r.copyWith(menus: updatedMenus),
                          ),
                        );
                      },
                    ),
                  ),
                  kVerticalSpacer(),
                  //============================================================
                  // Menu Description
                  //============================================================
                  SizedBox(
                    width: kfontSizeBase * 30,
                    child: TextFormField(
                      initialValue: BlocProvider.of<RestaurantBloc>(context)
                          .state
                          .restaurant
                          .menus[index]
                          .description,
                      decoration: kInputDecoration.copyWith(
                        label: const Text("New Menu Description"),
                        hintText: "Dinner is served at 7:00 PM and later.",
                      ),
                      minLines: 4,
                      maxLines: 4,
                      validator: (String? val) {
                        if (val == null) return 'Description cannot be null';
                        if (val.isEmpty) return 'Description cannot be empty';
                        return null;
                      },
                      onChanged: (String newDescription) {
                        if (newDescription.trim().isEmpty) {
                          return;
                        }
                        final r = BlocProvider.of<RestaurantBloc>(context)
                            .state
                            .restaurant;
                        final updatedMenus =
                            BlocProvider.of<RestaurantBloc>(context)
                                .state
                                .restaurant
                                .menus
                                .toList();
                        updatedMenus[index] = updatedMenus[index]
                            .copyWith(description: newDescription);
                        BlocProvider.of<RestaurantBloc>(context).add(
                          UpdateRestaurant(
                            r.copyWith(menus: updatedMenus),
                          ),
                        );
                      },
                    ),
                  ),
                  kVerticalSpacer(),
                  //============================================================
                  // Menu Add Button
                  //============================================================
                  SizedBox(
                    width: width,
                    height: kfontSizeBase * 1.8,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.deepOrange,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "Add Menu Page",
                            style: TextStyle(fontSize: kfontSizeBase),
                          ),
                          SizedBox(width: kfontSizeBase * .5),
                          Icon(Icons.chevron_right, size: kfontSizeBase * 1.25),
                        ],
                      ),
                      onPressed: () {
                        final r = BlocProvider.of<RestaurantBloc>(context)
                            .state
                            .restaurant;
                        final updatedMenus =
                            BlocProvider.of<RestaurantBloc>(context)
                                .state
                                .restaurant
                                .menus
                                .toList();
                        final updatedMenuPages =
                            updatedMenus[index].menuPages.toList();
                        updatedMenuPages.add(
                          MenuPage.nullConstructor(
                            id: "Menu Page ${UniqueKey().hashCode}",
                          ),
                        );
                        updatedMenus[index] = updatedMenus[index]
                            .copyWith(menuPages: updatedMenuPages);
                        BlocProvider.of<RestaurantBloc>(context).add(
                          UpdateRestaurant(
                            r.copyWith(menus: updatedMenus),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          AddMenuPages(width: width, menuIndex: index),
        ],
      ),
    );
  }
}

///=============================================================================
/// Menu Pages
///
/// Section of the Restaurant sign up form to add images of menus. The list view
/// is re-orderable, in case the user uploads the menus in the wrong order.
///=============================================================================
class AddMenuPages extends StatelessWidget {
  final int menuIndex;
  final double width;
  const AddMenuPages({Key? key, required this.menuIndex, required this.width})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final menus =
        context.watch<RestaurantBloc>().state.restaurant.menus.toList();
    final menuPages = context
        .watch<RestaurantBloc>()
        .state
        .restaurant
        .menus[menuIndex]
        .menuPages
        .toList();

    if (menuPages.isEmpty) {
      return const SizedBox();
    }

    // Generate children
    List<Widget> menuPageCards = [];
    for (int menuPageIndex = 0;
        menuPageIndex < menuPages.length;
        menuPageIndex += 1) {
      menuPageCards.add(
        MultiBlocProvider(
          key: Key("Menu Page Card Key ${menuPages[menuPageIndex].id}"),
          providers: [
            BlocProvider<RestaurantBloc>.value(
              value: BlocProvider.of<RestaurantBloc>(context),
            ),
            BlocProvider<CurrentMenuPageSectionCubit>(
              create: (_) => CurrentMenuPageSectionCubit(),
            ),
            BlocProvider<MenuSectionsCubit>.value(
              value: BlocProvider.of<MenuSectionsCubit>(context),
            )
          ],
          child: Row(
            children: [
              const SizedBox(width: kfontSizeBase * 2),
              MenuPageCard(
                menuIndex: menuIndex,
                menuPageIndex: menuPageIndex,
              ),
            ],
          ),
        ),
      );
    }

    return ReorderableListView(
      shrinkWrap: true,
      children: menuPageCards,
      onReorder: (int oldIndex, int newIndex) {
        if (oldIndex < newIndex) {
          newIndex -= 1;
        }
        final MenuPage tmp = menuPages.removeAt(oldIndex);
        menuPages.insert(newIndex, tmp);
        menus[menuIndex] = menus[menuIndex].copyWith(menuPages: menuPages);
        BlocProvider.of<RestaurantBloc>(context).add(
          UpdateRestaurant(
            BlocProvider.of<RestaurantBloc>(context)
                .state
                .restaurant
                .copyWith(menus: menus),
          ),
        );
      },
    );
  }
}

class MenuPageCard extends StatelessWidget {
  final int menuIndex;
  final int menuPageIndex;
  const MenuPageCard({
    Key? key,
    required this.menuIndex,
    required this.menuPageIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MenuPage menuPage = BlocProvider.of<RestaurantBloc>(context)
        .state
        .restaurant
        .menus[menuIndex]
        .menuPages[menuPageIndex];

    final double _width = MediaQuery.of(context).size.width * .3;

    return SizedBox(
      width: _width * 2,
      height: kfontSizeBase * 20,
      child: CustomListTile(
        // Sections
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Page $menuPageIndex",
                style: const TextStyle(fontSize: kfontSizeBase * 1.2)),
            kVerticalSpacer(),
            SizedBox(
              width: _width,
              height: kfontSizeBase * 10,
              child: MenuPageSectionsListView(
                menuIndex: menuIndex,
                menuPageIndex: menuPageIndex,
              ),
            ),
          ],
        ),

        // Dropdown
        description: SizedBox(
          width: _width,
          height: kfontSizeBase * 2,
          child: Row(
            children: [
              Builder(builder: (_) {
                final ms = _.watch<MenuSectionsCubit>().state.menuSections;
                return Dropdown(items: ms.map((e) => e.name ?? "").toList());
              }),
              TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: kfontSizeBase * 1.25,
                    vertical: kfontSizeBase * 1,
                  ),
                  textStyle: const TextStyle(
                    fontSize: kfontSizeBase,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.deepOrange,
                ),
                onPressed: () {
                  final r =
                      BlocProvider.of<RestaurantBloc>(context).state.restaurant;
                  final updatedMenus = BlocProvider.of<RestaurantBloc>(context)
                      .state
                      .restaurant
                      .menus
                      .toList();
                  final updatedMenuPages =
                      BlocProvider.of<RestaurantBloc>(context)
                          .state
                          .restaurant
                          .menus[menuIndex]
                          .menuPages
                          .toList();
                  final updatedMenuPageSection =
                      BlocProvider.of<RestaurantBloc>(context)
                          .state
                          .restaurant
                          .menus[menuIndex]
                          .menuPages[menuPageIndex]
                          .menuSections
                          .toList();

                  // Add current Section to Menu Page
                  updatedMenuPageSection.add(
                    BlocProvider.of<MenuSectionsCubit>(context)
                        .state
                        .menuSections
                        .firstWhere((ms) =>
                            ms.id ==
                            BlocProvider.of<CurrentMenuPageSectionCubit>(
                                    context)
                                .state
                                .menuSection
                                .id),
                  );
                  updatedMenuPages[menuPageIndex] =
                      updatedMenuPages[menuPageIndex].copyWith(
                    menuSections: updatedMenuPageSection,
                  );

                  // Update Menus
                  updatedMenus[menuIndex] = updatedMenus[menuIndex]
                      .copyWith(menuPages: updatedMenuPages);
                  BlocProvider.of<RestaurantBloc>(context).add(
                    UpdateRestaurant(
                      r.copyWith(menus: updatedMenus),
                    ),
                  );
                },
                child: const Text('Add Section'),
              ),
            ],
          ),
        ),
        trailing: ImageUploadBox(
          key: Key("Menu Page's Image ${menuPage.id}"),
          imageBytes: menuPage.imageBytes,
          backgroundColor: Colors.grey.shade300,
          imageUploadButtonOnPress: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles();
            if (result != null) {
              final r =
                  BlocProvider.of<RestaurantBloc>(context).state.restaurant;
              final updatedMenus = BlocProvider.of<RestaurantBloc>(context)
                  .state
                  .restaurant
                  .menus
                  .toList();
              final updatedMenuPages = BlocProvider.of<RestaurantBloc>(context)
                  .state
                  .restaurant
                  .menus[menuIndex]
                  .menuPages
                  .toList();
              updatedMenuPages[menuPageIndex] = updatedMenuPages[menuPageIndex]
                  .copyWith(imageBytes: result.files.single.bytes);
              updatedMenus[menuIndex] =
                  updatedMenus[menuIndex].copyWith(menuPages: updatedMenuPages);
              BlocProvider.of<RestaurantBloc>(context).add(
                UpdateRestaurant(
                  r.copyWith(menus: updatedMenus),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

/// All the Menu Sections Assigned to the Menu
class MenuPageSectionsListView extends StatelessWidget {
  final int menuIndex;
  final int menuPageIndex;
  const MenuPageSectionsListView({
    Key? key,
    required this.menuIndex,
    required this.menuPageIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width * .25;
    final menuSections = context
        .watch<RestaurantBloc>()
        .state
        .restaurant
        .menus[menuIndex]
        .menuPages[menuPageIndex]
        .menuSections
        .toList();

    if (menuSections.isEmpty) {
      return Container(
        width: _width,
        color: Colors.grey.shade300,
        child: const Center(
          child: Text(
            "No Menu Sections",
            style: TextStyle(fontSize: kfontSizeBase),
          ),
        ),
      );
    }

    final ScrollController _sc = ScrollController();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _sc.animateTo(
        _sc.position.maxScrollExtent,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeIn,
      );
    });

    return Container(
      width: _width,
      color: Colors.grey.shade300,
      child: ListView.builder(
        controller: _sc,
        shrinkWrap: true,
        itemCount: menuSections.length,
        itemBuilder: (BuildContext context, int index) {
          return SizedBox(
            key: Key("Menu Page Sections ${menuSections[index].id}"),
            height: kfontSizeBase * 3,
            child: ListTile(
              title: Text(menuSections[index].name ?? "",
                  style: const TextStyle(fontSize: kfontSizeBase)),
              subtitle: Text(menuSections[index].description ?? "",
                  style: const TextStyle(fontSize: kfontSizeBase)),
              trailing: TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.red.shade400,
                  textStyle: const TextStyle(fontSize: kfontSizeBase),
                ),
                child: const Icon(Icons.delete),
                onPressed: () {
                  final r =
                      BlocProvider.of<RestaurantBloc>(context).state.restaurant;
                  final updatedMenus = BlocProvider.of<RestaurantBloc>(context)
                      .state
                      .restaurant
                      .menus
                      .toList();
                  final updatedMenuPages =
                      BlocProvider.of<RestaurantBloc>(context)
                          .state
                          .restaurant
                          .menus[menuIndex]
                          .menuPages
                          .toList();
                  final updatedMenuPageSection =
                      BlocProvider.of<RestaurantBloc>(context)
                          .state
                          .restaurant
                          .menus[menuIndex]
                          .menuPages[menuPageIndex]
                          .menuSections
                          .toList();

                  // Add current Section to Menu Page
                  updatedMenuPageSection.removeAt(index);
                  updatedMenuPages[menuPageIndex] =
                      updatedMenuPages[menuPageIndex].copyWith(
                    menuSections: updatedMenuPageSection,
                  );

                  // Update Menus
                  updatedMenus[menuIndex] = updatedMenus[menuIndex]
                      .copyWith(menuPages: updatedMenuPages);
                  BlocProvider.of<RestaurantBloc>(context).add(
                    UpdateRestaurant(
                      r.copyWith(menus: updatedMenus),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

///=============================================================================
/// Special
///
/// Section of the Restaurant sign up form to add images of specials. The list
/// view is re-orderable, if the user uploads the specials in the wrong order.
///=============================================================================
class SignUpSpecials extends StatelessWidget {
  const SignUpSpecials({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final specials =
        context.watch<RestaurantBloc>().state.restaurant.specials.toList();
    final _width = MediaQuery.of(context).size.width * .3;
    return SizedBox(
      width: _width + kfontSizeBase * 30 + kfontSizeBase * 4.5,
      child: DraggableListView(
        title: "Specials, Deals, Promotions, etc.",
        mapItemsToWidgets: () {
          List<Widget> items = [];
          for (int index = 0; index < specials.length; index += 1) {
            items.add(
              BlocProvider.value(
                key: Key(specials[index].id!),
                value: BlocProvider.of<RestaurantBloc>(context),
                child: SpecialsCard(
                  index: index,
                ),
              ),
            );
          }
          return items;
        },
        addItemButtonTitle: "New Special",
        onAddItem: () {
          specials.add(
              Special.nullConstructor(id: "Special ${UniqueKey().hashCode}"));
          BlocProvider.of<RestaurantBloc>(context).add(
            UpdateRestaurant(
              BlocProvider.of<RestaurantBloc>(context)
                  .state
                  .restaurant
                  .copyWith(specials: specials),
            ),
          );
        },
        onReorder: (int oldIndex, int newIndex) {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final Special tmp = specials.removeAt(oldIndex);
          specials.insert(newIndex, tmp);
          BlocProvider.of<RestaurantBloc>(context).add(
            UpdateRestaurant(
              BlocProvider.of<RestaurantBloc>(context)
                  .state
                  .restaurant
                  .copyWith(specials: specials),
            ),
          );
        },
      ),
    );
  }
}

class SpecialsCard extends StatelessWidget {
  final int index;
  const SpecialsCard({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Restaurant r = context.watch<RestaurantBloc>().state.restaurant;
    final List<Special> specials = r.specials.toList();
    final Special special = specials[index];
    final _width = MediaQuery.of(context).size.width * .3;
    return SizedBox(
      width: _width + kfontSizeBase * 30 + kfontSizeBase * 1.5,
      height: kfontSizeBase * 14,
      child: CustomListTile(
        title: SizedBox(
          width: _width,
          child: SignUpTextField(
            hintText: "Now Serving Boba Tea",
            label: "Special Name",
            onChange: (String val) {
              specials[index] = special.copyWith(name: val.trim());
              BlocProvider.of<RestaurantBloc>(context).add(
                UpdateRestaurant(r.copyWith(specials: specials)),
              );
            },
          ),
        ),
        subtitle: SizedBox(
          width: _width,
          child: SignUpTextField(
            label: "Special Description",
            hintText: "A limited summer promotion serving Boba Tea",
            onChange: (String val) {
              specials[index] = special.copyWith(description: val.trim());
              BlocProvider.of<RestaurantBloc>(context).add(
                UpdateRestaurant(r.copyWith(specials: specials)),
              );
            },
          ),
        ),
        description: SizedBox(
          width: _width,
          child: Builder(builder: (context) {
            return ImageUploadButton(
              context: context,
              buttonText: special.imageBytes == null ? "Upload" : "Re-upload",
              onPress: () async {
                FilePickerResult? result =
                    await FilePicker.platform.pickFiles();
                if (result != null) {
                  specials[index] =
                      special.copyWith(imageBytes: result.files.first.bytes);
                  BlocProvider.of<RestaurantBloc>(context).add(
                    UpdateRestaurant(r.copyWith(specials: specials)),
                  );
                }
              },
            );
          }),
        ),
        trailing: ImageUploadBox(
          key: Key("Special's Image ${special.id}"),
          showButtons: false,
          imageBytes: special.imageBytes,
        ),
      ),
    );
  }
}
