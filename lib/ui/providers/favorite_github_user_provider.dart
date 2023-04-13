import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:githubapp/data/local/shared_preference.dart';
import 'package:githubapp/data/local/shared_preference_key.dart';
import 'package:collection/collection.dart';

import '../../data/model/github_user.dart';

class FavoriteGithubUserProvider extends ChangeNotifier {
  FavoriteGithubUserProvider({GithubUser? githubUser}) {
    if (githubUser != null) {
      isFavorite(githubUser);
    }
  }

  final pref = SharedPreference();

  bool _isLiked = false;

  bool get isLiked => _isLiked;

  List<GithubUser> _favoriteUsers = [];

  List<GithubUser> get favoriteUsers => _favoriteUsers;

  Future<List<GithubUser>> getFavorites() async {
    final jsonArray = json.decode(
            await pref.getString(SharedPreferenceKey.FAVORITE_USERS) ?? "[]")
        as List;
    final favorites = jsonArray.map((e) => GithubUser.fromJson(e)).toList();
    _favoriteUsers = favorites;
    notifyListeners();
    return favorites;
  }

  Future<void> setFavorite(GithubUser githubUser) async {
    final githubUsers = await getFavorites();
    final isFavorite = githubUsers
            .firstWhereOrNull((element) => element.id == githubUser.id) !=
        null;

    if (isFavorite) {
      githubUsers.removeWhere((element) => element.id == githubUser.id);
    } else {
      githubUsers.add(githubUser);
    }

    _isLiked = !isFavorite;

    final jsonArray = jsonEncode(githubUsers);
    pref.setString(SharedPreferenceKey.FAVORITE_USERS, jsonArray);

    notifyListeners();
  }

  Future<bool> isFavorite(GithubUser githubUser) async {
    final githubUsers = await getFavorites();
    final isFavorite = githubUsers
            .firstWhereOrNull((element) => element.id == githubUser.id) !=
        null;
    _isLiked = isFavorite;
    notifyListeners();
    return isFavorite;
  }
}
