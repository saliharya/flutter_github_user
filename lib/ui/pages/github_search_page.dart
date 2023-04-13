import 'dart:async';

import 'package:flutter/material.dart';
import 'package:githubapp/ui/pages/github_favorites_page.dart';
import 'package:githubapp/ui/providers/search_github_users_provider.dart';
import 'package:githubapp/ui/widgets/github_user_list_view.dart';
import 'package:githubapp/util/result_state.dart';
import 'package:provider/provider.dart';

import '../providers/favorite_github_user_provider.dart';

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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ChangeNotifierProvider(
                          create: (context) => FavoriteGithubUserProvider(),
                          child: const GithubFavoritesPage(),
                        );
                      },
                    ),
                  );
                },
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
                            alignment: Alignment.center,
                            child: Text("no data"),
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
                              child: GithubUserListView(
                                searchGithubUserProvider.githubUsers,
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
