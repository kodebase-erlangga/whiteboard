// import 'dart:async';
// import 'dart:io';
// import 'dart:ui' as ui;

// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// // import 'package:flutter/material.dart' hide Image;
// // import 'dart:ui' as ui show Image, Paint, Path, Canvas;
// import 'package:flutter/services.dart';

// import '_image_painter.dart';
// import '_signature_painter.dart';
// import 'controller.dart';
// import 'delegates/text_delegate.dart';
// import 'widgets/_color_widget.dart';
// import 'widgets/_mode_widget.dart';
// import 'widgets/_range_slider.dart';
// import 'widgets/_text_dialog.dart';

// import 'package:path_provider/path_provider.dart';
// import 'package:open_file/open_file.dart';
// import 'package:whiteboard/widget/alertHapus.dart';
// import 'package:whiteboard/widget/alertSimpan.dart';
// export '_image_painter.dart';
// import 'package:whiteboard/widget/toolbar.dart';
// import 'package:whiteboard/board.dart';
// import 'package:flutter/scheduler.dart';

// ///[ImagePainter] widget.
// @immutable
// class ImagePainter extends StatefulWidget {
//   const ImagePainter._({
//     Key? key,
//     required this.controller,
//     this.assetPath,
//     this.networkUrl,
//     this.byteArray,
//     this.file,
//     this.height,
//     this.width,
//     this.placeHolder,
//     this.isScalable,
//     this.brushIcon,
//     this.clearAllIcon,
//     this.colorIcon,
//     this.undoIcon,
//     this.isSignature = false,
//     this.controlsAtTop = true,
//     this.signatureBackgroundColor = Colors.white,
//     this.colors,
//     this.onColorChanged,
//     this.onStrokeWidthChanged,
//     this.onPaintModeChanged,
//     this.textDelegate,
//     this.showControls = true,
//     this.showToolbar = true,
//     this.controlsBackgroundColor,
//     this.optionSelectedColor,
//     this.optionUnselectedColor,
//     this.optionColor,
//     this.onPickImage,
//     this.onUndo,
//     this.onClear,
//   }) : super(key: key);

//   ///Constructor for loading image from network url.
//   factory ImagePainter.network(
//     String url, {
//     required ImagePainterController controller,
//     Key? key,
//     double? height,
//     double? width,
//     Widget? placeholderWidget,
//     bool? scalable,
//     List<Color>? colors,
//     Widget? brushIcon,
//     Widget? undoIcon,
//     Widget? clearAllIcon,
//     Widget? colorIcon,
//     ValueChanged<PaintMode>? onPaintModeChanged,
//     ValueChanged<Color>? onColorChanged,
//     ValueChanged<double>? onStrokeWidthChanged,
//     TextDelegate? textDelegate,
//     bool? controlsAtTop,
//     bool? showControls,
//     bool? showToolbar,
//     Color? controlsBackgroundColor,
//     Color? selectedColor,
//     Color? unselectedColor,
//     Color? optionColor,
//     VoidCallback? onPickImage,
//     VoidCallback? onUndo,
//     VoidCallback? onClear,
//   }) {
//     return ImagePainter._(
//       key: key,
//       controller: controller,
//       networkUrl: url,
//       height: height,
//       width: width,
//       placeHolder: placeholderWidget,
//       isScalable: scalable,
//       colors: colors,
//       brushIcon: brushIcon,
//       undoIcon: undoIcon,
//       colorIcon: colorIcon,
//       clearAllIcon: clearAllIcon,
//       onPaintModeChanged: onPaintModeChanged,
//       onColorChanged: onColorChanged,
//       onStrokeWidthChanged: onStrokeWidthChanged,
//       textDelegate: textDelegate,
//       controlsAtTop: controlsAtTop ?? true,
//       showControls: showControls ?? true,
//       showToolbar: showToolbar ?? true,
//       controlsBackgroundColor: controlsBackgroundColor,
//       optionSelectedColor: selectedColor,
//       optionUnselectedColor: unselectedColor,
//       optionColor: optionColor,
//       onPickImage: onPickImage,
//       onUndo: onUndo,
//       onClear: onClear,
//     );
//   }

