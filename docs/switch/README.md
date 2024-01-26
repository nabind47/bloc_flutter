```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterBloc(),
      child: BlocProvider(
        create: (context) => SwitchBloc(),
        child: MaterialApp(
          title: 'Flutter Bloc',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const SwitchScreen(),
        ),
      ),
    );
  }
}
```

```dart
BlocBuilder<SwitchBloc, SwitchStates>(
  builder: (context, state) {
    return Switch(
      value: state.isSwitch,
      onChanged: (newValue) {
        context
          .read<SwitchBloc>()
          .add(EnableOrDisableNotification());
      });
  },
)
```

```dart
class SwitchBloc extends Bloc<SwitchEvents, SwitchStates> {
  SwitchBloc() : super(SwitchStates()) {
    on<EnableOrDisableNotification>(_enableOrDisableNotification);
    on<SliderEvent>(_slider);
  }

  void _enableOrDisableNotification(
      EnableOrDisableNotification event, Emitter<SwitchStates> emit) {
    emit(state.copyWith(isSwitch: !state.isSwitch));
  }

  void _slider(SliderEvent event, Emitter<SwitchStates> emit) {
    emit(state.copyWith(slider: event.slider));
  }
}
```

> `event.slider`

```dart
import 'package:equatable/equatable.dart';

class SwitchStates extends Equatable {
  bool isSwitch;
  double slider;

  SwitchStates({this.isSwitch = false, this.slider = .4});

  SwitchStates copyWith({bool? isSwitch, double? slider}) {
    return SwitchStates(
        isSwitch: isSwitch ?? this.isSwitch, slider: slider ?? this.slider);
  }

  @override
  List<Object?> get props => [isSwitch, slider];
}
```

```dart
import 'package:bloc_flutter/bloc/switch/switch.states.dart';
import 'package:bloc_flutter/bloc/switch/switch_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SwitchBloc extends Bloc<SwitchEvents, SwitchStates> {
  SwitchBloc() : super(SwitchStates()) {
    on<EnableOrDisableNotification>(_enableOrDisableNotification);
    on<SliderEvent>(_slider);
  }

  void _enableOrDisableNotification(
      EnableOrDisableNotification event, Emitter<SwitchStates> emit) {
    emit(state.copyWith(isSwitch: !state.isSwitch));
  }

  void _slider(SliderEvent event, Emitter<SwitchStates> emit) {
    emit(state.copyWith(slider: event.slider));
  }
}
```

```dart
BlocBuilder<SwitchBloc, SwitchStates>(
  builder: (context, state) {
    return Container(height: 200,color: Colors.red.withOpacity(state.slider));
  },),

BlocBuilder<SwitchBloc, SwitchStates>(
  builder: (context, state) {
    return Slider(
      value: state.slider,
      onChanged: (value) {
        context.
          read<SwitchBloc>().
          add(SliderEvent(slider: value));
        },
    );
  },
)
```

```dart
buildWhen: (previous, current) => previous.isSwitch != current.isSwitch,
```

> **_Only rebuild the widget if it is changed_**

```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CounterBloc(),
        ),
        BlocProvider(
          create: (_) => SwitchBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Bloc',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SwitchScreen(),
      ),
    );
  }
}
```
