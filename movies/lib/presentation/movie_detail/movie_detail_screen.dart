import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/core/constant/color.dart';
import 'package:movies/core/constant/string.dart';
import 'package:movies/core/model/movie.dart';
import 'package:movies/core/prefs_instance.dart';
import 'package:movies/core/until/untils.dart';
import 'package:movies/core/widget/actor_circle_widget.dart';
import 'package:movies/presentation/favorite/favorites_screen.dart';

final isSavedProvider = FutureProvider.family<bool, String>((ref, id) {
  return PrefsInstance().checkFavorites(id);
});

class MovieDetailScreen extends ConsumerWidget {
  static const String routeName = 'movieDetail';
  final Movie movie;
  const MovieDetailScreen(this.movie, {super.key});

  @override
  Widget build(BuildContext context, ref) {
    final isSaved = ref.watch(isSavedProvider(movie.id));
    return Scaffold(
      backgroundColor: AppColors.backgroundApp,
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent,
          elevation: 0.0),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          AspectRatio(
          aspectRatio: 3 / 4,
          child: CachedNetworkImage(
              imageUrl: movie.posterUrl,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Image.asset(AppString.assetUrlPostPlaceholder),
              fit: BoxFit.cover,
            ),
          ),
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15), ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              movie.title,
                              overflow: TextOverflow.fade,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          if (movie.contentRating.isNotEmpty) Container(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              decoration: ShapeDecoration(
                                  color: AppColors.red,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5))),
                              child: Text(
                                movie.contentRating,
                                style: const TextStyle(color: AppColors.white),
                              )),
                        ],
                      ),
                    ),
                    isSaved.when(
                      loading: () => Icon(Icons.favorite_border, color: AppColors.white,),
                      error: (error, stackTrace) => Icon(Icons.favorite_border, color: AppColors.white,),
                      data: (data) => IconButton(onPressed: () async {
                        if (data){
                          PrefsInstance().removeFavorites(movie.id);

                        } else {
                          PrefsInstance().addFavorite(movie.id);
                        }
                        ref.refresh(isSavedProvider(movie.id).future);
                        ref.refresh(favoritesProvider);

                      }, icon: Icon(data? Icons.favorite_outlined :Icons.favorite_border, color: data? AppColors.red : AppColors.white,)),
                    )
                  ],
                ),
                if (movie.imdbRating > 0) Row(
                  children: [
                    Text(
                      movie.imdbRating.toString(),
                      style: TextStyle(
                        color: Colors.amber,
                        letterSpacing: 1.2,
                      ),
                    ),
                    Icon(Icons.star, color: Colors.amber, size: 14,),
                    const Text(
                      " imdb",
                      style: TextStyle(
                        color: Colors.amber,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  '${movie.releaseDate}  ${parseDuration(movie.duration)}',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6000000238418579),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
                SizedBox(height: 10,),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      if (movie.genres.isNotEmpty)
                        ...renderTag(movie.genres),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  child: Text(movie.storyline,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.37,
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Actors',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'View All',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                if (movie.actors.isNotEmpty) Container(
                  height: 60,
                  child: ListView.builder(
                    itemCount: movie.actors.length,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final int length = movie.actors.length - 1;
                      final item = movie.actors[index];
                      return Container(
                        margin: EdgeInsets.only(
                            left: index == 0 ? 0 : 5,
                            right: index == length ? 0 : 5),
                        child: ActorCircleWidget(
                          actor: item,
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20,),

              ],
            ),
          )
        ],
      ),
    );
  }

  List <Widget> renderTag(List<String> genres) {
    return List.generate(genres.length, (index) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        margin: const EdgeInsets.only(right: 10),
        decoration: ShapeDecoration(
            color: AppColors.backgroundElementGrey,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5))),
        child: Text(
          genres[index],
          style: const TextStyle(color: AppColors.white),
        )));
  }
}