//   ///Constructor for loading image from assetPath.
//   factory ImagePainter.asset(
//     String path, {
//     required ImagePainterController controller,
//     Key? key,
//     double? height,
//     double? width,
//     bool? scalable,
//     Widget? placeholderWidget,
//     List<Color>? colors,
//     Widget? brushIcon,
//     Widget? undoIcon,
//     Widget? clearAllIcon,
//     Widget? colorIcon,
//     ValueChanged<PaintMode>? onPaintModeChanged,
//     ValueChanged<Color>? onColorChanged,
//     ValueChanged<double>? onStrokeWidthChanged,
//     TextDelegate? textDelegate,
//     bool? controlsAtTop,
//     bool? showControls,
//     bool? showToolbar,
//     Color? controlsBackgroundColor,
//     Color? selectedColor,
//     Color? unselectedColor,
//     Color? optionColor,
//     VoidCallback? onPickImage,
//     VoidCallback? onUndo,
//     VoidCallback? onClear,
//   }) {
//     return ImagePainter._(
//       controller: controller,
//       key: key,
//       assetPath: path,
//       height: height,
//       width: width,
//       isScalable: scalable ?? false,
//       placeHolder: placeholderWidget,
//       colors: colors,
//       brushIcon: brushIcon,
//       undoIcon: undoIcon,
//       colorIcon: colorIcon,
//       clearAllIcon: clearAllIcon,
//       onPaintModeChanged: onPaintModeChanged,
//       onColorChanged: onColorChanged,
//       onStrokeWidthChanged: onStrokeWidthChanged,
//       textDelegate: textDelegate,
//       controlsAtTop: controlsAtTop ?? true,
//       showControls: showControls ?? true,
//       showToolbar: showToolbar ?? true,
//       controlsBackgroundColor: controlsBackgroundColor,
//       optionSelectedColor: selectedColor,
//       optionUnselectedColor: unselectedColor,
//       optionColor: optionColor,
//       onPickImage: onPickImage,
//       onUndo: onUndo,
//       onClear: onClear,
//     );
//   }

//   ///Constructor for loading image from [File].
//   factory ImagePainter.file(
//     File file, {
//     required ImagePainterController controller,
//     Key? key,
//     double? height,
//     double? width,
//     bool? scalable,
//     Widget? placeholderWidget,
//     List<Color>? colors,
//     Widget? brushIcon,
//     Widget? undoIcon,
//     Widget? clearAllIcon,
//     Widget? colorIcon,
//     ValueChanged<PaintMode>? onPaintModeChanged,
//     ValueChanged<Color>? onColorChanged,
//     ValueChanged<double>? onStrokeWidthChanged,
//     TextDelegate? textDelegate,
//     bool? controlsAtTop,
//     bool? showControls,
//     bool? showToolbar,
//     Color? controlsBackgroundColor,
//     Color? selectedColor,
//     Color? unselectedColor,
//     Color? optionColor,
//     VoidCallback? onPickImage,
//     VoidCallback? onUndo,
//     VoidCallback? onClear,
//   }) {
//     return ImagePainter._(
//       controller: controller,
//       key: key,
//       file: file,
//       height: height,
//       width: width,
//       placeHolder: placeholderWidget,
//       colors: colors,
//       isScalable: scalable ?? false,
//       brushIcon: brushIcon,
//       undoIcon: undoIcon,
//       colorIcon: colorIcon,
//       clearAllIcon: clearAllIcon,
//       onPaintModeChanged: onPaintModeChanged,
//       onColorChanged: onColorChanged,
//       onStrokeWidthChanged: onStrokeWidthChanged,
//       textDelegate: textDelegate,
//       controlsAtTop: controlsAtTop ?? true,
//       showControls: showControls ?? true,
//       showToolbar: showToolbar ?? true,
//       controlsBackgroundColor: controlsBackgroundColor,
//       optionSelectedColor: selectedColor,
//       optionUnselectedColor: unselectedColor,
//       optionColor: optionColor,
//       onPickImage: onPickImage,
//       onUndo: onUndo,
//       onClear: onClear,
//     );
//   }

//   ///Constructor for loading image from memory.
//   factory ImagePainter.memory(
//     Uint8List byteArray, {
//     required ImagePainterController controller,
//     Key? key,
//     double? height,
//     double? width,
//     bool? scalable,
//     Widget? placeholderWidget,
//     List<Color>? colors,
//     Widget? brushIcon,
//     Widget? undoIcon,
//     Widget? clearAllIcon,
//     Widget? colorIcon,
//     ValueChanged<PaintMode>? onPaintModeChanged,
//     ValueChanged<Color>? onColorChanged,
//     ValueChanged<double>? onStrokeWidthChanged,
//     TextDelegate? textDelegate,
//     bool? controlsAtTop,
//     bool? showControls,
//     bool? showToolbar,
//     Color? controlsBackgroundColor,
//     Color? selectedColor,
//     Color? unselectedColor,
//     Color? optionColor,
//     VoidCallback? onPickImage,
//     VoidCallback? onUndo,
//     VoidCallback? onClear,
//   }) {
//     return ImagePainter._(
//       controller: controller,
//       key: key,
//       byteArray: byteArray,
//       height: height,
//       width: width,
//       placeHolder: placeholderWidget,
//       isScalable: scalable ?? false,
//       colors: colors,
//       brushIcon: brushIcon,
//       undoIcon: undoIcon,
//       colorIcon: colorIcon,
//       clearAllIcon: clearAllIcon,
//       onPaintModeChanged: onPaintModeChanged,
//       onColorChanged: onColorChanged,
//       onStrokeWidthChanged: onStrokeWidthChanged,
//       textDelegate: textDelegate,
//       controlsAtTop: controlsAtTop ?? true,
//       showControls: showControls ?? true,
//       showToolbar: showToolbar ?? true,
//       controlsBackgroundColor: controlsBackgroundColor,
//       optionSelectedColor: selectedColor,
//       optionUnselectedColor: unselectedColor,
//       optionColor: optionColor,
//       onUndo: onUndo,
//       onClear: onClear,
//     );
//   }

