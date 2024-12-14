// shared/blocs/posts_bloc/posts_event.dart
import '../../models/post.dart';

abstract class PostsEvent {}

class GetAllPosts extends PostsEvent {}

class CreatePost extends PostsEvent {
  final Post post;
  CreatePost(this.post);
}

class UpdatePost extends PostsEvent {
  final Post post;
  UpdatePost(this.post);
}
