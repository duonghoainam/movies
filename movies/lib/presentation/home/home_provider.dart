import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/core/constant/api_paths.dart';
import 'package:movies/core/model/movie.dart';
import 'package:movies/core/service/network_service.dart';

class HomeState {
  final List<Movie> movies;
  final bool loading;
  final String? err;
  final bool? success;
  final bool submitting;

//<editor-fold desc="Data Methods">
  const HomeState({
    this.movies = const [],
    this.loading = true,
    this.submitting = false,
    this.err,
    this.success,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is HomeState &&
              runtimeType == other.runtimeType &&
              movies == other.movies &&
              loading == other.loading &&
              success == other.success &&
              submitting == other.submitting &&
              err == other.err);

  @override
  int get hashCode =>
      movies.hashCode ^
      loading.hashCode ^
      submitting.hashCode ^
      success.hashCode ^
      err.hashCode;

  HomeState copyWith({
    List<Movie>? movies,
    bool? loading,
    String? err,
    bool? submitting,
    bool? success,
  }) {
    return HomeState(
        movies: movies ?? this.movies,
        loading: loading ?? this.loading,
        err: err,
        success: success,
        submitting: submitting ?? this.submitting);
  }

//</editor-fold>
}

class HomeNotifier extends StateNotifier<HomeState> {
  HomeNotifier(this._apiService) : super(const HomeState());
  final ApiService _apiService;

  void init() async {
    state = state.copyWith(loading: true);

    await _apiService.getList(ApiPaths.baseUrl)
    .then((value) {
      final json = jsonDecode(value);
      var movies = (json as List).map((e) {
        return Movie.fromJson(e);
      }).toList();
      state = state.copyWith(
        err: '',
        movies: movies,
      );
    }).onError((error, stackTrace) {
      print(error);
      print(stackTrace);
      state = state.copyWith(
        err: error.toString(),
      );
    }).whenComplete(() {
      state = state.copyWith(
          loading: false);
    });
  }
}

var homeProvider =
StateNotifierProvider.autoDispose<HomeNotifier, HomeState>((ref) {

  final notifier = HomeNotifier(ApiService());
  notifier.init();

  return notifier;
});
