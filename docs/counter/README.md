```dart
import 'package:equatable/equatable.dart';

abstract class CounterEvent extends Equatable {
  const CounterEvent();

  @override
  List<Object> get props => [];
}

class IncrementCounter extends CounterEvent {}

class DecrementCounter extends CounterEvent {}
```

```dart
import 'package:equatable/equatable.dart';

class CounterState extends Equatable {
  final int counter;

  const CounterState({this.counter = 0});

  CounterState copyWith({int? counter}) {
    return CounterState(counter: counter ?? this.counter);
  }

  @override
  List<Object?> get props => [counter];
}
```

```dart
import 'package:bloc/bloc.dart';
import 'package:bloc_flutter/bloc/counter/counter_event.dart';
import 'package:bloc_flutter/bloc/counter/counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterState()) {
    on<IncrementCounter>(_increment);
    on<DecrementCounter>(_decrement);
  }

  void _increment(IncrementCounter event, Emitter<CounterState> emit) {
    emit(state.copyWith(counter: state.counter + 1));
  }

  void _decrement(DecrementCounter event, Emitter<CounterState> emit) {
    emit(state.copyWith(counter: state.counter + 1));
  }
}
```

```dart
import 'package:bloc_flutter/bloc/counter/counter_bloc.dart';
import 'package:bloc_flutter/ui/counter_screen.dart';
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
    return BlocProvider(
      create: (_) => CounterBloc(),
      child: MaterialApp(
        title: 'Flutter Bloc',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const CounterScreen(),
      ),
    );
  }
}
```

```dart
BlocBuilder<CounterBloc, CounterState>(
    builder: (context, state) {
        return Center( child: Text(state.counter.toString(), style: const TextStyle(fontSize: 40)));
    },
),
```

```dart
ElevatedButton(
    onPressed: () {
        context.read<CounterBloc>().add(IncrementCounter())
    },
    child: const Text("Increment")
),
ElevatedButton(
    onPressed: () {
        context.read<CounterBloc>().add(DecrementCounter())
    },
    child: const Text("Decrement")
),
```