//   ///Constructor for signature painting.
//   factory ImagePainter.signature({
//     required ImagePainterController controller,
//     required double height,
//     required double width,
//     Key? key,
//     Color? signatureBgColor,
//     List<Color>? colors,
//     Widget? brushIcon,
//     Widget? undoIcon,
//     Widget? clearAllIcon,
//     Widget? colorIcon,
//     ValueChanged<PaintMode>? onPaintModeChanged,
//     ValueChanged<Color>? onColorChanged,
//     ValueChanged<double>? onStrokeWidthChanged,
//     TextDelegate? textDelegate,
//     bool? controlsAtTop,
//     bool? showControls,
//     bool? showToolbar,
//     Color? controlsBackgroundColor,
//     Color? selectedColor,
//     Color? unselectedColor,
//     Color? optionColor,
//     VoidCallback? onPickImage,
//     VoidCallback? onUndo,
//     VoidCallback? onClear,
//   }) {
//     return ImagePainter._(
//       controller: controller,
//       key: key,
//       height: height,
//       width: width,
//       isSignature: true,
//       isScalable: false,
//       colors: colors,
//       signatureBackgroundColor: signatureBgColor ?? Colors.white,
//       brushIcon: brushIcon,
//       undoIcon: undoIcon,
//       colorIcon: colorIcon,
//       clearAllIcon: clearAllIcon,
//       onPaintModeChanged: onPaintModeChanged,
//       onColorChanged: onColorChanged,
//       onStrokeWidthChanged: onStrokeWidthChanged,
//       textDelegate: textDelegate,
//       controlsAtTop: controlsAtTop ?? true,
//       showControls: showControls ?? true,
//       showToolbar: showToolbar ?? true,
//       controlsBackgroundColor: controlsBackgroundColor,
//       optionSelectedColor: selectedColor,
//       optionUnselectedColor: unselectedColor,
//       optionColor: optionColor,
//       onPickImage: onPickImage,
//       onUndo: onUndo,
//       onClear: onClear,
//     );
//   }

//   /// Class that holds the controller and it's methods.
//   final ImagePainterController controller;

//   final VoidCallback? onPickImage;

//   ///Only accessible through [ImagePainter.network] constructor.
//   final String? networkUrl;

//   ///Only accessible through [ImagePainter.memory] constructor.
//   final Uint8List? byteArray;

//   ///Only accessible through [ImagePainter.file] constructor.
//   final File? file;

//   ///Only accessible through [ImagePainter.asset] constructor.
//   final String? assetPath;

//   ///Height of the Widget. Image is subjected to fit within the given height.
//   final double? height;

//   ///Width of the widget. Image is subjected to fit within the given width.
//   final double? width;

//   ///Widget to be shown during the conversion of provided image to [ui.Image].
//   final Widget? placeHolder;

//   ///Defines whether the widget should be scaled or not. Defaults to [false].
//   final bool? isScalable;

//   ///Flag to determine signature or image;
//   final bool isSignature;

//   ///Signature mode background color
//   final Color signatureBackgroundColor;

//   ///List of colors for color selection
//   ///If not provided, default colors are used.
//   final List<Color>? colors;

//   ///Icon Widget of strokeWidth.
//   final Widget? brushIcon;

//   ///Widget of Color Icon in control bar.
//   final Widget? colorIcon;

//   ///Widget for Undo last action on control bar.
//   final Widget? undoIcon;

//   ///Widget for clearing all actions on control bar.
//   final Widget? clearAllIcon;

//   ///Define where the controls is located.
//   ///`true` represents top.
//   final bool controlsAtTop;

//   final ValueChanged<Color>? onColorChanged;

//   final ValueChanged<double>? onStrokeWidthChanged;

//   final ValueChanged<PaintMode>? onPaintModeChanged;

//   //the text delegate
//   final TextDelegate? textDelegate;

//   ///It will control displaying the Control Bar
//   final bool showControls;

//   final bool showToolbar;

//   final Color? controlsBackgroundColor;

//   final Color? optionSelectedColor;

//   final Color? optionUnselectedColor;

//   final Color? optionColor;

//   final VoidCallback? onUndo;

//   final VoidCallback? onClear;

//   @override
//   ImagePainterState createState() => ImagePainterState();
// }

