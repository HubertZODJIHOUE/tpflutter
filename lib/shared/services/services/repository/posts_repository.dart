import '../../../models/post.dart';
import '../../posts_data_source/posts_data_source.dart';

class PostsRepository {
  final PostsDataSource dataSource;

  PostsRepository(this.dataSource);

  Future<List<Post>> getAllPosts() => dataSource.getAllPosts();
  Future<Post> createPost(Post postToAdd) => dataSource.createPost(postToAdd);
  Future<Post> updatePost(Post newPost) => dataSource.updatePost(newPost);
  Future<void> deletePost(String postId) => dataSource.deletePost(postId);
}