import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/core/model/movie.dart';
import 'package:movies/core/prefs_instance.dart';
import 'package:movies/core/widget/movie_card.dart';
import 'package:movies/presentation/home/home_provider.dart';


class FavoritesScreen extends ConsumerWidget {
  static const String routeName = 'favorites';
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    var state = ref.watch(homeProvider);
    var listFavorites = PrefsInstance().listFavorites;

    return ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, i) {
          var movieId = state.movies[i].id;
          bool isFavorite = listFavorites.contains(movieId);

          return isFavorite ? HorizontalMovieCard(movie: state.movies[i]) : SizedBox.shrink();
        },
        itemCount: state.movies.length,);
  }
}
