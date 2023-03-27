class GithubUser {
  GithubUser({
    this.id,
    this.avatarUrl,
    this.reposUrl,
    this.username,
    this.fullName,
    this.company,
    this.blog,
    this.location,
    this.email,
    this.bio,
    this.publicRepos,
    this.publicGists,
    this.followers,
    this.following,
  });

  final int? id;
  final String? avatarUrl;
  final String? reposUrl;
  final String? username;
  final String? fullName;
  final String? company;
  final String? blog;
  final String? location;
  final String? email;
  final String? bio;
  final int? publicRepos;
  final int? publicGists;
  final int? followers;
  final int? following;

  factory GithubUser.fromJson(Map<String, dynamic> json) => GithubUser(
        id: json["id"],
        avatarUrl: json["avatar_url"],
        reposUrl: json["repos_url"],
        username: json["login"],
        fullName: json["name"],
        company: json["company"],
        blog: json["blog"],
        location: json["location"],
        email: json["email"],
        bio: json["bio"],
        publicRepos: json["public_repos"],
        publicGists: json["public_gists"],
        followers: json["followers"],
        following: json["following"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "avatar_url": avatarUrl,
        "repos_url": reposUrl,
        "login": username,
        "name": fullName,
        "company": company,
        "blog": blog,
        "location": location,
        "email": email,
        "bio": bio,
        "public_repos": publicRepos,
        "public_gists": publicGists,
        "followers": followers,
        "following": following,
      };
}

List<GithubUser> dummyGithubUsers = [
  GithubUser(
    username: "sidiqpermana",
    avatarUrl: "https://avatars.githubusercontent.com/u/4090245?v=4",
  ),
];
