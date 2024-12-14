// posts_screen/widgets/post_list_item.dart
import 'package:flutter/material.dart';
import '../../shared/models/post.dart';
import '../post_detail_screen/post_detail_screen.dart';

class PostListItem extends StatelessWidget {
  final Post post;

  const PostListItem({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(post.title),
      subtitle: Text(post.description),
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
