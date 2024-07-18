import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:movies/core/service/geo_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

var locationProvider =
StateNotifierProvider<LocationService, LocationState>((ref) {
  var service = LocationService();
  service.requestPermission();
  service.getLocationPermission();
  service.getCurrentPosition();
  return service;
});
final positionProvider = StateProvider<Position?>((ref) => null);
final fileProvider = StateProvider<File?>((ref) => null);
final textProvider = StateProvider<String?>((ref) => null);
class DetectImgScreen extends ConsumerStatefulWidget {
  static const String  routeName = 'detectImage';
  const DetectImgScreen({Key? key}) : super(key: key);

  @override
  _DetectImgScreenState createState() => _DetectImgScreenState();
}

class _DetectImgScreenState extends ConsumerState<DetectImgScreen> {
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    print(permission);
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
  Future<void> _pickImage() async {
    final position = await determinePosition();
    ref.read(positionProvider.notifier).state = position;
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;
    final file = File(image.path);
    ref.read(fileProvider.notifier).state = file;
    _processImage(file);
  }

  Future<void> _processImage(File file) async {
    final inputImage = InputImage.fromFilePath(file.path);
    final textRecognizer = TextRecognizer();
    final RecognizedText recognizedText =
    await textRecognizer.processImage(inputImage);
    String text = recognizedText.text;
    print(text);
    textRecognizer.close();
    ref.read(textProvider.notifier).state = text;
  }
  @override
  Widget build(BuildContext context) {
    final file = ref.watch(fileProvider);
    final text = ref.watch(textProvider);
    final location = ref.watch(positionProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Text Recognizer Screen'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              file == null
                  ? const Text('No image selected.')
                  : Image.file(file),
              const SizedBox(height: 20),
              text == null ? const Text('No text recognized.') : Text(text),
              const SizedBox(height: 20),
              location == null ? const Text('No location recognized.') : Text(location.toString()),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _pickImage();
                },
                child: const Text('Pick Image'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
