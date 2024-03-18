import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/core/constant/string.dart';
import 'package:movies/core/constant/theme.dart';
import 'package:movies/core/navigation/routers.dart';
void main() {

  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    runApp(const ProviderScope(
        child: MyApp()));
  }, (error, stack) {
    print(error);
    print(stack);
  });

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: routes,
      debugShowCheckedModeBanner: false,
      title: AppString.appTitle,
      theme: AppTheme.main,
    );
  }
}