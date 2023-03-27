import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/search_users_response.dart';

class ApiService {
  static const String _baseUrl = "https://api.github.com/";
  static const String _apiKey = "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";
  static Map<String, String> get headers => {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "token $_apiKey",
      };

  Future<SearchUsersResponse> searchUsersResponse(String keyWord) async {
    final response = await http.get(
      Uri.parse("${_baseUrl}search/users?q=$keyWord"),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return SearchUsersResponse.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception("Failed to load users");
    }
  }
}
