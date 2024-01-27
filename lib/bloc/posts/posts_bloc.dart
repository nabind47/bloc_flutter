import 'package:bloc/bloc.dart';
import 'package:bloc_flutter/model/posts_model.dart';
import 'package:bloc_flutter/repository/post_repository.dart';
import 'package:bloc_flutter/utils/enums.dart';
import 'package:equatable/equatable.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostRepository postRepository = PostRepository();

  PostsBloc() : super(const PostsState()) {
    on<PostsFetched>(_fetchPosts);
  }

  void _fetchPosts(PostsFetched event, Emitter<PostsState> emit) async {
    await postRepository.fetchPost().then((value) {
      emit(state.copyWith(status: PostStatus.success, posts: value));
    }).onError((error, stackTrace) {
      emit(state.copyWith(
          status: PostStatus.failure, message: error.toString()));
    });
  }
}
