import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movies/core/locator.dart';
import 'package:movies/core/model/movie.dart';
import 'package:movies/presentation/auth/screen/login_screen.dart';
import 'package:movies/presentation/barcode/bar_code_screen.dart';
import 'package:movies/presentation/drawing/draw_screen.dart';
import 'package:movies/presentation/drawing/fullscreen_image.dart';
import 'package:movies/presentation/drawing/image_edit.dart';
import 'package:movies/presentation/favorite/favorites_screen.dart';
import 'package:movies/presentation/home/home_screen.dart';
import 'package:movies/presentation/main/main_screen.dart';
import 'package:movies/presentation/movie_detail/movie_detail_screen.dart';
import 'package:movies/presentation/onboard/onboard_screen.dart';
import 'package:movies/presentation/profile/profile_screen.dart';
import 'package:movies/presentation/test_screen/test_screen.dart';

final _appKey = GlobalKey<NavigatorState>();
final _mainKey = GlobalKey<NavigatorState>();
final routes =
GoRouter(navigatorKey: _appKey, initialLocation: '/draw', routes: [
  ShellRoute(
      navigatorKey: _mainKey,
      builder: (context, state, child) {
        return MainScreen(child);
      },
      routes: [
        GoRoute(
          path: "draw",
          name: DrawScreen.routeName,
          pageBuilder: (context, state) {
            return const NoTransitionPage(child: DrawScreen());
          },
          routes: [
            GoRoute(
              path: 'movieDetail',
              name: MovieDetailScreen.routeName,
              builder: (context, state) {
                return MovieDetailScreen(state.extra as Movie);
              },
            )
          ]
        ),
        GoRoute(
          path: '/image_edit',
          name: ImageEditScreen.routeName,
          parentNavigatorKey: locator.get<GlobalKey<NavigatorState>>(
              instanceName: 'app_key'),
          pageBuilder: (context, state) =>
              CupertinoPage(
                  child: ImageEditScreen(
                    image: state.extra as Uint8List,
                  )),
        ),
        GoRoute(
          path: '/full_image',
          name: FullImageScreen.routeName,
          parentNavigatorKey: locator.get<GlobalKey<NavigatorState>>(
              instanceName: 'app_key'),
          pageBuilder: (context, state) =>
              CupertinoPage(
                  child: FullImageScreen(
                    image: state.extra as Uint8List,
                  )),
        ),
        GoRoute(
            path: "/barcode",
            name: BarcodeScannerView.routeName,
            pageBuilder: (context, state) =>
            const NoTransitionPage(child: BarcodeScannerView()),
        ),
        GoRoute(
            path: "/profile",
            name: ProfileScreen.routeName,
            pageBuilder: (context, state) =>
            const NoTransitionPage(child: ProfileScreen()),
        ),
        GoRoute(
          path: "/detectImage",
          name: DetectImgScreen.routeName,
          pageBuilder: (context, state) =>
          const NoTransitionPage(child: DetectImgScreen()),
        ),
      ]),
  GoRoute(
    path: "/login",
    name: LoginScreen.routeName,
    builder: (context, state) => const LoginScreen(),
  ),
  GoRoute(
    path: "/onboard",
    name: OnboardScreen.routeName,
    builder: (context, state) => const OnboardScreen(),
  ),
]);