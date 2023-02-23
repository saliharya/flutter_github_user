import 'package:flutter/material.dart';
import 'package:githubapp/ui/pages/github_user_detail_page.dart';
import 'package:githubapp/ui/widgets/custom_hero_network_image.dart';

import '../../data/model/github_user.dart';

class SearchUserPage extends StatelessWidget {
  const SearchUserPage({Key? key, required String title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Github Search User"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    hintText: "Github Username",
                    fillColor: Colors.white70,
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: githubUsers.length,
                itemBuilder: _buildGithubUserListWidget,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGithubUserListWidget(BuildContext context, int index) {
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
                  imgUrl: githubUser.imgUrl ?? "",
                  imageShape: ImageShape.circle,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(githubUser.username ?? ""),
                    Text(githubUser.fullName ?? ""),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
