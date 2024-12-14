// posts_screen/posts_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../shared/blocs/posts_bloc/posts_bloc.dart';
import '../shared/blocs/posts_bloc/posts_event.dart';
import '../shared/blocs/posts_bloc/posts_state.dart';
import 'widgets/post_list_item.dart';
import 'create_post_screen/create_post_screen.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  @override
  void initState() {
    super.initState();
    // On déclenche la récupération des posts dès le lancement de l'application
    context.read<PostsBloc>().add(GetAllPosts());
  }

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
