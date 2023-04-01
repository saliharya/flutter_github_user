import 'dart:io';

import 'package:flutter/material.dart';
import 'package:githubapp/util/list_ext.dart';

import '../../data/model/github_user.dart';
import '../../data/remote/api_service.dart';
import '../../util/result_state.dart';

class UserFollowersProvider extends ChangeNotifier {
  final String username;

  UserFollowersProvider(this.username) {
    getUserFollowers(username);
  }

  ApiService apiService = ApiService();
  ResultState _resultState = ResultState.noData;
  ResultState get resultState => _resultState;
  String _messages = "";
  String get messages => _messages;

  List<GithubUser> _githubUsers = [];
  List<GithubUser> get githubUsers => _githubUsers;

  Future<dynamic> getUserFollowers(String username) async {
    _resultState = ResultState.loading;
    notifyListeners();
    try {
      final response = await apiService.getUserFollowers(username);
      final users = response.orEmpty();
      if (users.isEmpty) {
        _resultState = ResultState.noData;
      } else {
        _resultState = ResultState.hasData;
      }
      notifyListeners();
      return _githubUsers = users;
    } on SocketException {
      _resultState = ResultState.error;
      notifyListeners();
      return _messages = "unable to connect";
    } catch (e) {
      _resultState = ResultState.error;
      notifyListeners();
      return _messages = e.toString();
    }
  }
}
