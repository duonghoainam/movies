import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/core/prefs_instance.dart';
import 'package:movies/core/widget/movie_card.dart';
import 'package:movies/presentation/home/home_provider.dart';

final favoritesProvider = StateProvider.autoDispose((ref) {
  var state = ref.watch(homeProvider);
  var listFavorites = PrefsInstance().listFavorites;
  return state.movies.where((element) => listFavorites.contains(element.id)).toList();
},);
class FavoritesScreen extends ConsumerWidget {
  static const String routeName = 'favorites';
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final favorites = ref.watch(favoritesProvider);

    return ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, i) {
          return HorizontalMovieCard(movie: favorites[i]);
        },
        itemCount: favorites.length,);
  }
}
