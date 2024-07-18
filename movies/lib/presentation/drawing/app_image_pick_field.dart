import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movies/core/constant/color.dart';
import 'package:movies/core/until/image_picker_handle.dart';
import 'package:movies/presentation/drawing/fullscreen_image.dart';
import 'package:movies/presentation/drawing/image_edit.dart';

class AppImagePickField extends FormField<Uint8List> {
  final void Function(Uint8List? value)? onChange;

  AppImagePickField({
    super.key,
    double height = 200,
    List<Widget> action = const [],
    double imageWidth = 500,
    EdgeInsetsGeometry? margin,
    this.onChange,
    super.initialValue,
  }) : super(
          builder: (field) {
            final state = field as _ImageState;

            bool empty = state.image == null || state.image!.isEmpty;
            return Container(
              margin: margin,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: state.pickImage,
                            icon: Image.asset(
                              'assets/images/camera_onpage.png',
                              width: 28,
                              height: 28,
                            )),
                        if (empty == false)
                          IconButton(
                              onPressed: state.editImage,
                              icon: Image.asset(
                                'assets/images/edit_page_48x56.png',
                                width: 28,
                                height: 28,
                              )),
                        ...action
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: Container(
                      height: height,
                      clipBehavior: Clip.hardEdge,
                      // width: imageWidth,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: AppColors.grey),
                      ),
                      child: empty
                          ? GestureDetector(
                              onTap: state.pickImage,
                              child: Image.asset(
                                'assets/images/camera_infield_30percent_200x141.png',
                                fit: BoxFit.fill,
                              ),
                            )
                          : GestureDetector(
                              onTap: state.showFullScreen,
                              child:
                                  Image.memory(state.image!, fit: BoxFit.fill),
                            ),
                    ),
                  ),
                ],
              ),
            );
          },
        );

  @override
  FormFieldState<Uint8List> createState() => _ImageState();
}

class _ImageState extends FormFieldState<Uint8List> {
  Uint8List? image;

  @override
  AppImagePickField get widget => super.widget as AppImagePickField;

  @override
  void initState() {
    if (widget.initialValue != null) {
      image = widget.initialValue;
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant FormField<Uint8List> oldWidget) {
    if (oldWidget.initialValue != widget.initialValue) {
      image = widget.initialValue;
    }
    super.didUpdateWidget(oldWidget);
  }

  Future<void> pickImage() async {
    ImagePickerHandler().showDialog(context, (value) async {
      final file = File(value);

      image = await file.readAsBytes();
      didChange(image);
      widget.onChange?.call(image);
    });
  }

  Future<void> editImage() async {
    var result =
        await context.pushNamed<Uint8List>(ImageEditScreen.routeName, extra: image!);
    if (result != null) {
      image = result;
      didChange(image);
      widget.onChange?.call(image);
    }
  }

  void showFullScreen() {
    context.pushNamed(FullImageScreen.routeName, extra: image);
  }
}
