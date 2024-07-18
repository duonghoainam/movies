import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FullImageScreen extends StatefulWidget {
  static const String routeName = 'fullImage';

  final Uint8List image;

  const FullImageScreen({super.key, required this.image});

  @override
  State<FullImageScreen> createState() => _FullImageScreenState();
}

class _FullImageScreenState extends State<FullImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PhotoView(
          maxScale: PhotoViewComputedScale.contained * 2,
          minScale: PhotoViewComputedScale.contained,
          backgroundDecoration: const BoxDecoration(color: Colors.transparent),
          imageProvider: MemoryImage(widget.image)),
    );
  }
}
