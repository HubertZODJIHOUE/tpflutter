// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp/shared/services/services/repository/posts_repository.dart';
import 'shared/blocs/posts_bloc/posts_bloc.dart';
import 'shared/services/posts_data_source/fake_posts_data_source.dart';

import 'posts_screen/posts_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => PostsRepository(FakePostsDataSource()),
      child: BlocProvider(
        create: (context) =>
            PostsBloc(repository: context.read<PostsRepository>()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const PostsScreen(),
        ),
      ),
    );
  }
}
