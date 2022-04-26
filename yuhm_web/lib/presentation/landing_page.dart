import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuhm_web/logic/cubits/appbar_cubit.dart';
import 'package:yuhm_web/presentation/how_it_works.dart';
import 'package:yuhm_web/presentation/subscriptions.dart';
import 'package:yuhm_web/presentation/welcome.dart';

import '../constants.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double sectionHeight = (MediaQuery.of(context).size.height * .9) - 16;
    final double appBarHeight = (MediaQuery.of(context).size.height * .1) - 16;
    final ScrollController _csc = ScrollController();
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification info) {
        final currColor = BlocProvider.of<AppbarCubit>(context).state.color;
        if (_csc.offset <= appBarHeight && currColor != kLandingPageColor) {
          BlocProvider.of<AppbarCubit>(context)
              .updateAppBarArgs(kLandingPageColor, ktextColor);
        } else if (_csc.offset > appBarHeight && currColor != Colors.white) {
          BlocProvider.of<AppbarCubit>(context)
              .updateAppBarArgs(Colors.white, Colors.black);
        }
        return false;
      },
      child: Scaffold(
        body: CustomScrollView(
          controller: _csc,
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              toolbarHeight: appBarHeight,
              elevation: 0.0,
              pinned: true,
              floating: true,
              flexibleSpace: CustomAppbar(height: appBarHeight),
            ),
            Welcome(sectionHeight),
            SliverToBoxAdapter(child: SizedBox(height: appBarHeight)),

            /// Our Services Header
            SliverToBoxAdapter(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * .35,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RichText(
                      text: const TextSpan(
                        text: "Our ",
                        style: TextStyle(
                            fontSize: kfontSizeLarge, color: Colors.black),
                        children: [
                          TextSpan(
                            text: "Service",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: appBarHeight * .3),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .35,
                      child: Flex(
                        direction: Axis.horizontal,
                        children: const [
                          Flexible(
                            child: Text(
                              "We automatically digitalize restaurant menus and "
                              "generate QR codes so your customers can send "
                              "orders directly to the chef right in our app!",
                              maxLines: null,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w100,
                                fontStyle: FontStyle.italic,
                                fontSize: kfontSizeBase,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: appBarHeight)),
            HowItWorks(sectionHeight),
            SliverToBoxAdapter(
              child: Container(
                height: appBarHeight,
                color: kLandingPageColorSecondary,
              ),
            ),

            /// Subscription Header
            SliverToBoxAdapter(
              child: Container(
                color: kLandingPageColorSecondary,
                width: MediaQuery.of(context).size.width * .35,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RichText(
                      text: const TextSpan(
                        text: "Subscriptions ",
                        style: TextStyle(fontSize: kfontSizeLarge),
                        children: [
                          TextSpan(
                            text: "Cancel Anytime",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: appBarHeight * .3),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .35,
                      child: Flex(
                        direction: Axis.horizontal,
                        children: const [
                          Flexible(
                            child: Text(
                              "From app ordering services, data storage, analysis, "
                              "and presentation to business intelligence, all plans "
                              "are pay as you go.",
                              maxLines: 100,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w100,
                                fontStyle: FontStyle.italic,
                                fontSize: kfontSizeBase,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Subscriptions(sectionHeight),
            SliverToBoxAdapter(
              child: Container(
                color: kLandingPageColorSecondary,
                width: MediaQuery.of(context).size.width * .35,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Not sure which plan is best for you? ",
                      style: TextStyle(
                        fontSize: kfontSizeBase,
                        color: Colors.black,
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.blueAccent,
                        textStyle: const TextStyle(fontSize: kfontSizeBase),
                      ),
                      onPressed: () {},
                      child: const Text('Contact Us'),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: appBarHeight,
                color: kLandingPageColorSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomAppbar extends StatelessWidget {
  final double height;
  const CustomAppbar({Key? key, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppbarCubit>().state;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      height: height,
      width: double.infinity,
      color: state.color,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: MediaQuery.of(context).size.width * .1),
          Text(
            "Yuhm.",
            style: TextStyle(
              letterSpacing: kfontSizeLarge * .13,
              fontSize: kfontSizeLarge,
              fontWeight: FontWeight.w600,
              color: state.textColor,
            ),
          ),
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    primary: state.textColor,
                    textStyle: const TextStyle(fontSize: kfontSizeBase),
                  ),
                  onPressed: () {},
                  child: const Text('Home'),
                ),
                const SizedBox(width: kfontSizeBase * .25),
                TextButton(
                  style: TextButton.styleFrom(
                    primary: state.textColor,
                    textStyle: const TextStyle(fontSize: kfontSizeBase),
                  ),
                  onPressed: () {},
                  child: const Text('Services'),
                ),
                const SizedBox(width: kfontSizeBase * .25),
                TextButton(
                  style: TextButton.styleFrom(
                    primary: state.textColor,
                    textStyle: const TextStyle(fontSize: kfontSizeBase),
                  ),
                  onPressed: () {},
                  child: const Text('About'),
                ),
                const SizedBox(width: kfontSizeBase * .25),
                TextButton(
                  style: TextButton.styleFrom(
                    primary: state.textColor,
                    textStyle: const TextStyle(fontSize: kfontSizeBase),
                  ),
                  onPressed: () {},
                  child: const Text('Features'),
                ),
                const SizedBox(width: kfontSizeBase * .25),
                TextButton(
                  style: TextButton.styleFrom(
                    primary: state.textColor,
                    textStyle: const TextStyle(fontSize: kfontSizeBase),
                  ),
                  onPressed: () {},
                  child: Row(
                    children: const [
                      Icon(Icons.phone),
                      Text('+1 845 555 555'),
                    ],
                  ),
                ),
                const SizedBox(width: kfontSizeBase * 2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
