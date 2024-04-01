import 'dart:io';

// import 'package:device_info/device_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataInstance {
  static final DataInstance _instance = DataInstance.internal();

  DataInstance.internal();

  factory DataInstance() => _instance;
  late double screenW, screenH;
  late String accessToken;
  late String idToken;
  late bool isLogin;
  String? firebaseToken;

  bool flag = true;
  initPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
  }
}
