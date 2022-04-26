import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart' hide Image;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuhm_app/logic/logic.dart';

import '_menu_painter.dart';
import '_ported_interactive_viewer.dart';
export '_menu_painter.dart';

/// [ImagePainter] widget.
@immutable
class ImagePainter extends StatefulWidget {
  const ImagePainter._(
      {Key? key,
      this.assetPath,
      this.networkUrl,
      this.byteArray,
      this.file,
      this.height,
      this.width,
      this.placeHolder,
      this.isScalable,
      this.brushIcon,
      this.clearAllIcon,
      this.colorIcon,
      this.undoIcon,
      this.isSignature = false,
      this.controlsAtTop = true,
      this.signatureBackgroundColor,
      this.colors,
      this.initialPaintMode,
      this.initialStrokeWidth,
      this.initialColor,
      this.onColorChanged,
      this.onStrokeWidthChanged,
      this.onPaintModeChanged})
      : super(key: key);

  /// Constructor for loading image from network url.
  factory ImagePainter.network(
    String url, {
    required Key key,
    double? height,
    double? width,
    Widget? placeholderWidget,
    bool? scalable,
    List<Color>? colors,
    Widget? brushIcon,
    Widget? undoIcon,
    Widget? clearAllIcon,
    Widget? colorIcon,
    PaintMode? initialPaintMode,
    double? initialStrokeWidth,
    Color? initialColor,
    ValueChanged<PaintMode>? onPaintModeChanged,
    ValueChanged<Color>? onColorChanged,
    ValueChanged<double>? onStrokeWidthChanged,
  }) {
    return ImagePainter._(
      key: key,
      networkUrl: url,
      height: height,
      width: width,
      placeHolder: placeholderWidget,
      isScalable: scalable,
      colors: colors,
      brushIcon: brushIcon,
      undoIcon: undoIcon,
      colorIcon: colorIcon,
      clearAllIcon: clearAllIcon,
      initialPaintMode: initialPaintMode,
      initialColor: initialColor,
      initialStrokeWidth: initialStrokeWidth,
      onPaintModeChanged: onPaintModeChanged,
      onColorChanged: onColorChanged,
      onStrokeWidthChanged: onStrokeWidthChanged,
    );
  }

  ///Constructor for loading image from assetPath.
  factory ImagePainter.asset(
    String path, {
    required Key key,
    double? height,
    double? width,
    bool? scalable,
    Widget? placeholderWidget,
    List<Color>? colors,
    Widget? brushIcon,
    Widget? undoIcon,
    Widget? clearAllIcon,
    Widget? colorIcon,
    PaintMode? initialPaintMode,
    double? initialStrokeWidth,
    Color? initialColor,
    ValueChanged<PaintMode>? onPaintModeChanged,
    ValueChanged<Color>? onColorChanged,
    ValueChanged<double>? onStrokeWidthChanged,
  }) {
    return ImagePainter._(
      key: key,
      assetPath: path,
      height: height,
      width: width,
      isScalable: scalable ?? false,
      placeHolder: placeholderWidget,
      colors: colors,
      brushIcon: brushIcon,
      undoIcon: undoIcon,
      colorIcon: colorIcon,
      clearAllIcon: clearAllIcon,
      initialPaintMode: initialPaintMode,
      initialColor: initialColor,
      initialStrokeWidth: initialStrokeWidth,
      onPaintModeChanged: onPaintModeChanged,
      onColorChanged: onColorChanged,
      onStrokeWidthChanged: onStrokeWidthChanged,
    );
  }

  /// Constructor for loading image from [File].
  factory ImagePainter.file(
    File file, {
    required Key key,
    double? height,
    double? width,
    bool? scalable,
    Widget? placeholderWidget,
    List<Color>? colors,
    Widget? brushIcon,
    Widget? undoIcon,
    Widget? clearAllIcon,
    Widget? colorIcon,
    PaintMode? initialPaintMode,
    double? initialStrokeWidth,
    Color? initialColor,
    ValueChanged<PaintMode>? onPaintModeChanged,
    ValueChanged<Color>? onColorChanged,
    ValueChanged<double>? onStrokeWidthChanged,
  }) {
    return ImagePainter._(
      key: key,
      file: file,
      height: height,
      width: width,
      placeHolder: placeholderWidget,
      colors: colors,
      isScalable: scalable ?? false,
      brushIcon: brushIcon,
      undoIcon: undoIcon,
      colorIcon: colorIcon,
      clearAllIcon: clearAllIcon,
      initialPaintMode: initialPaintMode,
      initialColor: initialColor,
      initialStrokeWidth: initialStrokeWidth,
      onPaintModeChanged: onPaintModeChanged,
      onColorChanged: onColorChanged,
      onStrokeWidthChanged: onStrokeWidthChanged,
    );
  }

