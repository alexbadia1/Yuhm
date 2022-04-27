import 'package:flutter/material.dart';

import '../constants.dart';

class Subscriptions extends StatelessWidget {
  final double height;
  const Subscriptions(this.height, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const _flipCardHeight = kfontSizeBase * 33;
    final _width = MediaQuery.of(context).size.width;

    return SliverToBoxAdapter(
      child: Container(
        height: kfontSizeBase * 40,
        width: double.infinity,
        color: kLandingPageColorSecondary,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FlippingCard(
                  width: _width * .25,
                  height: _flipCardHeight,
                  mouseHoverEnabled: true,
                  upFaceContents: FaceUpCard(
                    title: "No Cost Plan",
                    linearGradient: kLinearGradientBlueGrey,
                    faceUpCardSections: const [
                      FaceUpCardSection(
                        title: "Business",
                        items: [
                          "Basic Chef Dashboard Functionality",
                          "10k orders/day (Hard Limit)",
                          "Client Support (Businees Days Only)"
                        ],
                      ),
                      FaceUpCardSection(
                        title: "Data",
                        items: [
                          "No Data Aggregation Tools",
                          "No Data Analytics Tools",
                          "No AI Powered Business Intelligence",
                        ],
                      ),
                    ],
                  ),
                  downFaceContents: Container(
                    child: FaceDownCard(
                      title: "No Costs",
                      description: "No Hidden Fees",
                      buttonTitle: "Sign Up",
                      price: "\$0/month",
                      onPressed: () {
                        print("\$100");
                      },
                    ),
                    decoration:
                        BoxDecoration(gradient: kLinearGradientBlueGrey),
                  ),
                ),
                FlippingCard(
                  width: _width * .25,
                  height:_flipCardHeight,
                  mouseHoverEnabled: true,
                  upFaceContents: FaceUpCard(
                    title: "Spark Plan",
                    linearGradient: kLinearGradientBlue,
                    faceUpCardSections: const [
                      FaceUpCardSection(
                        title: "Business",
                        items: [
                          "Full Chef Dashboard Functionality",
                          "+100k orders/day (Pay as you go)",
                          "24/7 On Call Client Support"
                        ],
                      ),
                      FaceUpCardSection(
                        title: "Data",
                        items: [
                          "Limited Data Aggregation Tools Access",
                          "Limited Data Analytics Tools Access",
                          "Limited AI Powered Business Intelligence Access",
                        ],
                      ),
                    ],
                  ),
                  downFaceContents: Container(
                    child: FaceDownCard(
                      title: "Pay As You Go",
                      description: "Starting At",
                      buttonTitle: "Sign Up",
                      price: "\$60/month",
                      onPressed: () {
                        print("\$100");
                      },
                    ),
                    decoration: BoxDecoration(gradient: kLinearGradientBlue),
                  ),
                ),
                FlippingCard(
                  width: _width * .25,
                  height: _flipCardHeight,
                  mouseHoverEnabled: true,
                  upFaceContents: FaceUpCard(
                    title: "Blaze Plan",
                    linearGradient: kLinearGradientDeepOrange,
                    faceUpCardSections: const [
                      FaceUpCardSection(
                        title: "Business",
                        items: [
                          "Unique Feature Request Priority",
                          "+100M orders/day (unlimited scale)",
                          "On Demand Prioritized Client Support"
                        ],
                      ),
                      FaceUpCardSection(
                        title: "Data",
                        items: [
                          "Full Data Aggregation Tools Access",
                          "Full Data Analytics Tools Access",
                          "Full AI Powered Business Intelligence Access",
                        ],
                      ),
                    ],
                  ),
                  downFaceContents: Container(
                    child: FaceDownCard(
                      title: "Pay As You Go",
                      description: "Starting At",
                      buttonTitle: "Sign Up",
                      price: "\$100/month",
                      onPressed: () {
                        print("\$100");
                      },
                    ),
                    decoration:
                        BoxDecoration(gradient: kLinearGradientDeepOrange),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FaceUpCardSection extends StatelessWidget {
  final String title;
  final List<String> items;

  const FaceUpCardSection({
    Key? key,
    required this.title,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;

    final List<Widget> widgets = [];
    widgets.add(const SizedBox(height: kfontSizeLarge));
    widgets.add(
      Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: kfontSizeXLBase,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
    widgets.add(const SizedBox(height: kfontSizeLarge));
    for (int i = 0; i < items.length; ++i) {
      widgets.add(
        Container(
          padding: const EdgeInsets.only(
            top: kfontSizeBase / 1.5,
            bottom: kfontSizeBase / 1.5,
          ),
          width: _width * .2,
          decoration: i == items.length - 1 ? _verticalBorders() : _topBorder(),
          child: Text(
            items[i],
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: kfontSizeBase,
              color: Colors.black,
            ),
          ),
        ),
      );
    }
    return Column(children: widgets);
  }

  BoxDecoration _verticalBorders() {
    return const BoxDecoration(
      border: Border(
        top: BorderSide(
          width: 1.25,
          color: Color.fromRGBO(61, 61, 61, 1.0),
        ),
        bottom: BorderSide(
          width: 1.25,
          color: Color.fromRGBO(61, 61, 61, 1.0),
        ),
      ),
    );
  }

  BoxDecoration _topBorder() {
    return const BoxDecoration(
      border: Border(
        top: BorderSide(
          width: 1.25,
          color: Color.fromRGBO(61, 61, 61, 1.0),
        ),
      ),
    );
  }
}

class FaceUpCard extends StatelessWidget {
  final String title;
  final LinearGradient linearGradient;
  final List<FaceUpCardSection> faceUpCardSections;

  const FaceUpCard({
    Key? key,
    required this.title,
    required this.linearGradient,
    this.faceUpCardSections = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: kfontSizeLarge * 3,
            width: double.infinity,
            decoration: BoxDecoration(gradient: linearGradient),
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: kfontSizeLarge,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            height: kfontSizeBase * 25,
            child: FittedBox(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: faceUpCardSections,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FaceDownCard extends StatelessWidget {
  final String? title;
  final String? description;
  final String? price;
  final String? buttonTitle;
  final VoidCallback? onPressed;

  const FaceDownCard({
    Key? key,
    this.title,
    this.description,
    this.price,
    this.buttonTitle,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Visibility(
              visible: title != null,
              child: Text(
                title ?? "[Title]",
                style: const TextStyle(
                  fontSize: kfontSizeBase,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: kfontSizeBase),
            Visibility(
              visible: description != null,
              child: Text(
                description ?? "[Description]",
                style: const TextStyle(
                  fontSize: kfontSizeLarge,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: kfontSizeBase * 2),
            Visibility(
              visible: price != null,
              child: Text(
                price ?? "\$Price",
                style: const TextStyle(
                  fontSize: kfontSizeXLarge,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: kfontSizeBase * 4),
        TextButton(
          style: TextButton.styleFrom(
            primary: Colors.black,
            textStyle: const TextStyle(fontSize: kfontSizeBase),
          ),
          onPressed: onPressed,
          child: Text(buttonTitle ?? "[Button Title]"),
        ),
      ],
    );
  }
}

/// This animation is rotating the [UpFace] around the Y-Axis while also
/// translating the Up Card out of the way must slide out of the way of the
/// [DownFace].
class FlippingCard extends StatefulWidget {
  /// Contents of the [UpFace]. Bounded by the [width] and [height].
  final Widget? upFaceContents;

  /// Contents of the [DownFace]. Bounded by the [width] and [height].
  final Widget? downFaceContents;

  /// Width of the [FlippingCard], constrains both the [UpFace] and [DownFace].
  final double width;

  /// Height of the [FlippingCard], constrains both the [UpFace] and [DownFace].
  final double height;

  /// The height at which you perceive the card flipping.
  ///
  /// A value > .83, looks upwards while a value < .83 looks downwards. A value
  /// of .83 is a nice middle sweet spot. Defaults to .83.
  final double yPerspective;

  /// Function triggered flipped to the [UpFace]
  final VoidCallback? onFlipToUpFace;

  /// Function triggered flipped to the [DownFace]
  final VoidCallback? onFlipToDownFace;

  /// Flips based on mouse hover
  final bool mouseHoverEnabled;

  /// Allows user to manually flip
  final bool dragEnabled;

  /// Allows user to flip the card by tapping on it
  final bool tapEnabled;

  const FlippingCard(
      {Key? key,
      required this.width,
      required this.height,
      this.upFaceContents,
      this.downFaceContents,
      this.onFlipToUpFace,
      this.onFlipToDownFace,
      this.dragEnabled = false,
      this.tapEnabled = false,
      this.mouseHoverEnabled = false,
      this.yPerspective = .83})
      : assert(yPerspective >= 0),
        assert(yPerspective <= 1),
        assert(
            (mouseHoverEnabled == true && dragEnabled == false) ||
                mouseHoverEnabled == false && (dragEnabled || !dragEnabled),
            "Mouse Hover and Enable Drag both cannot be true!"),
        assert(
            (mouseHoverEnabled == true && tapEnabled == false) ||
                mouseHoverEnabled == false && (tapEnabled || !tapEnabled),
            "Mouse Hover and Enable Tap both cannot be true!"),
        super(key: key);

  @override
  State<FlippingCard> createState() => _FlippingCardState();
}

class _FlippingCardState extends State<FlippingCard>
    with SingleTickerProviderStateMixin<FlippingCard> {
  late final AnimationController _ac;

  @override
  void initState() {
    super.initState();
    _ac = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 300),
    );
  }

  // Automatically runs the flipping animation, useful for onTap()
  void toggle() {
    _ac.isDismissed ? _ac.forward() : _ac.reverse();

    if (_ac.isDismissed && widget.onFlipToDownFace != null) {
      widget.onFlipToDownFace!();
    } else if (!_ac.isDismissed && widget.onFlipToUpFace != null) {
      widget.onFlipToUpFace!();
    }
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (!widget.dragEnabled) {
      return;
    }
    // Allows user to control the entire flip animation via dragging.
    // Flip distance is proportional to the users current drag.
    double delta = details.primaryDelta! / widget.width;
    _ac.value += delta;
  }

  void _onDragEnd(DragEndDetails details) {
    if (!widget.dragEnabled) {
      return;
    }

    if (_ac.isDismissed || _ac.isCompleted) return;

    if (details.velocity.pixelsPerSecond.dx.abs() >= 250.0) {
      final _width = MediaQuery.of(context).size.width;
      double v = details.velocity.pixelsPerSecond.dx / _width;
      // Card flip speed set by swipe speed, ceiled at 365 pixels/second.
      _ac.fling(velocity: v);
    } else {
      _ac.value < _ac.upperBound / 2 ? _ac.reverse() : _ac.forward();
    }
  }

  void _onEnter(PointerEvent details) {
    if (!widget.mouseHoverEnabled) return;
    _ac.forward();
  }

  void _onExit(PointerEvent details) {
    if (!widget.mouseHoverEnabled) return;
    _ac.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ac,
      builder: (context, _) {
        // Up Face should always start halfway rotated.
        bool upFaceIsVisible = true;
        double upFaceRotation = -3.14 * _ac.value;
        if (_ac.value >= _ac.upperBound / 2) {
          // Up Face is halfway rotated, now finish Down Face rotation.
          upFaceRotation = -3.14 / 2 * _ac.upperBound;

          // Hide Up Face so the Container's edge doesn't show when halfway
          // rotated.
          upFaceIsVisible = false;
        }

        // Down Face should always start halfway rotated.
        bool downFaceIsVisible = false;
        double downFaceRotation = 3.14 / 2 * _ac.upperBound;
        if (_ac.value >= _ac.upperBound / 2) {
          // Up Face is halfway rotated, now finish Down Face rotation.
          downFaceRotation = (3.14 * _ac.upperBound) - (3.14 * _ac.value);

          // Down face was hidden by stack anyway, so not necessary.
          downFaceIsVisible = true;
        }
        return Stack(
          children: [
            Transform(
              origin: Offset(widget.width / 2, 125),
              transform: Matrix4.identity()
                ..setEntry(3, 2, .00075)
                ..rotateY(downFaceRotation),
              alignment: Alignment.centerLeft,
              child: Visibility(
                visible: downFaceIsVisible,
                child: Container(
                  height: widget.height,
                  width: widget.width,
                  decoration: _boxDecoration(),
                  child: widget.downFaceContents ?? const SizedBox(),
                ),
              ),
            ),
            Transform(
              origin: Offset(widget.width / 2, 125),
              transform: Matrix4.identity()
                ..setEntry(3, 2, .00075)
                ..rotateY(upFaceRotation),
              alignment: Alignment.centerLeft,
              child: Visibility(
                visible: upFaceIsVisible,
                child: Container(
                    height: widget.height,
                    width: widget.width,
                    decoration: _boxDecoration(),
                    child: widget.upFaceContents ?? const SizedBox()),
              ),
            ),
            Visibility(
              visible: widget.tapEnabled,
              child: GestureDetector(
                onTap: () {
                  toggle();
                },
                onHorizontalDragUpdate: _onDragUpdate,
                onHorizontalDragEnd: _onDragEnd,
                child: Container(
                  color: Colors.transparent,
                  height: widget.height,
                  width: widget.width,
                  child: const SizedBox(),
                ),
              ),
            ),
            Visibility(
              visible: widget.mouseHoverEnabled,
              child: MouseRegion(
                opaque: false,
                onEnter: _onEnter,
                onExit: _onExit,
                child: IgnorePointer(
                  ignoring: true,
                  child: Container(
                    color: Colors.transparent,
                    height: widget.height,
                    width: widget.width,
                    child: const SizedBox(),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2.5,
          blurRadius: 7,
          offset: const Offset(0, 3), // changes position of shadow
        ),
      ],
    );
  }
}