// class ImagePainterState extends State<ImagePainter> {
//   File? _backgroundImageFile;
//   String? selectedImage;
//   // ImagePainterController? _controller;
//   List<ImageLayer> imageLayers = [];
//   final GlobalKey _painterKey = GlobalKey();
//   bool _showToolbar = true;
//   bool _showControls = true;
//   final _repaintKey = GlobalKey();
//   ui.Image? _image;
//   late final ImagePainterController _controller;
//   late final ValueNotifier<bool> _isLoaded;
//   late final TextEditingController _textController;
//   late final TransformationController _transformationController;

//   int _strokeMultiplier = 1;
//   late TextDelegate textDelegate;
//   @override
//   void initState() {
//     super.initState();
//     _isLoaded = ValueNotifier<bool>(false);
//     _controller = widget.controller;
//     if (widget.isSignature) {
//       _controller.update(
//         mode: PaintMode.freeStyle,
//         color: Colors.black,
//       );
//       _controller.setRect(Size(widget.width!, widget.height!));
//     }
//     _resolveAndConvertImage();
//     _textController = TextEditingController();
//     _transformationController = TransformationController();
//     textDelegate = widget.textDelegate ?? TextDelegate();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     _isLoaded.dispose();
//     _textController.dispose();
//     _transformationController.dispose();
//     super.dispose();
//   }

//   Widget _buildBackgroundPainter() {
//     if (selectedImage == null) {
//       return const Center(child: Text("Tidak ada gambar yang dipilih"));
//     }

//     if (_backgroundImageFile != null) {
//       return ImagePainter.file(
//         _backgroundImageFile!,
//         controller: _controller,
//         scalable: true,
//         textDelegate: TextDelegate(),
//         onPickImage: _pickImage,
//       );
//     }

//     if (selectedImage!.startsWith("assets/")) {
//       return ImagePainter.asset(
//         selectedImage!,
//         controller: _controller!,
//         scalable: true,
//         textDelegate: TextDelegate(),
//         onPickImage: _pickImage,
//       );
//     } else {
//       final file = File(selectedImage!);
//       if (!file.existsSync()) {
//         return const Center(child: Text("File gambar tidak ditemukan"));
//       }
//       return ImagePainter.file(
//         file,
//         controller: _controller!,
//         scalable: true,
//         textDelegate: TextDelegate(),
//         onPickImage: _pickImage,
//       );
//     }
//   }

//   Widget _buildImageLayer(ImageLayer layer) {
//     return Positioned(
//       left: layer.offset.dx,
//       top: layer.offset.dy,
//       child: GestureDetector(
//         onPanUpdate: (details) => _updateLayerPosition(layer, details.delta),
//         onScaleUpdate: (details) {
//           _scaleLayer(layer, details.scale);
//           _updateLayerPosition(layer, details.focalPointDelta);
//         },
//         child: Transform.scale(
//           scale: layer.scale,
//           child: Image.file(
//             layer.image,
//             width: 200,
//             height: 200,
//             fit: BoxFit.contain,
//           ),
//         ),
//       ),
//     );
//   }

//   void _updateLayerPosition(ImageLayer layer, Offset delta) {
//     setState(() {
//       layer.offset += delta;
//     });
//   }

//   void _scaleLayer(ImageLayer layer, double scale) {
//     setState(() {
//       layer.scale = scale.clamp(0.5, 5.0);
//     });
//   }

//   void _addImageLayer(File image) {
//     setState(() {
//       imageLayers.add(ImageLayer(
//         image: image,
//         offset: Offset.zero,
//         scale: 1.0,
//       ));
//     });
//   }

//   Future<void> _pickImage() async {
//     try {
//       // final pickedFile = await ImagePicker().pickImage(
//       //   source: ImageSource.gallery,
//       //   maxWidth: 1920,
//       //   maxHeight: 1080,
//       //   imageQuality: 85,
//       // );

//       if (pickedFile != null) {
//         final imageFile = File(pickedFile.path);
//         if (await imageFile.exists()) {
//           _addImageLayer(imageFile);
//         }
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Gagal memilih gambar: $e')),
//         );
//       }
//     }
//   }

//   bool get isEdited => _controller.paintHistory.isNotEmpty;

//   Size get imageSize =>
//       Size(_image?.width.toDouble() ?? 0, _image?.height.toDouble() ?? 0);

