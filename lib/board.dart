import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_painter/image_painter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whiteboard/utils/addImageLayer.dart';
import 'package:whiteboard/utils/classImageLayer.dart';
import 'package:whiteboard/utils/listColor.dart';
import 'package:whiteboard/utils/imageControl.dart';
import 'package:whiteboard/utils/simpanGambar.dart';
import 'package:whiteboard/widget/alertHapus.dart';
import 'package:whiteboard/widget/alertKeluar.dart';
import 'package:whiteboard/widget/imageLayer.dart';
import 'package:whiteboard/widget/toolbar.dart';
import '../widget/image_selection.dart';
import '../widget/backgroundPainter.dart';

class Board extends StatefulWidget {
  const Board({super.key});

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  bool _showImageControls = true;
  bool _isToolbarVisible = true;
  GlobalKey? _painterKey;
  String? selectedImage;
  ImagePainterController? _controller;
  List<ImageLayer> imageLayers = [];
  ImageLayer? selectedLayer;
  final List<Color> editorColors = editorColorsList;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Widget _buildImageControls() {
    return buildImageControls(
      controller: _controller,
      context: context,
      onUndo: _controller!.undo,
      onDeleteAll: () {
        AlertHapus.show(context, () {
          if (_controller != null) {
            _controller!.clear();
          }
        });
      },
      onSave: () async {
        setState(() {
          _isToolbarVisible = false;
          _showImageControls = false;
        });
        await simpanGambar(_painterKey!, context);
      },
      isToolbarVisible: _isToolbarVisible,
      showImageControls: _showImageControls,
      onToggleVisibility: (isVisible, showControls) {
        setState(() {
          _isToolbarVisible = isVisible;
          _showImageControls = showControls;
        });
      },
    );
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        addImageLayer(imageLayers, File(pickedFile.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: selectedImage != null && _isToolbarVisible
          ? AppBar(actions: [_buildImageControls()])
          : null,
      body: Stack(
        children: [
          Positioned.fill(
            child: selectedImage == null
                ? ImageSelection(
                    onImageSelected: (image) => setState(() {
                      selectedImage = image;
                      _controller?.dispose();
                      _controller = ImagePainterController();
                      _painterKey = GlobalKey();
                    }),
                  )
                : RepaintBoundary(
                    key: _painterKey,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          for (var layer in imageLayers) {
                            layer.showDeleteButton = false;
                            layer.showCheckButton = false;
                            layer.showRotateButton = false;
                          }
                        });
                      },
                      child: Stack(
                        children: [
                          buildBackgroundPainter(
                            selectedImage: selectedImage,
                            controller: _controller,
                            onPickImage: _pickImage,
                          ),
                          ...imageLayers.map(
                            (layer) => buildImageLayer(
                              layer: layer,
                              onUpdatePosition: (layer, delta) => setState(() {
                                layer.offset += delta;
                              }),
                              onScale: (layer, scale) => setState(() {
                                layer.scale = scale.clamp(0.1, 5.0);
                              }),
                              onDelete: (layer) => setState(() {
                                imageLayers.remove(layer);
                              }),
                              onToggleHide: (layer) => setState(() {
                                layer.showDeleteButton =
                                    !layer.showDeleteButton;
                                layer.showCheckButton = !layer.showCheckButton;
                                layer.showRotateButton =
                                    !layer.showRotateButton;
                              }),
                              onRotate: (layer, degrees) => setState(() {
                                layer.rotation += degrees * (3.1416 / 180);
                              }),
                              onResize: (layer, delta) => setState(() {
                                layer.scale =
                                    (layer.scale + delta).clamp(0.1, 5.0);
                              }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
          if (selectedImage != null)
            Positioned(
              top: 20,
              left: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton.icon(
                    icon: Icon(
                      _isToolbarVisible && _showImageControls
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.white,
                    ),
                    label: Text(
                      _isToolbarVisible && _showImageControls ? "Hide" : "Show",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () => setState(() {
                      _isToolbarVisible = !_isToolbarVisible;
                      _showImageControls = !_showImageControls;
                    }),
                  ),
                  if (_isToolbarVisible)
                    Toolbar(
                      controller: _controller!,
                      onPickImage: _pickImage,
                    ),
                ],
              ),
            ),
        ],
      ),
      floatingActionButton: selectedImage != null
          ? FloatingActionButton.extended(
              onPressed: () {
                AlertKeluar.show(context, () {
                  setState(() {
                    selectedImage = null;
                    _controller?.dispose();
                    _controller = null;
                    imageLayers.clear();
                    _painterKey = null;
                  });
                });
              },
              label: const Text("Menu Utama"),
              icon: const Icon(Icons.home),
            )
          : null,
    );
  }
}
