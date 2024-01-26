part of 'posts_bloc.dart';

@immutable
abstract class PostsState {}

abstract class PostsActionState extends PostsState {}

class PostsInitial extends PostsState {}

class PostsFetchingLoadingState extends PostsState {}

class PostsFetchingSuccessfulState extends PostsState {
  final List<PostsModel> posts;

  PostsFetchingSuccessfulState({required this.posts});
}

class PostsAdditonSuccessState extends PostsActionState {}

class PostsAdditonErrorState extends PostsActionState {}
