import 'dart:async';

import 'package:flutter/material.dart';
import 'package:githubapp/ui/providers/search_github_users_provider.dart';
import 'package:githubapp/util/result_state.dart';
import 'package:provider/provider.dart';

import '../widgets/custom_hero_network_image.dart';
import 'github_user_detail_page.dart';

class SearchUserPage extends StatefulWidget {
  const SearchUserPage({Key? key, required String title}) : super(key: key);

  @override
  State<SearchUserPage> createState() => _SearchUserPageState();
}

class _SearchUserPageState extends State<SearchUserPage> {
  Timer? _debounce;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SearchGithubUserProvider(),
      child: Consumer<SearchGithubUserProvider>(
          builder: (context, searchGithubUserProvider, _) {
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
            child: SizedBox(
              height: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      onChanged: (text) {
                        if (_debounce?.isActive ?? false) _debounce?.cancel();
                        _debounce =
                            Timer(const Duration(milliseconds: 500), () async {
                          searchGithubUserProvider.searchUsers(text);
                        });
                      },
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
                  (searchGithubUserProvider.resultState == ResultState.noData)
                      ? const Expanded(
                          child: Align(
                            child: Text("no data"),
                            alignment: Alignment.center,
                          ),
                        )
                      : (searchGithubUserProvider.resultState ==
                              ResultState.loading)
                          ? const Expanded(
                              child: Align(
                                alignment: Alignment.center,
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount:
                                    searchGithubUserProvider.githubUsers.length,
                                itemBuilder: (context, index) {
                                  final githubUser = searchGithubUserProvider
                                      .githubUsers[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                      elevation: 8,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
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
                                                imgKey:
                                                    githubUser.username ?? "",
                                                imgUrl:
                                                    githubUser.avatarUrl ?? "",
                                                imageShape: ImageShape.circle,
                                                width: 100,
                                                height: 100,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 12),
                                                child: Text(
                                                    githubUser.username ?? ""),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}
