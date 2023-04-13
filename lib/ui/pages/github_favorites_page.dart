import 'package:flutter/material.dart';
import 'package:githubapp/ui/widgets/github_user_list_view.dart';
import 'package:provider/provider.dart';

import '../providers/favorite_github_user_provider.dart';

class GithubFavoritesPage extends StatefulWidget {
  const GithubFavoritesPage({Key? key}) : super(key: key);

  @override
  State<GithubFavoritesPage> createState() => _GithubFavoritesPageState();
}

class _GithubFavoritesPageState extends State<GithubFavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Users"),
      ),
      body: Consumer<FavoriteGithubUserProvider>(
        builder: (context, favoriteGithubUserProvider, _) {
          final favorites = favoriteGithubUserProvider.favoriteUsers;
          return SafeArea(child: GithubUserListView(favorites));
        },
      ),
    );
  }

  @override
  void initState() {
    Provider.of<FavoriteGithubUserProvider>(context, listen: false).getFavorites();
    super.initState();
  }
}