//   ///Converts the incoming image type from constructor to [ui.Image]
//   Future<void> _resolveAndConvertImage() async {
//     if (widget.networkUrl != null) {
//       _image = await _loadNetworkImage(widget.networkUrl!);
//       if (_image != null) {
//         _controller.setImage(_image!);
//         _setStrokeMultiplier();
//       } else {
//         throw ("${widget.networkUrl} couldn't be resolved.");
//       }
//     } else if (widget.assetPath != null) {
//       final img = await rootBundle.load(widget.assetPath!);
//       _image = await _convertImage(Uint8List.view(img.buffer));
//       if (_image != null) {
//         _controller.setImage(_image!);
//         _setStrokeMultiplier();
//       } else {
//         throw ("${widget.assetPath} couldn't be resolved.");
//       }
//     } else if (widget.file != null) {
//       final img = await widget.file!.readAsBytes();
//       _image = await _convertImage(img);
//       if (_image != null) {
//         _controller.setImage(_image!);
//         _setStrokeMultiplier();
//       } else {
//         throw ("Image couldn't be resolved from provided file.");
//       }
//     } else if (widget.byteArray != null) {
//       _image = await _convertImage(widget.byteArray!);
//       if (_image != null) {
//         _controller.setImage(_image!);
//         _setStrokeMultiplier();
//       } else {
//         throw ("Image couldn't be resolved from provided byteArray.");
//       }
//     } else {
//       _isLoaded.value = true;
//     }
//   }

//   ///Dynamically sets stroke multiplier on the basis of widget size.
//   ///Implemented to avoid thin stroke on high res images.
//   _setStrokeMultiplier() {
//     if ((_image!.height + _image!.width) > 1000) {
//       _strokeMultiplier = (_image!.height + _image!.width) ~/ 1000;
//     }
//     _controller.update(strokeMultiplier: _strokeMultiplier);
//   }

//   ///Completer function to convert asset or file image to [ui.Image] before drawing on custompainter.
//   Future<ui.Image> _convertImage(Uint8List img) async {
//     final completer = Completer<ui.Image>();
//     ui.decodeImageFromList(img, (image) {
//       _isLoaded.value = true;
//       return completer.complete(image);
//     });
//     return completer.future;
//   }

//   ///Completer function to convert network image to [ui.Image] before drawing on custompainter.
//   Future<ui.Image> _loadNetworkImage(String path) async {
//     final completer = Completer<ImageInfo>();
//     final img = NetworkImage(path);
//     img.resolve(const ImageConfiguration()).addListener(
//         ImageStreamListener((info, _) => completer.complete(info)));
//     final imageInfo = await completer.future;
//     _isLoaded.value = true;
//     return imageInfo.image;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder<bool>(
//       valueListenable: _isLoaded,
//       builder: (_, loaded, __) {
//         if (loaded) {
//           return widget.isSignature ? _paintSignature() : _paintImage();
//         } else {
//           return Container(
//             height: widget.height ?? double.maxFinite,
//             width: widget.width ?? double.maxFinite,
//             child: Center(
//               child: widget.placeHolder ?? const CircularProgressIndicator(),
//             ),
//           );
//         }
//       },
//     );
//   }

