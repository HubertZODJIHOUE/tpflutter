// posts_screen/posts_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../shared/blocs/posts_bloc/posts_bloc.dart';
import '../shared/blocs/posts_bloc/posts_event.dart';
import '../shared/blocs/posts_bloc/posts_state.dart';
import '../shared/models/post.dart';
import 'widgets/post_list_item.dart';
import 'create_post_screen/create_post_screen.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des Posts'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CreatePostScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          switch (state.status) {
            case PostsStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case PostsStatus.error:
              return Center(
                child: Text('Erreur : ${state.errorMessage}'),
              );
            case PostsStatus.success:
              if (state.posts.isEmpty) {
                return const Center(child: Text('Aucun post disponible.'));
              }
              return ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  final post = state.posts[index];
                  return PostListItem(post: post);
                },
              );
            default:
              return const Center(child: Text('État initial'));
          }
        },
      ),
    );
  }
}
