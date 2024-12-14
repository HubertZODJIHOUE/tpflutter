import 'package:tp/shared/services/posts_data_source/posts_data_source.dart';
import '../../../app_exception.dart';
import '../../models/post.dart';

class FakePostsDataSource extends PostsDataSource {
  /**
   * Liste initiale des posts (constante et immuable)
   */
  final List<Post> _initialFakePosts = [
    Post(id: '1', title: 'Post 1', description: 'Description of Post 1'),
    Post(id: '2', title: 'Post 2', description: 'Description of Post 2'),
    Post(id: '3', title: 'Post 3', description: 'Description of Post 3'),
  ];

  /**
   * Liste mutable pour gérer les modifications
   */
  final List<Post> _mutablePosts = [];

  FakePostsDataSource() {
    _mutablePosts.addAll(_initialFakePosts);
  }

  @override
  Future<List<Post>> getAllPosts() async {
    await Future.delayed(const Duration(seconds: 1));
    return List.unmodifiable(_mutablePosts);
  }

  @override
  Future<Post> createPost(Post postToAdd) async {
    await Future.delayed(const Duration(seconds: 1));
    _mutablePosts.add(postToAdd);
    return postToAdd;
  }

  @override
  Future<Post> updatePost(Post newPost) async {
    await Future.delayed(const Duration(seconds: 1));
    final index = _mutablePosts.indexWhere((post) => post.id == newPost.id);
    if (index != -1) {
      _mutablePosts[index] = newPost;
      return newPost;
    }
    throw AppException('Post not found');
  }

  @override
  Future<void> deletePost(String postId) async {
    await Future.delayed(const Duration(seconds: 1));
    final index = _mutablePosts.indexWhere((post) => post.id == postId);
    if (index != -1) {
      _mutablePosts.removeAt(index);
    } else {
      throw AppException('Post not found');
    }
  }

}
