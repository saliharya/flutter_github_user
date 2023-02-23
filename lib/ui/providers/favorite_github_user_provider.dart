import 'package:flutter/material.dart';

class FavoriteGithubUserProvider extends ChangeNotifier {
  bool _isLiked = false;

  bool get isLiked => _isLiked;

  void setFavorite() {
    _isLiked = !_isLiked;
    notifyListeners();
  }
}
