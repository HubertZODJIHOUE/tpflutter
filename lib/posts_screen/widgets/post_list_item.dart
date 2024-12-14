import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/models/post.dart';
import '../../shared/blocs/posts_bloc/posts_bloc.dart';
import '../../shared/blocs/posts_bloc/posts_event.dart';
import '../post_detail_screen/post_detail_screen.dart';

class PostListItem extends StatelessWidget {
  final Post post;

  const PostListItem({super.key, required this.post});

  void _onDeletePost(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Supprimer le Post'),
        content: const Text('Êtes-vous sûr de vouloir supprimer ce post ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              context.read<PostsBloc>().add(DeletePost(post.id));
              Navigator.pop(ctx);
            },
            child: const Text('Supprimer', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return
       ListTile(
        title: Text(
          post.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            post.description,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PostDetailScreen(post: post),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _onDeletePost(context),
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PostDetailScreen(post: post),
            ),
          );
        },

    );
  }
}
