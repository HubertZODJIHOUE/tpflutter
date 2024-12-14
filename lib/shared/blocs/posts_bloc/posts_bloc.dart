// shared/blocs/posts_bloc/posts_bloc.dart
import 'package:bloc/bloc.dart';
import '../../models/post.dart';

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
      try {
        await repository.createPost(event.post);
        add(GetAllPosts()); // Refresh posts
      } catch (e) {
        emit(state.copyWith(status: PostsStatus.error, errorMessage: e.toString()));
      }
    });

    on<UpdatePost>((event, emit) async {
      try {
        await repository.updatePost(event.post);
        add(GetAllPosts()); // Refresh posts
      } catch (e) {
        emit(state.copyWith(status: PostsStatus.error, errorMessage: e.toString()));
      }
    });
  }
}