  /// Constructor for loading image from memory.
  factory ImagePainter.memory(
    Uint8List byteArray, {
    required Key key,
    double? height,
    double? width,
    bool? scalable,
    Widget? placeholderWidget,
    List<Color>? colors,
    Widget? brushIcon,
    Widget? undoIcon,
    Widget? clearAllIcon,
    Widget? colorIcon,
    PaintMode? initialPaintMode,
    double? initialStrokeWidth,
    Color? initialColor,
    ValueChanged<PaintMode>? onPaintModeChanged,
    ValueChanged<Color>? onColorChanged,
    ValueChanged<double>? onStrokeWidthChanged,
  }) {
    return ImagePainter._(
      key: key,
      byteArray: byteArray,
      height: height,
      width: width,
      placeHolder: placeholderWidget,
      isScalable: scalable ?? false,
      colors: colors,
      brushIcon: brushIcon,
      undoIcon: undoIcon,
      colorIcon: colorIcon,
      clearAllIcon: clearAllIcon,
      initialPaintMode: initialPaintMode,
      initialColor: initialColor,
      initialStrokeWidth: initialStrokeWidth,
      onPaintModeChanged: onPaintModeChanged,
      onColorChanged: onColorChanged,
      onStrokeWidthChanged: onStrokeWidthChanged,
    );
  }

  /// Constructor for signature painting.
  factory ImagePainter.signature({
    required Key key,
    Color? signatureBgColor,
    double? height,
    double? width,
    List<Color>? colors,
    Widget? brushIcon,
    Widget? undoIcon,
    Widget? clearAllIcon,
    Widget? colorIcon,
    ValueChanged<PaintMode>? onPaintModeChanged,
    ValueChanged<Color>? onColorChanged,
    ValueChanged<double>? onStrokeWidthChanged,
  }) {
    return ImagePainter._(
      key: key,
      height: height,
      width: width,
      isSignature: true,
      isScalable: false,
      colors: colors,
      signatureBackgroundColor: signatureBgColor ?? Colors.white,
      brushIcon: brushIcon,
      undoIcon: undoIcon,
      colorIcon: colorIcon,
      clearAllIcon: clearAllIcon,
      onPaintModeChanged: onPaintModeChanged,
      onColorChanged: onColorChanged,
      onStrokeWidthChanged: onStrokeWidthChanged,
    );
  }

  /// Only accessible through [ImagePainter.network] constructor.
  final String? networkUrl;

  /// Only accessible through [ImagePainter.memory] constructor.
  final Uint8List? byteArray;

  /// Only accessible through [ImagePainter.file] constructor.
  final File? file;

  /// Only accessible through [ImagePainter.asset] constructor.
  final String? assetPath;

  /// Height of the Widget. Image is subjected to fit within the given height.
  final double? height;

  /// Width of the widget. Image is subjected to fit within the given width.
  final double? width;

  /// Widget to be shown during the conversion of provided image to [ui.Image].
  final Widget? placeHolder;

  /// Defines whether the widget should be scaled or not. Defaults to [false].
  final bool? isScalable;

  /// Flag to determine signature or image;
  final bool isSignature;

  /// Signature mode background color
  final Color? signatureBackgroundColor;

  /// List of colors for color selection
  /// If not provided, default colors are used.
  final List<Color>? colors;

  /// Icon Widget of strokeWidth.
  final Widget? brushIcon;

  /// Widget of Color Icon in control bar.
  final Widget? colorIcon;

  /// Widget for Undo last action on control bar.
  final Widget? undoIcon;

  /// Widget for clearing all actions on control bar.
  final Widget? clearAllIcon;

  /// Define where the controls is located.
  /// `true` represents top.
  final bool controlsAtTop;

  /// Initial PaintMode.
  final PaintMode? initialPaintMode;

  //the initial stroke width
  final double? initialStrokeWidth;

  //the initial color
  final Color? initialColor;

  final ValueChanged<Color>? onColorChanged;

  final ValueChanged<double>? onStrokeWidthChanged;

  final ValueChanged<PaintMode>? onPaintModeChanged;

  @override
  ImagePainterState createState() => ImagePainterState();
} // class ImagePainter extends StatefulWidget

