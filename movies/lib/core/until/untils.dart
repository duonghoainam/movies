import 'package:flutter/widgets.dart';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

Future<String> getAssetPath(String asset) async {
  final path = await getLocalPath(asset);
  await Directory(dirname(path)).create(recursive: true);
  final file = File(path);
  if (!await file.exists()) {
    final byteData = await rootBundle.load(asset);
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
  }
  return file.path;
}

Future<String> getLocalPath(String path) async {
  return '${(await getApplicationSupportDirectory()).path}/$path';
}
void unFocus(BuildContext context){
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.focusedChild?.unfocus();
  }
}

String parseDuration(String durationString) {
  // Remove the "PT" prefix
  durationString = durationString.replaceAll("PT", "");

  // Parse hours and minutes
  int hours = 0;
  int minutes = 0;

  if (durationString.contains("H")) {
    hours = int.parse(durationString.split("H")[0]);
    durationString = durationString.split("H")[1];
  }

  if (durationString.contains("M")) {
    minutes = int.parse(durationString.split("M")[0]);
  }

  // Format the duration
  String formattedDuration = '';
  if (hours > 0) {
    formattedDuration += '$hours h ';
  }
  if (minutes > 0) {
    formattedDuration += '$minutes min';
  }

  return formattedDuration.trim();
}

class TimeUtils {
  DateTime? _start;

  void start() {
    _start = DateTime.now();
  }

  Duration current() {
    if (_start == null) throw 'not start';
    return DateTime.now().difference(_start!);
  }

  String currentMs() {
    return '${current().inMilliseconds}ms';
  }
}

Future<Uint8List> loadFromAsset(String key) async {
  final ByteData byteData = await rootBundle.load(key);
  return byteData.buffer.asUint8List();
}