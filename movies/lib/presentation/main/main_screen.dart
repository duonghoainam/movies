import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movies/core/constant/color.dart';
import 'package:movies/core/constant/string.dart';
import 'package:movies/presentation/favorite/favorites_screen.dart';
import 'package:movies/presentation/home/home_screen.dart';
import 'package:movies/presentation/profile/profile_screen.dart';

var selectedTabProvider = StateProvider.autoDispose<int>((ref) => 0);

class MainScreen extends ConsumerStatefulWidget {
  final Widget child;

  const MainScreen(this.child, {super.key});

  @override
  ConsumerState createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  @override
  Widget build(BuildContext context) {
    var state = ref.watch(selectedTabProvider);
    final notifier = ref.watch(selectedTabProvider.notifier);

    ref.listen(selectedTabProvider, (previous, next) {
      if (next != previous) {
        switch (next) {
          case 0:
            context.goNamed(HomeScreen.routeName);
            break;
          case 1:
            context.goNamed(FavoritesScreen.routeName);
            break;
          case 2:
            context.goNamed(ProfileScreen.routeName);
            break;
        }
      }
    });
    return Scaffold(
      backgroundColor: AppColors.backgroundApp,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.backgroundElementGrey,
        selectedItemColor: AppColors.red,
        unselectedItemColor: Colors.grey,
        currentIndex: state,
        type: BottomNavigationBarType.fixed,
        unselectedFontSize: 12,
        selectedFontSize: 12,
        onTap: (value) {
          notifier.update((state) => value);
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: AppString.labelHome),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: AppString.labelFavorites),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: AppString.labelProfile),
        ],
        enableFeedback: true,
        showUnselectedLabels: true,
      ),
      body: widget.child,
    );
  }
}
