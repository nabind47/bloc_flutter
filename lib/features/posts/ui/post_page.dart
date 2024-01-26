import 'package:bloc_flutter/features/posts/bloc/posts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final PostsBloc postsBloc = PostsBloc();

  @override
  void initState() {
    postsBloc.add(PostsInitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Posts"),
      ),
      body: BlocConsumer<PostsBloc, PostsState>(
        bloc: postsBloc,
        listenWhen: (previous, current) => current is PostsActionState,
        buildWhen: (previous, current) => current is! PostsActionState,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case PostsFetchingLoadingState:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case PostsFetchingSuccessfulState:
              final successState = state as PostsFetchingSuccessfulState;

              return ListView.builder(
                itemCount: successState.posts.length,
                itemBuilder: (context, index) {
                  return Container(
                    color: Colors.grey.shade200,
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(successState.posts[index].title),
                      ],
                    ),
                  );
                },
              );
            default:
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          postsBloc.add(PostAddEvent());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