///
class ImagePainterState extends State<ImagePainter> {
  final _repaintKey = GlobalKey();
  ui.Image? _image;
  bool _inDrag = false;
  final _paintHistory = <PaintInfo>[];
  final _points = <Offset?>[];
  late final ValueNotifier<Controller> _controller;
  late final ValueNotifier<bool> _isLoaded;
  late final TextEditingController _textController;
  Offset? _start, _end;
  int _strokeMultiplier = 1;

  @override
  void initState() {
    super.initState();
    _isLoaded = ValueNotifier<bool>(false);
    _resolveAndConvertImage();
    if (widget.isSignature) {
      _controller = ValueNotifier(
          const Controller(mode: PaintMode.freeStyle, color: Colors.black));
    } else {
      _controller = ValueNotifier(const Controller().copyWith(
          mode: widget.initialPaintMode,
          strokeWidth: widget.initialStrokeWidth,
          color: widget.initialColor));
    }
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _isLoaded.dispose();
    _textController.dispose();
    super.dispose();
  }

  Paint get _painter => Paint()
    ..color = _controller.value.color
    ..strokeWidth = _controller.value.strokeWidth * _strokeMultiplier
    ..style = _controller.value.paintStyle;

  /// Converts the incoming image type from constructor to [ui.Image]
  Future<void> _resolveAndConvertImage() async {
    if (widget.networkUrl != null) {
      _image = await _loadNetworkImage(widget.networkUrl!);
      if (_image == null) {
        throw ("${widget.networkUrl} couldn't be resolved.");
      } else {
        _setStrokeMultiplier();
      }
    } else if (widget.assetPath != null) {
      final img = await rootBundle.load(widget.assetPath!);
      _image = await _convertImage(Uint8List.view(img.buffer));
      if (_image == null) {
        throw ("${widget.assetPath} couldn't be resolved.");
      } else {
        _setStrokeMultiplier();
      }
    } else if (widget.file != null) {
      final img = await widget.file!.readAsBytes();
      _image = await _convertImage(img);
      if (_image == null) {
        throw ("Image couldn't be resolved from provided file.");
      } else {
        _setStrokeMultiplier();
      }
    } else if (widget.byteArray != null) {
      _image = await _convertImage(widget.byteArray!);
      if (_image == null) {
        throw ("Image couldn't be resolved from provided byteArray.");
      } else {
        _setStrokeMultiplier();
      }
    } else {
      _isLoaded.value = true;
    }
  }

  /// Dynamically sets stroke multiplier on the basis of widget size.
  /// Implemented to avoid thin stroke on high res images.
  _setStrokeMultiplier() {
    if ((_image!.height + _image!.width) > 1000) {
      _strokeMultiplier = (_image!.height + _image!.width) ~/ 1000;
    }
  }

  /// Completer function to convert asset or file image to [ui.Image] before drawing on custompainter.
  Future<ui.Image> _convertImage(Uint8List img) async {
    final completer = Completer<ui.Image>();
    ui.decodeImageFromList(img, (image) {
      _isLoaded.value = true;
      return completer.complete(image);
    });
    return completer.future;
  }