//   Widget _paintImage() {
//     return Stack(
//       children: [
//         Container(
//           height: widget.height ?? double.maxFinite,
//           width: widget.width ?? double.maxFinite,
//           child: Column(
//             children: [
//               if (widget.controlsAtTop)
//                 AnimatedOpacity(
//                   opacity: _showControls && _showToolbar ? 1.0 : 0.0,
//                   duration: Duration(milliseconds: 300),
//                   child: AnimatedSize(
//                     duration: Duration(milliseconds: 300),
//                     alignment: Alignment.topCenter,
//                     child: _showControls && _showToolbar
//                         ? Column(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               _buildControls(),
//                             ],
//                           )
//                         : SizedBox.shrink(),
//                   ),
//                 ),
//               Expanded(
//                 child: FittedBox(
//                   alignment: FractionalOffset.center,
//                   child: ClipRect(
//                     child: AnimatedBuilder(
//                       animation: _controller,
//                       builder: (context, child) {
//                         return InteractiveViewer(
//                           transformationController: _transformationController,
//                           maxScale: 2.4,
//                           minScale: 1,
//                           panEnabled: _controller.mode == PaintMode.none,
//                           scaleEnabled: widget.isScalable!,
//                           onInteractionUpdate: _scaleUpdateGesture,
//                           onInteractionEnd: _scaleEndGesture,
//                           // child: CustomPaint(
//                           //   size: imageSize,
//                           //   willChange: true,
//                           //   isComplex: true,
//                           //   painter: DrawImage(
//                           //     controller: _controller,
//                           //   ),
//                           child: RepaintBoundary(
//                             key: _painterKey,
//                             child: Stack(
//                               children: [
//                                 _buildBackgroundPainter(),
//                                 CustomPaint(
//                                   size: imageSize,
//                                   willChange: true,
//                                   isComplex: true,
//                                   painter: DrawImage(
//                                     controller: _controller,
//                                   ),
//                                 ),
//                                 ...imageLayers
//                                     .map((layer) => _buildImageLayer(layer)),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//               ),
//               if (!widget.controlsAtTop)
//                 AnimatedOpacity(
//                   opacity: _showControls && _showToolbar ? 1.0 : 0.0,
//                   duration: Duration(milliseconds: 300),
//                   child: AnimatedSize(
//                     duration: Duration(milliseconds: 300),
//                     alignment: Alignment.bottomCenter,
//                     child: _showControls && _showToolbar
//                         ? Column(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               _buildControls(),
//                               Toolbar(
//                                 controller: _controller,
//                                 onPickImage: widget.onPickImage ?? () {},
//                               ),
//                             ],
//                           )
//                         : SizedBox.shrink(),
//                   ),
//                 ),
//               SizedBox(height: MediaQuery.of(context).padding.bottom)
//             ],
//           ),
//         ),
//         Positioned(
//           left: 10,
//           top: 60,
//           child: Column(
//             children: [
//               FloatingActionButton(
//                 mini: true,
//                 child: Icon(
//                   _showToolbar ? Icons.visibility_off : Icons.visibility,
//                 ),
//                 onPressed: () {
//                   setState(() {
//                     _showToolbar = !_showToolbar;
//                     _showControls = !_showControls;
//                   });
//                 },
//               ),
//               if (_showToolbar)
//                 Toolbar(
//                   controller: _controller,
//                   onPickImage: widget.onPickImage ?? () {},
//                 ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _paintSignature() {
//     return Stack(
//       children: [
//         RepaintBoundary(
//           key: _repaintKey,
//           child: ClipRect(
//             child: Container(
//               width: widget.width ?? double.maxFinite,
//               height: widget.height ?? double.maxFinite,
//               child: AnimatedBuilder(
//                 animation: _controller,
//                 builder: (_, __) {
//                   return InteractiveViewer(
//                     transformationController: _transformationController,
//                     panEnabled: false,
//                     scaleEnabled: false,
//                     onInteractionStart: _scaleStartGesture,
//                     onInteractionUpdate: _scaleUpdateGesture,
//                     onInteractionEnd: _scaleEndGesture,
//                     child: CustomPaint(
//                       willChange: true,
//                       isComplex: true,
//                       painter: SignaturePainter(
//                         backgroundColor: widget.signatureBackgroundColor,
//                         controller: _controller,
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//         ),
//         if (widget.showControls && widget.showToolbar)
//           Positioned(
//             top: 0,
//             right: 0,
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 IconButton(
//                   tooltip: textDelegate.undo,
//                   icon: widget.undoIcon ??
//                       Icon(Icons.reply, color: Colors.grey[700]),
//                   onPressed: () => _controller.undo(),
//                 ),
//                 IconButton(
//                   tooltip: textDelegate.clearAllProgress,
//                   icon: widget.clearAllIcon ??
//                       Icon(Icons.clear, color: Colors.grey[700]),
//                   onPressed: () => _controller.clear(),
//                 ),
//               ],
//             ),
//           ),
//       ],
//     );
//   }

//   _scaleStartGesture(ScaleStartDetails onStart) {
//     final _zoomAdjustedOffset =
//         _transformationController.toScene(onStart.localFocalPoint);
//     if (!widget.isSignature) {
//       _controller.setStart(_zoomAdjustedOffset);
//       _controller.addOffsets(_zoomAdjustedOffset);
//     }
//   }

//   ///Fires while user is interacting with the screen to record painting.
//   void _scaleUpdateGesture(ScaleUpdateDetails onUpdate) {
//     final _zoomAdjustedOffset =
//         _transformationController.toScene(onUpdate.localFocalPoint);
//     _controller.setInProgress(true);
//     if (_controller.start == null) {
//       _controller.setStart(_zoomAdjustedOffset);
//     }
//     _controller.setEnd(_zoomAdjustedOffset);
//     if (_controller.mode == PaintMode.freeStyle) {
//       _controller.addOffsets(_zoomAdjustedOffset);
//     }
//     if (_controller.onTextUpdateMode) {
//       _controller.paintHistory
//           .lastWhere((element) => element.mode == PaintMode.text)
//           .offsets = [_zoomAdjustedOffset];
//     }
//   }

//   ///Fires when user stops interacting with the screen.
//   void _scaleEndGesture(ScaleEndDetails onEnd) {
//     _controller.setInProgress(false);
//     if (_controller.start != null &&
//         _controller.end != null &&
//         (_controller.mode == PaintMode.freeStyle)) {
//       _controller.addOffsets(null);
//       _addFreeStylePoints();
//       _controller.offsets.clear();
//     } else if (_controller.start != null &&
//         _controller.end != null &&
//         _controller.mode != PaintMode.text) {
//       _addEndPoints();
//     }
//     _controller.resetStartAndEnd();
//   }

//   void _addEndPoints() => _addPaintHistory(
//         PaintInfo(
//           offsets: <Offset?>[_controller.start, _controller.end],
//           mode: _controller.mode,
//           color: _controller.color,
//           strokeWidth: _controller.scaledStrokeWidth,
//           fill: _controller.fill,
//         ),
//       );

//   void _addFreeStylePoints() => _addPaintHistory(
//         PaintInfo(
//           offsets: <Offset?>[..._controller.offsets],
//           mode: PaintMode.freeStyle,
//           color: _controller.color,
//           strokeWidth: _controller.scaledStrokeWidth,
//         ),
//       );

//   PopupMenuItem _showOptionsRow() {
//     return PopupMenuItem(
//       enabled: false,
//       child: Center(
//         child: SizedBox(
//           child: Wrap(
//             children: paintModes(textDelegate)
//                 .map(
//                   (item) => SelectionItems(
//                     data: item,
//                     isSelected: _controller.mode == item.mode,
//                     selectedColor: widget.optionSelectedColor,
//                     unselectedColor: widget.optionUnselectedColor,
//                     onTap: () {
//                       if (widget.onPaintModeChanged != null) {
//                         widget.onPaintModeChanged!(item.mode);
//                       }
//                       _controller.setMode(item.mode);

//                       Navigator.of(context).pop();
//                       if (item.mode == PaintMode.text) {
//                         _openTextDialog();
//                       }
//                     },
//                   ),
//                 )
//                 .toList(),
//           ),
//         ),
//       ),
//     );
//   }

//   PopupMenuItem _showRangeSlider() {
//     return PopupMenuItem(
//       enabled: false,
//       child: SizedBox(
//         width: double.maxFinite,
//         child: AnimatedBuilder(
//           animation: _controller,
//           builder: (_, __) {
//             return RangedSlider(
//               value: _controller.strokeWidth,
//               onChanged: (value) {
//                 _controller.setStrokeWidth(value);
//                 if (widget.onStrokeWidthChanged != null) {
//                   widget.onStrokeWidthChanged!(value);
//                 }
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }

