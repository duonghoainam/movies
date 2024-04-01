import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies/core/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsInstance {
  final prefs = locator<SharedPreferences>();

  List<String> get listFavorites {
    var user = FirebaseAuth.instance.currentUser;

    if (user == null || user.email == null || user.email!.isEmpty) {
      return [];
    } else {
      final jsonString = prefs.getString(user.email!) ?? '[]';
      return List<String>.from(jsonDecode(jsonString));
    }
  }

  Future<bool> addFavorite(String movieId) async {
    var user = FirebaseAuth.instance.currentUser;

    if (user == null || user.email == null || user.email!.isEmpty) {
      return false;
    } else {
      final List<String> favorites = listFavorites;
      favorites.add(movieId);
      return await prefs!.setString(user.email!, jsonEncode(favorites));
    }
  }

  Future<bool> removeFavorites(String movieId) async {
    var user = FirebaseAuth.instance.currentUser;

    if (user == null || user.email == null || user.email!.isEmpty) {
      return false;
    } else {
      List<String> favorites = listFavorites;
      favorites.remove(movieId);
      return await prefs!.setString(user.email!, jsonEncode(favorites));
    }
  }

  Future<bool> checkFavorites(String movieId) async {
    var user = FirebaseAuth.instance.currentUser;

    if (user == null || user.email == '' || user.email == null) {
      return false;
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print(user.email);
      String? jsonString = prefs.getString(user.email!);
      if (jsonString != null) {
        List<String> favorites = jsonDecode(jsonString).cast<String>();
        print(favorites);
        return favorites.contains(movieId);
      } else {
        return false;
      }
    }
  }
}
