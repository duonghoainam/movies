import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/core/widget/movie_card.dart';
import 'package:movies/presentation/home/home_provider.dart';
class HomeScreen extends ConsumerWidget {
  static const String routeName = 'home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    var state = ref.watch(homeProvider);

    return ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, i) {
          return HorizontalMovieCard(
            movie: state.movies[i],
          );
        },
        itemCount: state.movies.length);
  }
}