//   PopupMenuItem _showColorPicker() {
//     return PopupMenuItem(
//       enabled: false,
//       child: Center(
//         child: Wrap(
//           alignment: WrapAlignment.center,
//           spacing: 10,
//           runSpacing: 10,
//           children: (widget.colors ?? editorColors).map((color) {
//             return ColorItem(
//               isSelected: color == _controller.color,
//               color: color,
//               onTap: () {
//                 _controller.setColor(color);
//                 if (widget.onColorChanged != null) {
//                   widget.onColorChanged!(color);
//                 }
//                 Navigator.pop(context);
//               },
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }

//   void _addPaintHistory(PaintInfo info) {
//     if (info.mode != PaintMode.none) {
//       _controller.addPaintInfo(info);
//     }
//   }

//   void _openTextDialog() {
//     _controller.setMode(PaintMode.text);
//     final fontSize = 6 * _controller.strokeWidth;
//     TextDialog.show(
//       context,
//       _textController,
//       fontSize,
//       _controller.color,
//       textDelegate,
//       onFinished: (context) {
//         if (_textController.text.isNotEmpty) {
//           _addPaintHistory(
//             PaintInfo(
//               mode: PaintMode.text,
//               text: _textController.text,
//               offsets: [],
//               color: _controller.color,
//               strokeWidth: _controller.scaledStrokeWidth,
//             ),
//           );
//           _textController.clear();
//         }
//         Navigator.of(context).pop();
//       },
//     );
//   }

