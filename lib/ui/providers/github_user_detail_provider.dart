import 'dart:io';

import 'package:flutter/material.dart';
import 'package:githubapp/data/remote/api_service.dart';
import 'package:githubapp/util/result_state.dart';

import '../../data/model/github_user.dart';

class GithubUserDetailProvider extends ChangeNotifier {
  final String username;

  GithubUserDetailProvider(this.username) {
    getUserDetail(username);
  }

  ApiService apiService = ApiService();
  ResultState _resultState = ResultState.noData;
  ResultState get resultState => _resultState;
  String _messages = "";
  String get messages => _messages;

  GithubUser? _githubUser = null;
  GithubUser? get githubUser => _githubUser;

  Future<dynamic> getUserDetail(String username) async {
    _resultState = ResultState.loading;
    notifyListeners();
    try {
      final response = await apiService.getUserDetail(username);
      if (response == null) {
        _resultState = ResultState.noData;
      } else {
        _resultState = ResultState.hasData;
      }
      notifyListeners();
      return _githubUser = response;
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
