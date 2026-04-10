
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/post_viewmodel.dart';
import '../widgets/post_tile.dart';
import 'detail_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<PostViewModel>(context, listen: false).fetchPosts());
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<PostViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Posts")),
      body: Builder(
        builder: (_) {
          if (vm.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (vm.error.isNotEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(vm.error),
                  ElevatedButton(
                    onPressed: vm.fetchPosts,
                    child: const Text("Retry"),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: vm.posts.length,
            itemBuilder: (context, index) {
              final post = vm.posts[index];

              return PostTile(
                post: post,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailView(post: post),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