//   Widget _buildControls() {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//       decoration: BoxDecoration(
//         color: widget.controlsBackgroundColor ?? Colors.grey[200],
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 4,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           IconButton(
//             tooltip: "Sembunyikan Kontrol",
//             icon: Icon(Icons.close, color: Colors.transparent),
//             onPressed: () {
//               setState(() {
//                 _showControls = false;
//                 _showToolbar = false;
//               });
//             },
//           ),
//           AnimatedBuilder(
//             animation: _controller,
//             builder: (_, __) {
//               return PopupMenuButton(
//                 padding: const EdgeInsets.symmetric(vertical: 10),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 surfaceTintColor: Colors.transparent,
//                 tooltip: textDelegate.changeColor,
//                 icon: widget.colorIcon ??
//                     Container(
//                       padding: const EdgeInsets.all(2.0),
//                       height: 28,
//                       width: 28,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         border: Border.all(color: Colors.grey.shade500),
//                         color: _controller.color,
//                       ),
//                     ),
//                 itemBuilder: (_) => [_showColorPicker()],
//               );
//             },
//           ),
//           AnimatedBuilder(
//             animation: _controller,
//             builder: (_, __) {
//               return _controller.canFill()
//                   ? Row(
//                       children: [
//                         Checkbox.adaptive(
//                           value: _controller.shouldFill,
//                           activeColor: Colors.blue,
//                           onChanged: (val) {
//                             _controller.update(fill: val);
//                           },
//                         ),
//                         Text(
//                           textDelegate.fill,
//                           style: Theme.of(context).textTheme.bodyMedium,
//                         ),
//                       ],
//                     )
//                   : const SizedBox();
//             },
//           ),
//           const Spacer(),
//           IconButton(
//             tooltip: textDelegate.undo,
//             icon: widget.undoIcon ??
//                 Icon(Icons.reply, color: Colors.grey.shade700, size: 26),
//             onPressed: () {
//               widget.onUndo?.call();
//               _controller.undo();
//             },
//           ),
//           IconButton(
//             tooltip: "Hapus Semua",
//             icon: Icon(Icons.delete, color: Colors.red.shade400, size: 26),
//             onPressed: () {
//               AlertHapus.show(context, () {
//                 _controller.clear();
//               });
//             },
//           ),
//           InkWell(
//             borderRadius: BorderRadius.circular(10),
//             // onTap: () async {
//             //   String? filePath = await _simpanGambar();
//             //   if (filePath != null) {
//             //     AlertSimpan.show(context, filePath);
//             //   }
//             // },
//             // onTap: _simpanGambar,
//             onTap: _simpanGambar,
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//               decoration: BoxDecoration(
//                 color: Colors.blue.shade600,
//                 borderRadius: BorderRadius.circular(8),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.blue.withOpacity(0.3),
//                     blurRadius: 4,
//                     offset: const Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: Row(
//                 children: [
//                   Icon(Icons.save, color: Colors.white, size: 24),
//                   const SizedBox(width: 6),
//                   Text(
//                     "Simpan",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> _simpanGambar() async {
//     try {
//       final boundary = _painterKey.currentContext?.findRenderObject()
//           as RenderRepaintBoundary?;
//       if (boundary == null) return;
//       final image = await boundary.toImage(pixelRatio: 3.0);
//       final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
//       final bytes = byteData!.buffer.asUint8List();

//       final imageName = '${DateTime.now().millisecondsSinceEpoch}.png';
//       final directory = await getApplicationDocumentsDirectory();
//       final sampleDir = Directory('${directory.path}/sample');
//       await sampleDir.create(recursive: true);
//       final fullPath = '${sampleDir.path}/$imageName';

//       final imgFile = File(fullPath);
//       await imgFile.writeAsBytes(bytes);

//       if (mounted) {
//         AlertSimpan.show(context, fullPath);
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Gagal menyimpan: $e')),
//         );
//       }
//     }
//   }

//   // Future<void> _simpanGambar() async {
//   //   // try {
//   //   final boundary = _painterKey.currentContext?.findRenderObject()
//   //       as RenderRepaintBoundary?;
//   //   if (boundary == null) return null;

//   //   //   final image = await _controller.exportImage();
//   //   //  if (image == null) return null;
//   //   //   final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
//   //   //   final bytes = byteData!.buffer.asUint8List();

//   //   final image = await boundary.toImage(pixelRatio: 3.0);
//   //   final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
//   //   final bytes = byteData!.buffer.asUint8List();

//   //   final imageName = '${DateTime.now().millisecondsSinceEpoch}.png';
//   //   final directory = await getApplicationDocumentsDirectory();
//   //   final sampleDir = Directory('${directory.path}/sample');
//   //   await sampleDir.create(recursive: true);
//   //   final fullPath = '${sampleDir.path}/$imageName';

//   //   final imgFile = File(fullPath);
//   //   await imgFile.writeAsBytes(bytes);

//   //   if (mounted) {
//   //     AlertSimpan.show(context, fullPath);
//   //   }

//   //   // return fullPath;
//   //   // } catch (e) {
//   //   //   if (mounted) {
//   //   //     ScaffoldMessenger.of(context).showSnackBar(
//   //   //       SnackBar(content: Text('Gagal menyimpan: $e')),
//   //   //     );
//   //   //   }
//   //   //   return null;
//   //   // }
//   // }

//   // Future<String?> simpanGambar(
//   //     ImagePainterController _controller, BuildContext context) async {
//   // final image = await _controller.exportImage();
//   // if (image == null) return null;

//   // final imageName = '${DateTime.now().millisecondsSinceEpoch}.png';
//   // final directory = await getApplicationDocumentsDirectory();
//   // final sampleDir = Directory('${directory.path}/sample');
//   // await sampleDir.create(recursive: true);
//   // final fullPath = '${sampleDir.path}/$imageName';

//   //   final imgFile = File(fullPath);
//   //   await imgFile.writeAsBytes(image);

//   //   return fullPath;
//   // }
// }

// class ImageLayer {
//   final File image;
//   Offset offset;
//   double scale;
//   double rotation;

//   ImageLayer({
//     required this.image,
//     this.offset = Offset.zero,
//     this.scale = 1.0,
//     this.rotation = 0.0,
//   });
// }
