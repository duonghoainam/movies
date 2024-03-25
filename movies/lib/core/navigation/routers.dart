import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movies/core/model/movie.dart';
import 'package:movies/presentation/auth/screen/login_screen.dart';
import 'package:movies/presentation/favorite/favorites_screen.dart';
import 'package:movies/presentation/home/home_screen.dart';
import 'package:movies/presentation/main/main_screen.dart';
import 'package:movies/presentation/movie_detail/movie_detail_screen.dart';
import 'package:movies/presentation/onboard/onboard_screen.dart';
import 'package:movies/presentation/profile/profile_screen.dart';

final _appKey = GlobalKey<NavigatorState>();
final _mainKey = GlobalKey<NavigatorState>();
final routes =
GoRouter(navigatorKey: _appKey, initialLocation: '/onboard', routes: [
  ShellRoute(
      navigatorKey: _mainKey,
      builder: (context, state, child) {
        return MainScreen(child);
      },
      routes: [
        GoRoute(
          path: "/home",
          name: HomeScreen.routeName,
          pageBuilder: (context, state) {
            return const NoTransitionPage(child: HomeScreen());
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
            path: "/favorites",
            name: FavoritesScreen.routeName,
            pageBuilder: (context, state) =>
            const NoTransitionPage(child: FavoritesScreen()),
        ),
        GoRoute(
            path: "/profile",
            name: ProfileScreen.routeName,
            pageBuilder: (context, state) =>
            const NoTransitionPage(child: ProfileScreen()),
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