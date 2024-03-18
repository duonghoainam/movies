import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/core/model/movie.dart';
import 'package:movies/core/widget/movie_card.dart';


class FavoritesScreen extends ConsumerWidget {
  static const String routeName = 'favorites';
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {

    return ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, i) {
          return const HorizontalMovieCard(
            movie: Movie.empty(),
          );
        },
        itemCount: 0);
  }
}
