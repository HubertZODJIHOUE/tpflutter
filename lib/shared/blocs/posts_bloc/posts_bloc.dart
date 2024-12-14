
import 'package:bloc/bloc.dart';
import '../../services/services/repository/posts_repository.dart';
import 'posts_event.dart';
import 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostsRepository repository;

  PostsBloc({required this.repository}) : super(const PostsState()) {

    on<GetAllPosts>((event, emit) async {
      emit(state.copyWith(status: PostsStatus.loading));
      try {
        final posts = await repository.getAllPosts();
        emit(state.copyWith(status: PostsStatus.success, posts: posts));
      } catch (e) {
        emit(state.copyWith(status: PostsStatus.error, errorMessage: e.toString()));
      }
    });


    on<CreatePost>((event, emit) async {
      emit(state.copyWith(status: PostsStatus.loading));
      try {
        await repository.createPost(event.post);
        final updatedPosts = List.of(state.posts)..add(event.post);
        emit(state.copyWith(status: PostsStatus.success, posts: updatedPosts));
      } catch (e) {
        emit(state.copyWith(status: PostsStatus.error, errorMessage: e.toString()));
      }
    });


    on<UpdatePost>((event, emit) async {
      emit(state.copyWith(status: PostsStatus.loading));
      try {
        await repository.updatePost(event.post);
        final updatedPosts = state.posts.map((post) {
          return post.id == event.post.id ? event.post : post;
        }).toList();
        emit(state.copyWith(status: PostsStatus.success, posts: updatedPosts));
      } catch (e) {
        emit(state.copyWith(status: PostsStatus.error, errorMessage: e.toString()));
      }
    });


    on<DeletePost>((event, emit) async {
      emit(state.copyWith(status: PostsStatus.loading));
      try {
        await repository.deletePost(event.postId);
        final updatedPosts = state.posts.where((post) => post.id != event.postId).toList();
        emit(state.copyWith(status: PostsStatus.success, posts: updatedPosts));
      } catch (e) {
        emit(state.copyWith(status: PostsStatus.error, errorMessage: e.toString()));
      }
    });
  }
}
