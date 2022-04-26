import 'package:flutter/material.dart';

import '../constants.dart';

class Subscriptions extends StatelessWidget {
  final double height;
  const Subscriptions(this.height, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    return SliverToBoxAdapter(
      child: Container(
        height: height,
        width: double.infinity,
        color: kLandingPageColorSecondary,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                FlippingCard(
                  width: _width * .25,
                  height: height * .7,
                  mouseHoverEnabled: true,
                  upFaceContents: Container(
                    color: Colors.blueAccent,
                    child: const SizedBox(),
                  ),
                  downFaceContents: Container(
                    color: Colors.green,
                    child: const SizedBox(),
                  ),
                ),
                FlippingCard(
                  width: _width * .25,
                  height: height * .7,
                  mouseHoverEnabled: true,
                  upFaceContents: Container(
                    color: Colors.blueAccent,
                    child: const SizedBox(),
                  ),
                  downFaceContents: Container(
                    color: Colors.green,
                    child: const SizedBox(),
                  ),
                ),
                FlippingCard(
                  width: _width * .25,
                  height: height * .7,
                  mouseHoverEnabled: true,
                  upFaceContents: Container(
                    color: Colors.blueAccent,
                    child: const SizedBox(),
                  ),
                  downFaceContents: Container(
                    child: FaceDownCard(
                      title: "Pay As You Go",
                      description: "Starting At",
                      buttonTitle: "Sign Up",
                      price: "\$100/month",
                      onPressed: () {},
                    ),
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
                  fontSize: kfontSizeXBase,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: kfontSizeBase * 2),
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
        const SizedBox(height: kfontSizeBase * 2),
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

  const FlippingCard(
      {Key? key,
      required this.width,
      required this.height,
      this.upFaceContents,
      this.downFaceContents,
      this.onFlipToUpFace,
      this.onFlipToDownFace,
      this.dragEnabled = false,
      this.mouseHoverEnabled = false,
      this.yPerspective = .83})
      : assert(yPerspective >= 0),
        assert(yPerspective <= 1),
        // Drag enable and Mouse
        assert(
            mouseHoverEnabled == true && dragEnabled == false ||
                mouseHoverEnabled == false && (dragEnabled || !dragEnabled),
            "Drag Enabled and Mouse Hover cannot both be enabled!"),
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
    return GestureDetector(
      onTap: () {
        toggle();
      },
      onHorizontalDragUpdate: _onDragUpdate,
      onHorizontalDragEnd: _onDragEnd,
      child: AnimatedBuilder(
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
                  child: SizedBox(
                    height: widget.height,
                    width: widget.width,
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
                  child: SizedBox(
                    height: widget.height,
                    width: widget.width,
                    child: widget.upFaceContents ?? const SizedBox(),
                  ),
                ),
              ),
              Visibility(
                visible: widget.mouseHoverEnabled,
                child: MouseRegion(
                  onEnter: _onEnter,
                  onExit: _onExit,
                  child: Container(
                    color: Colors.transparent,
                    height: widget.height,
                    width: widget.width,
                    child: const SizedBox(),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
