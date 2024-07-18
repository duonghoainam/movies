import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_painter/image_painter.dart';
import 'package:movies/core/constant/color.dart';

class ImageEditScreen extends ConsumerStatefulWidget {
  static const String routeName = 'editImage';

  final Uint8List image;

  const ImageEditScreen({required this.image, super.key});

  @override
  ConsumerState createState() => _ImageEditScreenState();
  static GlobalKey<ImagePainterState> painterkey =
      GlobalKey<ImagePainterState>();
}

class _ImageEditScreenState extends ConsumerState<ImageEditScreen> {
  Uint8List get data => widget.image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.green,
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            onPressed: () async {
              final image =
                  await ImageEditScreen.painterkey.currentState?.exportImage();
              if (context.mounted) {
                context.pop<Uint8List>(image);
              }
            },
            icon: const Icon(
              Icons.save_outlined,
            ),
          ),
        ],
      ),
      body: ImagePainter.memory(
        data,
        controlsAtTop: false,
        key: ImageEditScreen.painterkey,
      ),
    );
  }
}
