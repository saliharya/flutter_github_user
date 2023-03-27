import 'github_user.dart';

class SearchUsersResponse {
  SearchUsersResponse({
    this.totalCount,
    this.incompleteResults,
    this.items,
  });

  final int? totalCount;
  final bool? incompleteResults;
  final List<GithubUser>? items;

  factory SearchUsersResponse.fromJson(Map<String, dynamic> json) =>
      SearchUsersResponse(
        totalCount: json["total_count"],
        incompleteResults: json["incomplete_results"],
        items: json["items"] == null
            ? []
            : List<GithubUser>.from(
                json["items"]!.map((x) => GithubUser.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_count": totalCount,
        "incomplete_results": incompleteResults,
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}
