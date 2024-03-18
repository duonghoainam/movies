import 'package:flutter/material.dart';
import 'package:movies/core/constant/color.dart';
abstract final class AppTheme {
  static final main = ThemeData(
    useMaterial3: false,
    appBarTheme: const AppBarTheme(iconTheme: IconThemeData(color: AppColors.white))
  );
}