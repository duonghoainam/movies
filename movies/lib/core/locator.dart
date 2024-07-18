import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerSingletonAsync<SharedPreferences>(() async {
    final prefs =  await SharedPreferences.getInstance();
    return prefs;
  });

  locator.registerSingleton<GlobalKey<NavigatorState>>(
      GlobalKey(debugLabel: "Main Navigator"),
      instanceName: 'app_key');

  locator.registerSingleton<GlobalKey<NavigatorState>>(
      GlobalKey(debugLabel: "Main Navigator"),
      instanceName: 'main_key');

  await locator.allReady(timeout: const Duration(seconds: 5));
}

