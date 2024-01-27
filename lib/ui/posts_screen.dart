import 'package:bloc_flutter/bloc/posts/posts_bloc.dart';
import 'package:bloc_flutter/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  @override
  void initState() {
    super.initState();

    context.read<PostsBloc>().add(PostsFetched());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          switch (state.status) {
            case PostStatus.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case PostStatus.failure:
              return Center(
                child: Text(state.message.toString()),
              );
            case PostStatus.success:
              return ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  final item = state.posts[index];
                  return ListTile(
                    title: Text(item.name.toString()),
                    subtitle: Text(item.body.toString()),
                  );
                },
              );
            default:
              return Container();
          }
        },
      ),
    );
  }
}