  /// Completer function to convert network image to [ui.Image] before drawing on custompainter.
  Future<ui.Image> _loadNetworkImage(String path) async {
    final completer = Completer<ImageInfo>();
    var img = NetworkImage(path);
    img.resolve(const ImageConfiguration()).addListener(
        ImageStreamListener((info, _) => completer.complete(info)));
    final imageInfo = await completer.future;
    _isLoaded.value = true;
    return imageInfo.image;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ValueListenableBuilder<bool>(
        valueListenable: _isLoaded,
        builder: (_, loaded, __) {
          if (loaded) {
            return _paintImage();
          } else {
            return SizedBox(
              height: widget.height ?? double.maxFinite,
              width: widget.width ?? double.maxFinite,
              child: Center(
                child: widget.placeHolder ?? const CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }

  /// paints image on given constrains for drawing if image is not null.
  Widget _paintImage() {
    final ScrollController _scBehind = ScrollController();
    final ScrollController _scCanvas = ScrollController();
    return Stack(
      children: [
        Container(
          color: Colors.black,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              _buildControls(),
              NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification info) {
                  // Convert Behind canvas scroll to percent
                  final relativeOffset =
                      (_scBehind.offset / _scBehind.position.maxScrollExtent);

                  // Ceiling
                  if (relativeOffset * _scCanvas.position.maxScrollExtent >=
                      _scCanvas.position.maxScrollExtent) {
                    _scCanvas.jumpTo(_scCanvas.position.maxScrollExtent);
                  }

                  // Floor
                  if (relativeOffset * _scCanvas.position.maxScrollExtent <=
                      _scCanvas.position.minScrollExtent) {
                    _scCanvas.jumpTo(_scCanvas.position.minScrollExtent);
                  }

                  _scCanvas.jumpTo(
                      relativeOffset * _scCanvas.position.maxScrollExtent);
                  return false;
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .8935,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      SingleChildScrollView(
                        controller: _scBehind,
                        child: Container(
                          color: Colors.white,
                          width: MediaQuery.of(context).size.width,
                          height: _image!.height.toDouble(),
                          child: const SizedBox(),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * .78,
                        height: MediaQuery.of(context).size.height * .812,
                        decoration: const BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              color: Colors.grey,
                              width: 3,
                            ),
                            right: BorderSide(
                              color: Colors.grey,
                              width: 3,
                            ),
                          ),
                        ),
                        child: SingleChildScrollView(
                          controller: _scCanvas,
                          physics: const NeverScrollableScrollPhysics(),
                          child: GestureDetector(
                            onTap: () => FocusScope.of(context).unfocus(),
                            child: Column(
                              children: [
                                FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: ClipRect(
                                    child: ValueListenableBuilder<Controller>(
                                      valueListenable: _controller,
                                      builder: (_, controller, __) {
                                        return ImagePainterTransformer(
                                          maxScale: 1,
                                          minScale: 1,
                                          panEnabled:
                                              controller.mode == PaintMode.none,
                                          scaleEnabled: false,
                                          onInteractionUpdate: (details) =>
                                              _scaleUpdateGesture(
                                                  details, controller),
                                          onInteractionEnd: (details) =>
                                              _scaleEndGesture(
                                                  details, controller),
                                          child: CustomPaint(
                                            size: Size(_image!.width.toDouble(),
                                                _image!.height.toDouble()),
                                            willChange: true,
                                            isComplex: true,
                                            painter: MenuPainter(
                                              image: _image,
                                              points: _points,
                                              paintHistory: _paintHistory,
                                              isDragging: _inDrag,
                                              update: UpdatePoints(
                                                  start: _start,
                                                  end: _end,
                                                  painter: _painter,
                                                  mode: controller.mode),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    height:
                                        MediaQuery.of(context).padding.bottom)
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Column(
                      //   children: [
                      //     const Expanded(child: SizedBox()),
                      //     _submitControls(),
                      //   ],
                      // )
                    ],
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom)
            ],
          ),
        ),
        Column(
          children: [
            const Expanded(child: SizedBox()),
            _submitControls(),
            SizedBox(height: MediaQuery.of(context).padding.bottom)
          ],
        )
      ],
    );
  }

  /// Fires while user is interacting with the screen to record painting.
  void _scaleUpdateGesture(ScaleUpdateDetails onUpdate, Controller ctrl) {
    setState(
      () {
        _inDrag = true;
        _start ??= onUpdate.focalPoint;
        _end = onUpdate.focalPoint;
        if (ctrl.mode == PaintMode.freeStyle) _points.add(_end);
      },
    );
  }

  /// Fires when user stops interacting with the screen.
  void _scaleEndGesture(ScaleEndDetails onEnd, Controller controller) {
    setState(() {
      _inDrag = false;
      if (_start != null &&
          _end != null &&
          (controller.mode == PaintMode.freeStyle)) {
        _points.add(null);
        _addFreeStylePoints();
        _points.clear();
      }
      _start = null;
      _end = null;
    });
  }

  void _addFreeStylePoints() => _paintHistory.add(
        PaintInfo(
          offset: <Offset?>[..._points],
          painter: _painter,
          mode: PaintMode.freeStyle,
        ),
      );

  /// Provides [ui.Image] of the recorded canvas to perform action.
  Future<ui.Image> _renderImage() async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final painter = MenuPainter(image: _image, paintHistory: _paintHistory);
    final size = Size(_image!.width.toDouble(), _image!.height.toDouble());
    painter.paint(canvas, size);
    return recorder
        .endRecording()
        .toImage(size.width.floor(), size.height.floor());
  }

  /// Generates [Uint8List] of the [ui.Image] generated by the [renderImage()] method.
  /// Can be converted to image file by writing as bytes.
  Future<Uint8List?> exportImage() async {
    late ui.Image _convertedImage;
    if (widget.isSignature) {
      final _boundary = _repaintKey.currentContext!.findRenderObject()
          as RenderRepaintBoundary;
      _convertedImage = await _boundary.toImage(pixelRatio: 3);
    } else if (widget.byteArray != null && _paintHistory.isEmpty) {
      return widget.byteArray;
    } else {
      _convertedImage = await _renderImage();
    }
    final byteData =
        await _convertedImage.toByteData(format: ui.ImageByteFormat.png);
    return byteData?.buffer.asUint8List();
  }

  Widget _buildControls() {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * .07,
      padding: const EdgeInsets.all(4),
      color: Colors.grey[200],
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          IconButton(
              tooltip: "Back Button",
              icon: widget.undoIcon ??
                  Icon(Icons.chevron_left, color: Colors.grey[700]),
              onPressed: () {
                FocusScope.of(context).unfocus();
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                BlocProvider.of<AppPageViewCubit>(context)
                    .jumpToRestaurantPage();
              }),
          Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Container(
                  height: double.infinity,
                  // Transparent color in order for container to be hitable.
                  color: Colors.transparent,
                  child: const SizedBox(),
                ),
              )),
          IconButton(
              tooltip: "Undo",
              icon:
                  widget.undoIcon ?? Icon(Icons.reply, color: Colors.grey[700]),
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                if (_paintHistory.isNotEmpty) {
                  setState(_paintHistory.removeLast);
                }
              }),
          IconButton(
            tooltip: "Clear all progress",
            icon: widget.clearAllIcon ??
                Icon(Icons.clear, color: Colors.grey[700]),
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              setState(_paintHistory.clear);
            },
          ),
        ],
      ),
    );
  }

  Widget _submitControls() {
    return Container(
      padding: const EdgeInsets.all(4),
      color: Colors.grey[200],
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: TextField(
                textInputAction: TextInputAction.done,
                textCapitalization: TextCapitalization.sentences,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 3,
                decoration:
                    const InputDecoration(hintText: "Send order with notes..."),
                onSubmitted: (value) => FocusScope.of(context).unfocus(),
              ),
            ),
          ),

          /// Submit Button
          IconButton(
            tooltip: "Send Order",
            icon: const Icon(Icons.send, color: Colors.deepOrangeAccent),
            onPressed: () async {
              FocusScope.of(context).unfocus();

              // User submitted an empty menu.
              if (_paintHistory.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Please choose something, before sending an order.",
                      style: TextStyle(color: Colors.redAccent),
                    ),
                  ),
                );
                return;
              }

              // Try to download modified menu, this can fail.
              Uint8List? newOrderImage = await exportImage();
              if (newOrderImage == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Order send failed: Modified menu image download failed!",
                      style: TextStyle(color: Colors.redAccent),
                    ),
                  ),
                );
              }

              BlocProvider.of<OrderBloc>(context).add(
                SubmitOrder(
                  Order(
                      id: UniqueKey().toString(),
                      fullName: "Alex Badia",
                      image: newOrderImage),
                  scaffoldMessengerState: ScaffoldMessenger.of(context),
                  appPageViewCubit: BlocProvider.of<AppPageViewCubit>(context),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

/// Gives access to manipulate the essential presentation.components like [strokeWidth], [Color] and [PaintMode].
@immutable
class Controller {
  /// Tracks [strokeWidth] of the [Paint] method.
  final double strokeWidth;

  /// Tracks [Color] of the [Paint] method.
  final Color color;

  /// Tracks [PaintingStyle] of the [Paint] method.
  final PaintingStyle paintStyle;

  /// Tracks [PaintMode] of the current [Paint] method.
  final PaintMode mode;

  /// Any text.
  final String text;

  /// Constructor of the [Controller] class.
  const Controller(
      {this.strokeWidth = 4.0,
      this.color = Colors.red,
      this.mode = PaintMode.freeStyle,
      this.paintStyle = PaintingStyle.stroke,
      this.text = ""});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Controller &&
        o.strokeWidth == strokeWidth &&
        o.color == color &&
        o.paintStyle == paintStyle &&
        o.mode == mode &&
        o.text == text;
  }

  @override
  int get hashCode {
    return strokeWidth.hashCode ^
        color.hashCode ^
        paintStyle.hashCode ^
        mode.hashCode ^
        text.hashCode;
  }

  /// copyWith Method to access immutable controller.
  Controller copyWith(
      {double? strokeWidth,
      Color? color,
      PaintMode? mode,
      PaintingStyle? paintingStyle,
      String? text}) {
    return Controller(
        strokeWidth: strokeWidth ?? this.strokeWidth,
        color: color ?? this.color,
        mode: mode ?? this.mode,
        paintStyle: paintingStyle ?? paintStyle,
        text: text ?? this.text);
  }
}
