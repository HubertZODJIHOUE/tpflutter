import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/services/repository/posts_repository.dart';
import 'posts_event.dart';
import 'posts_state.dart';


class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostsRepository repository;

  PostsBloc(this.repository) : super(PostsLoading()) {
    on<LoadPosts>((event, emit) async {
      emit(PostsLoading());
      try {
        final posts = await repository.getAllPosts();
        emit(PostsLoaded(posts));
      } catch (e) {
        emit(PostsError(e.toString()));
      }
    });

    on<CreatePost>((event, emit) async {
      try {
        await repository.createPost(event.post);
        add(LoadPosts());
      } catch (e) {
        emit(PostsError(e.toString()));
      }
    });

    on<UpdatePost>((event, emit) async {
      try {
        await repository.updatePost(event.post);
        add(LoadPosts());
      } catch (e) {
        emit(PostsError(e.toString()));
      }
    });
  }
}
