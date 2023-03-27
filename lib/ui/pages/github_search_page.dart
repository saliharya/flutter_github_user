import 'package:flutter/material.dart';

import '../../data/model/github_user.dart';
import '../widgets/custom_hero_network_image.dart';
import 'github_user_detail_page.dart';

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
                itemCount: dummyGithubUsers.length,
                itemBuilder: _buildGithubUserListWidget,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGithubUserListWidget(BuildContext context, int index) {
    final githubUser = dummyGithubUsers[index];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: InkWell(
          onTap: () {
            // onTap: () async {
            //   var users = await ApiService().searchUsersResponse("saliharya");
            //   debugPrint(users.toJson().toString());
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
  }
}
