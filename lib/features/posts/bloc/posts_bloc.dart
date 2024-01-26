import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_flutter/features/posts/models/posts_model.dart';
import 'package:bloc_flutter/features/posts/repos/posts_repo.dart';
import 'package:meta/meta.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitial()) {
    on<PostsInitialFetchEvent>(postsInitialFetchEvent);
    on<PostAddEvent>(postAddEvent);
  }

  FutureOr<void> postsInitialFetchEvent(
      PostsInitialFetchEvent event, Emitter<PostsState> emit) async {
    emit(PostsFetchingLoadingState());

    List<PostsModel> posts = await PostsRepo.fetchPosts();

    emit(PostsFetchingSuccessfulState(posts: posts));
  }

  FutureOr<void> postAddEvent(
      PostAddEvent event, Emitter<PostsState> emit) async {
    bool success = await PostsRepo.addPost();

    if (success) {
      emit(PostsAdditonSuccessState());
    } else {
      emit(PostsAdditonErrorState());
    }
  }
}
