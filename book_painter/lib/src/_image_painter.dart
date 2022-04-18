import 'dart:ui';

import 'package:flutter/material.dart' hide Image;

/// Handles all the painting ongoing on the canvas.
class DrawImage extends CustomPainter {
  /// Converted image from [ImagePainter] constructor.
  final Image? image;

  /// Keeps track of all the units of [PaintHistory].
  final List<PaintInfo>? paintHistory;

  /// Keeps track of points on currently drawing state.
  final UpdatePoints? update;

  /// Keeps track of freestyle points on currently drawing state.
  final List<Offset?>? points;

  /// Keeps track whether the paint action is running or not.
  final bool isDragging;

  /// Flag for triggering signature mode.
  final bool isSignature;

  /// The background for signature painting.
  final Color? backgroundColor;

  /// Constructor for the canvas
  DrawImage(
      {this.image,
      this.update,
      this.points,
      this.isDragging = false,
      this.isSignature = false,
      this.backgroundColor,
      this.paintHistory});

  @override
  void paint(Canvas canvas, Size size) {
    if (isSignature) {
      /// Paints background for signature.
      canvas.drawRect(
          Rect.fromPoints(const Offset(0, 0), Offset(size.width, size.height)),
          Paint()
            ..style = PaintingStyle.fill
            ..color = backgroundColor!);
    } else {
      /// Paints [ui.Image] on the canvas for reference to draw over it.
      paintImage(
        canvas: canvas,
        image: image!,
        filterQuality: FilterQuality.high,
        rect: Rect.fromPoints(
          const Offset(0, 0),
          Offset(size.width, size.height),
        ),
      );
    }

    /// Paints all the previous paintInfo history recorded on [PaintHistory]
    for (var item in paintHistory!) {
      final _offset = item.offset;
      final _painter = item.painter;
      switch (item.mode) {
        case PaintMode.freeStyle:
          for (var i = 0; i < _offset!.length - 1; i++) {
            if (_offset[i] != null && _offset[i + 1] != null) {
              final _path = Path()
                ..moveTo(_offset[i]!.dx, _offset[i]!.dy)
                ..lineTo(_offset[i + 1]!.dx, _offset[i + 1]!.dy);
              canvas.drawPath(_path, _painter!..strokeCap = StrokeCap.round);
            } else if (_offset[i] != null && _offset[i + 1] == null) {
              canvas.drawPoints(PointMode.points, [_offset[i]!],
                  _painter!..strokeCap = StrokeCap.round);
            }
          }
          break;
        default:
      }
    }

    /// Draws ongoing action on the canvas while indrag.
    if (isDragging) {
      final _start = update!.start;
      final _end = update!.end;
      final _painter = update!.painter;
      switch (update!.mode) {
        case PaintMode.freeStyle:
          for (var i = 0; i < points!.length - 1; i++) {
            if (points![i] != null && points![i + 1] != null) {
              canvas.drawLine(
                  Offset(points![i]!.dx, points![i]!.dy),
                  Offset(points![i + 1]!.dx, points![i + 1]!.dy),
                  _painter!..strokeCap = StrokeCap.round);
            } else if (points![i] != null && points![i + 1] == null) {
              canvas.drawPoints(PointMode.points,
                  [Offset(points![i]!.dx, points![i]!.dy)], _painter!);
            }
          }
          break;
        default:
      }
    }
  }

  @override
  bool shouldRepaint(DrawImage oldInfo) {
    return (oldInfo.update != update ||
        oldInfo.paintHistory!.length == paintHistory!.length);
  }
}

/// All the paint method available for use.

enum PaintMode {
  /// Prefer using [None] while doing scaling operations.
  none,

  /// Allows for drawing freehand shapes or text.
  freeStyle,
}

/// [PaintInfo] keeps track of a single unit of shape, whichever selected.
class PaintInfo {
  /// Mode of the paint method.
  PaintMode? mode;

  /// Used to save specific paint utils used for the specific shape.
  Paint? painter;

  /// Used to save offsets.
  /// Two point in case of other shapes and list of points for [FreeStyle].
  List<Offset?>? offset;

  /// Used to save text in case of text type.
  String? text;

  /// In case of string, it is used to save string value entered.
  PaintInfo({this.offset, this.painter, this.text, this.mode});
}

@immutable

/// Records realtime updates of ongoing [PaintInfo] when inDrag.
class UpdatePoints {
  /// Records the first tap offset,
  final Offset? start;

  /// Records all the offset after first one.
  final Offset? end;

  /// Records [Paint] method of the ongoing painting.
  final Paint? painter;

  /// Records [PaintMode] of the ongoing painting.
  final PaintMode? mode;

  ///Constructor for ongoing painthistory.
  UpdatePoints({this.start, this.end, this.painter, this.mode});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is UpdatePoints &&
        o.start == start &&
        o.end == end &&
        o.painter == painter &&
        o.mode == mode;
  }

  @override
  int get hashCode {
    return start.hashCode ^ end.hashCode ^ painter.hashCode ^ mode.hashCode;
  }
}
