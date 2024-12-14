
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

class DeletePost extends PostsEvent {
  final String postId;

  DeletePost(this.postId);

  @override
  List<Object> get props => [postId];
}
