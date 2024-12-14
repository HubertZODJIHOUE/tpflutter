
import '../../models/post.dart';

enum PostsStatus { initial, loading, success, error }

class PostsState {
  final PostsStatus status;
  final List<Post> posts;
  final String? errorMessage;

  const PostsState({
    this.status = PostsStatus.initial,
    this.posts = const [],
    this.errorMessage,
  });

  PostsState copyWith({
    PostsStatus? status,
    List<Post>? posts,
    String? errorMessage,
  }) {
    return PostsState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
