import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'posts_bloc_event.dart';
part 'posts_bloc_state.dart';

class PostsBlocBloc extends Bloc<PostsBlocEvent, PostsBlocState> {
  PostsBlocBloc() : super(PostsBlocInitial()) {
    on<PostsBlocEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
