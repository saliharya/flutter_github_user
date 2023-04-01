import 'package:flutter/material.dart';
import 'package:githubapp/ui/providers/favorite_github_user_provider.dart';
import 'package:githubapp/ui/providers/github_user_detail_provider.dart';
import 'package:provider/provider.dart';

import '../../data/model/github_user.dart';
import '../widgets/custom_hero_network_image.dart';

class GithubUserDetailPage extends StatefulWidget {
  final GithubUser githubUser;
  const GithubUserDetailPage({
    Key? key,
    required this.githubUser,
  }) : super(key: key);

  @override
  State<GithubUserDetailPage> createState() => _GithubUserDetailPageState();
}

class _GithubUserDetailPageState extends State<GithubUserDetailPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          GithubUserDetailProvider(widget.githubUser.username ?? ""),
      child: Consumer<GithubUserDetailProvider>(
        builder: (context, githubUserDetailProvider, _) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                widget.githubUser.username ?? "",
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
                        child: Text(widget.githubUser.fullName ?? ""),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: Center(
                          child: CustomHeroNetworkImage(
                            imgKey: widget.githubUser.username ?? "",
                            imgUrl: widget.githubUser.avatarUrl ?? "",
                            imageShape: ImageShape.circle,
                            width: 100,
                            height: 100,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.githubUser.username ?? ""),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          "Following: ${githubUserDetailProvider.githubUser?.following ?? 0}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          "Followers: ${githubUserDetailProvider.githubUser?.followers ?? 0}"),
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
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
