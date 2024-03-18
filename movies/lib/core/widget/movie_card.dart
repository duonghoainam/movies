import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movies/core/constant/color.dart';
import 'package:movies/core/constant/string.dart';
import 'package:movies/core/model/movie.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movies/presentation/movie_detail/movie_detail_screen.dart';

class HorizontalMovieCard extends StatelessWidget {
  final Movie movie;

  const HorizontalMovieCard({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: kElevationToShadow[8],
          borderRadius: BorderRadius.circular(10),
          color: AppColors.backgroundElementGrey),
      margin: const EdgeInsets.all(12.0),
      child: InkWell(
        onTap: () {
          context.pushNamed(MovieDetailScreen.routeName, extra: movie);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(boxShadow: kElevationToShadow[8]),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: AspectRatio(
                      aspectRatio: 9 / 14,
                      child: Stack(children: [
                        Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(5),
                              topRight: Radius.circular(5),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: CachedNetworkImage(
                            imageUrl: movie.posterUrl,
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) =>
                                Image.asset(AppString.assetUrlPostPlaceholder),
                            // Replace with your error widget
                            placeholder: (context, url) => const Center(
                                child:
                                    CircularProgressIndicator()), // Optional: Show a placeholder while loading
                          ),
                        ),
                        if (movie.contentRating.isNotEmpty)
                            Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                decoration: ShapeDecoration(
                                    color: AppColors.red,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5))),
                                child: Text(
                                  movie.contentRating,
                                  style:
                                      const TextStyle(color: AppColors.white),
                                )),
                      ])
                      // child: Container(
                      //      height: 20,
                      //      alignment: Alignment.topLeft,
                      //      decoration:  BoxDecoration(
                      //        image: DecorationImage(
                      //            fit: BoxFit.cover,
                      //            image: CachedNetworkImageProvider(movie.posterUrl),
                      //        ),
                      //          borderRadius: const BorderRadius.only(bottomRight: Radius.circular(5), topRight: Radius.circular(5)),
                      //      ),
                      //      child: movie.contentRating.isEmpty ? SizedBox():
                      //      Container(
                      //        padding: const EdgeInsets.symmetric(horizontal: 5),
                      //          decoration: ShapeDecoration(
                      //            color: AppColors.red,
                      //            shape: RoundedRectangleBorder(
                      //              borderRadius: BorderRadius.circular(5)
                      //            )
                      //          ),
                      //          child: Text(movie.contentRating, style: const TextStyle(color: AppColors.white),)),
                      //    ),
                      ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          movie.year,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            color: AppColors.white,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        if (movie.imdbRating > 0)
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 14,
                          ),
                        if (movie.imdbRating > 0)
                          Text(
                            "${movie.imdbRating} imdb",
                            style: const TextStyle(
                              color: Colors.amber,
                              letterSpacing: 1.2,
                            ),
                          )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        IconTheme(
                            data: const IconThemeData(
                              color: Colors.cyanAccent,
                              size: 20,
                            ),
                            child: Expanded(
                                child: Text(
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                              movie.storyline,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppColors.white,
                              ),
                            ))
                            // StarDisplay(
                            //   value: ((rate * 5) / 10).round(),
                            // ),
                            ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
