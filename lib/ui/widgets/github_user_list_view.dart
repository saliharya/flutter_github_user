import 'package:flutter/material.dart';
import 'package:githubapp/data/model/github_user.dart';

import '../pages/github_user_detail_page.dart';
import 'custom_hero_network_image.dart';

class GithubUserListView extends StatelessWidget {
  final List<GithubUser> githubUsers;
  const GithubUserListView(this.githubUsers, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: githubUsers.length,
      itemBuilder: (context, index) {
        final githubUser = githubUsers[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return GithubUserDetailPage(
                        githubUser: githubUser,
                      );
                    },
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CustomHeroNetworkImage(
                      imgKey: githubUser.username ?? "",
                      imgUrl: githubUser.avatarUrl ?? "",
                      imageShape: ImageShape.circle,
                      width: 100,
                      height: 100,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Text(githubUser.username ?? ""),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
