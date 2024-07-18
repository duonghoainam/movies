import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movies/core/constant/color.dart';
import 'package:movies/core/constant/string.dart';


class ImagePickerHandler {
  final int _imageQuality = 70;
  final double _maxW = 800;
  final double _maxH = 800;

  void openCamera(Function(String value) result) async {
    XFile? image = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: _imageQuality,
        maxWidth: _maxW,
        maxHeight: _maxH);
    // AppLog.wtf(image);
    if (image != null) {
      result(image.path);
    }
  }

  void openGallery(Function(String value) result) async {
    XFile? image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: _imageQuality,
        maxWidth: _maxW,
        maxHeight: _maxH);
    if (image != null) {
      result(image.path);
    }
  }

  // void openVideoFromGallery(Function(String? path) result) async {
  //   // XFile? video = await ImagePicker().pickVideo(
  //   //   source: ImageSource.gallery,
  //   // );
  //   // if (video != null) {
  //   //   print(video.path);
  //   //   result(video.path);
  //   //   // await VideoCompress.setLogLevel(0);
  //   //
  //   // }
  //
  //   FilePickerResult? video = await FilePicker.platform.pickFiles(
  //     type: FileType.video,
  //     allowMultiple: false,
  //     allowCompression: false,
  //   );
  //
  //   if(video != null){
  //     print(video.paths);
  //     result(video.paths.first);
  //   }
  // }

  void chooseImagesFromGallery(Function(List<String> value) results) async {
    List<XFile> images = await ImagePicker().pickMultiImage(
        imageQuality: _imageQuality, maxWidth: _maxW, maxHeight: _maxH);
    var result = images.map((e) => e.path).toList();
    results(result);
  }

  // Future<void> showManyCoolChoice(
  //   BuildContext context, {
  //   Function(List<String>? paths)? result,
  //   // Function(String? path)? cameraResult,
  //       bool haveYoutube = true,
  //   required VoidCallback onAddYoutubeLink,
  //   Function(String videoPath)? videoResult,
  // }) async {
  //   FocusScope.of(context).unfocus();
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (BuildContext bc) {
  //         return Container(
  //           padding: EdgeInsets.only(
  //             bottom: DataInstance().bottomPhoneHeight + kDouble_20,
  //           ),
  //           decoration: BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.only(
  //                 topLeft: Radius.circular(16), topRight: Radius.circular(16)),
  //           ),
  //           child: Wrap(alignment: WrapAlignment.start, children: [
  //             Column(
  //               children: <Widget>[
  //                 ListTile(
  //                   onTap: () {
  //                     Navigator.of(bc).pop();
  //                     openCamera((file) {
  //                       if (result != null) result([file!]);
  //                     });
  //                   },
  //                   leading: Icon(
  //                     Icons.photo_camera,
  //                     color: kBlackColor,
  //                   ),
  //                   title: Text(
  //                     AppString.btnCamera,
  //                     style: TextStyleCustom.dynamicRegularTextStyle(),
  //                   ),
  //                 ),
  //                 ListTile(
  //                   onTap: () {
  //                     Navigator.of(bc).pop();
  //                     this.chooseImagesFromGallery((file) {
  //                       if (result != null) result(file);
  //                     });
  //                   },
  //                   leading: Icon(
  //                     Icons.image,
  //                     color: kBlackColor,
  //                   ),
  //                   title: Text(
  //                     AppString.btnGallery,
  //                     style: TextStyleCustom.dynamicRegularTextStyle(),
  //                   ),
  //                 ),
  //             if(haveYoutube)    ListTile(
  //                   onTap: () {
  //                     Navigator.of(bc).pop();
  //                     onAddYoutubeLink();
  //                   },
  //                   leading: Icon(
  //                     FontAwesomeIcons.youtube,
  //                     color: kBlackColor,
  //                   ),
  //                   title: Text(
  //                     AppString.btnYoutube,
  //                     style: TextStyleCustom.dynamicRegularTextStyle(),
  //                   ),
  //                 ),
  //                 ListTile(
  //                   onTap: () {
  //                     Navigator.of(bc).pop();
  //                     openVideoFromGallery((String? path) {
  //                       if (path != null && videoResult != null) {
  //                         videoResult(path);
  //                       }
  //                     });
  //                   },
  //                   leading: Icon(
  //                     FontAwesomeIcons.video,
  //                     color: kBlackColor,
  //                   ),
  //                   title: Text(
  //                     AppString.btnVideo,
  //                     style: TextStyleCustom.dynamicRegularTextStyle(),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ]),
  //         );
  //       });
  // }

  Future<void> showDialog(
      BuildContext context, Function(String value) result) async {
    FocusScope.of(context).unfocus();
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          padding: const EdgeInsets.only(
            bottom: 40,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16)),
          ),
          child: Wrap(
            alignment: WrapAlignment.start,
            children: <Widget>[
              Column(
                children: <Widget>[
                  ListTile(
                    onTap: () {
                      Navigator.of(bc).pop();
                      openCamera(result);
                    },
                    leading: const Icon(
                      Icons.photo_camera,
                      color: AppColors.black,
                    ),
                    title: Text(
                      'Camera',
                      // style: TextStyleCustom.dynamicRegularTextStyle(),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(bc).pop();
                      openGallery(result);
                    },
                    leading: const Icon(
                      Icons.image,
                      color: AppColors.black,
                    ),
                    title: Text(
                      'Gallery',
                      // style: TextStyleCustom.dynamicRegularTextStyle(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
