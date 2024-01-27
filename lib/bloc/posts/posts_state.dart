part of 'posts_bloc.dart';

class PostsState extends Equatable {
  final PostStatus status;
  final List<PostModel> posts;
  final String message;

  const PostsState(
      {this.status = PostStatus.loading,
      this.posts = const <PostModel>[],
      this.message = ""});

  PostsState copyWith(
      {PostStatus? status, List<PostModel>? posts, String? message}) {
    return PostsState(
        status: status ?? this.status,
        posts: posts ?? this.posts,
        message: message ?? this.message);
  }

  @override
  List<Object> get props => [status, posts, message];
}

final class PostsInitial extends PostsState {}
