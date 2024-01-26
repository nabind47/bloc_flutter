import 'package:bloc_flutter/bloc/counter/counter_bloc.dart';
import 'package:bloc_flutter/bloc/image_picker/image_picker_bloc.dart';
import 'package:bloc_flutter/bloc/switch/switch_bloc.dart';
import 'package:bloc_flutter/ui/image_picker_screen.dart';
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
        BlocProvider(create: (_) => ImagePickerBloc(ImagePickerUtils())),
      ],
      child: MaterialApp(
        title: 'Flutter Bloc',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const ImagePickerScreen(),
      ),
    );
  }
}
