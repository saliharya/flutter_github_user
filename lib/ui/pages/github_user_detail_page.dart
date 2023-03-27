import 'package:flutter/material.dart';
import 'package:githubapp/ui/providers/favorite_github_user_provider.dart';
import 'package:provider/provider.dart';

import '../../data/model/github_user.dart';
import '../widgets/custom_hero_network_image.dart';

class GithubUserDetailPage extends StatelessWidget {
  final GithubUser githubUser;
  const GithubUserDetailPage({
    Key? key,
    required this.githubUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          githubUser.username ?? "",
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: Text(githubUser.fullName ?? ""),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: SizedBox(
                  width: 150,
                  height: 150,
                  child: Center(
                    child: CustomHeroNetworkImage(
                      imgKey: githubUser.username ?? "",
                      imgUrl: githubUser.avatarUrl ?? "",
                      imageShape: ImageShape.circle,
                      width: 150,
                      height: 150,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: ChangeNotifierProvider(
        create: (context) => FavoriteGithubUserProvider(),
        child: Consumer<FavoriteGithubUserProvider>(
          builder: (
            context,
            favoriteGithubUserProvider,
            widget,
          ) {
            return FloatingActionButton(
              onPressed: favoriteGithubUserProvider.setFavorite,
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Icon(
                Icons.heart_broken,
                color: favoriteGithubUserProvider.isLiked
                    ? Colors.red
                    : Colors.white,
              ),
            );
          },
        ),
      ),
    );
  }
}
