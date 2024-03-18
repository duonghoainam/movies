class Movie {
  final String id;
  final String title;
  final String year;
  final List<String> genres;
  final List<int> ratings;
  final String poster;
  final String contentRating;
  final String duration;
  final String releaseDate;
  final num averageRating;
  final String originalTitle;
  final String storyline;
  final List<String> actors;
  final num imdbRating;
  final String posterUrl;

  const Movie.empty({
  this.id = '',
  this.title = '',
  this.year = '',
  this.genres = const [],
  this.ratings = const [],
  this.poster = '',
  this.contentRating = '',
  this.duration = '',
  this.releaseDate = '',
  this.averageRating = 0,
  this.originalTitle = '',
  this.storyline = '',
  this.actors = const [],
  this.imdbRating = 0,
  this.posterUrl = '',
  });

  Movie({
    required this.id,
    required this.title,
    required this.year,
    required this.genres,
    required this.ratings,
    required this.poster,
    required this.contentRating,
    required this.duration,
    required this.releaseDate,
    required this.averageRating,
    required this.originalTitle,
    required this.storyline,
    required this.actors,
    required this.imdbRating,
    required this.posterUrl,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      year: json['year'] ?? '',
      genres: List<String>.from(json['genres']) ?? [],
      ratings: List<int>.from(json['ratings']) ?? [],
      poster: json['poster'] ?? '',
      contentRating: json['contentRating'] ?? '',
      duration: json['duration'] ?? '',
      releaseDate: json['releaseDate'] ?? '',
      averageRating: json['averageRating'] ?? 0.0,
      originalTitle: json['originalTitle'] ?? '',
      storyline: json['storyline'] ?? '',
      actors: List<String>.from(json['actors']) ?? [],
      imdbRating: (json['imdbRating'] is String)? 0 : json['imdbRating'] ?? 0.0,
      posterUrl: json['posterurl'],
    );
  }

  Movie copyWith({
    String? id,
    String? title,
    String? year,
    List<String>? genres,
    List<int>? ratings,
    String? poster,
    String? contentRating,
    String? duration,
    String? releaseDate,
    num? averageRating,
    String? originalTitle,
    String? storyline,
    List<String>? actors,
    num? imdbRating,
    String? posterUrl,
  }) {
    return Movie(
      id: id ?? this.id,
      title: title ?? this.title,
      year: year ?? this.year,
      genres: genres ?? this.genres,
      ratings: ratings ?? this.ratings,
      poster: poster ?? this.poster,
      contentRating: contentRating ?? this.contentRating,
      duration: duration ?? this.duration,
      releaseDate: releaseDate ?? this.releaseDate,
      averageRating: averageRating ?? this.averageRating,
      originalTitle: originalTitle ?? this.originalTitle,
      storyline: storyline ?? this.storyline,
      actors: actors ?? this.actors,
      imdbRating: imdbRating ?? this.imdbRating,
      posterUrl: posterUrl ?? this.posterUrl,
    );
  }

  @override
  String toString() {
    return 'Movie{id: $id, title: $title, year: $year, genres: $genres, ratings: $ratings, poster: $poster, contentRating: $contentRating, duration: $duration, releaseDate: $releaseDate, averageRating: $averageRating, originalTitle: $originalTitle, storyline: $storyline, actors: $actors, imdbRating: $imdbRating, posterUrl: $posterUrl}';
  }
}
