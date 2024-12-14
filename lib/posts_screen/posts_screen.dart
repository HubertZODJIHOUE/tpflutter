
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../shared/blocs/posts_bloc/posts_bloc.dart';
import '../shared/blocs/posts_bloc/posts_event.dart';
import '../shared/blocs/posts_bloc/posts_state.dart';
import '../shared/styles/app_colors.dart';
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
    context.read<PostsBloc>().add(GetAllPosts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des Posts'),
        centerTitle: true,
        backgroundColor: AppColors.primary,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CreatePostScreen()),
          );
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: AppColors.textPrimary),
      ),
      body: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          switch (state.status) {
            case PostsStatus.loading:
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );

            case PostsStatus.error:
              return _buildErrorScreen(context, state.errorMessage);

            case PostsStatus.success:
              if (state.posts.isEmpty) {
                return const Center(
                  child: Text(
                    'Aucun post disponible.',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                );
              }
              return _buildPostsList(state.posts);

            default:
              return const Center(
                child: Text(
                  'État initial.',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              );
          }
        },
      ),
    );
  }

  Widget _buildErrorScreen(BuildContext context, String? errorMessage) {
    return Center(
      child: AlertDialog(
        title: const Text(
          'Erreur',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text(
          errorMessage ?? 'Une erreur inconnue est survenue.',
          style: const TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () {

              context.read<PostsBloc>().add(GetAllPosts());
            },
            child: const Text('OK', style: TextStyle(color: AppColors.primary)),
          ),
        ],
      ),
    );
  }

  Widget _buildPostsList(List posts) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: PostListItem(post: post),
          );
        },
      ),
    );
  }
}
