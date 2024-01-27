import 'package:bloc_flutter/bloc/counter/counter_bloc.dart';
import 'package:bloc_flutter/bloc/favourite/favourite_bloc.dart';
import 'package:bloc_flutter/bloc/image_picker/image_picker_bloc.dart';
import 'package:bloc_flutter/bloc/posts/posts_bloc.dart';
import 'package:bloc_flutter/bloc/switch/switch_bloc.dart';
import 'package:bloc_flutter/bloc/todo/to_do_bloc.dart';
import 'package:bloc_flutter/repository/favourite_repository.dart';
import 'package:bloc_flutter/ui/posts_screen.dart';
import 'package:bloc_flutter/utils/image_picker_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CounterBloc()),
        BlocProvider(create: (_) => SwitchBloc()),
        BlocProvider(create: (_) => ToDoBloc()),
        BlocProvider(create: (_) => ImagePickerBloc(ImagePickerUtils())),
        BlocProvider(create: (_) => FavouriteBloc(FavouriteRepository())),
        BlocProvider(create: (_) => PostsBloc()),
      ],
      child: MaterialApp(
        title: 'Flutter Bloc',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        theme: ThemeData(
          brightness: Brightness.dark,
          useMaterial3: true,
        ),
        home: const PostsScreen(),
      ),
    );
  }
}
