```sh
flutter create --platforms android,ios bloc_flutter
```

## [Flutter Equatable Package](https://pub.dev/packages/equatable)

The `equatable` package in Flutter is a powerful tool for `comparing objects`. It allows developers to easily determine if two objects have the `same properties and values`, which can be especially useful when working with complex data structures or implementing value types in their Flutter apps.

```dart
import 'package:equatable/equatable.dart';

class Person extends Equatable {
  final String name;
  final int age;

  Person({required this.name, required this.age});

  @override
  List<Object> get props => [name, age];
}
```

> The `Person` class extends `Equatable` and `implements` the props `getter`. The props `getter` is used to specify which properties of the object should be used to determine `equality`. In this case, the name and age properties of two Person objects are being compared.

```dart
final person1 = Person(name: 'John', age: 30);
final person2 = Person(name: 'John', age: 30);

print(person1 == person2); // true
print(Equatable.is(person1, person2)); // true
```

> Alternatively, you can use the `isEquals` method to compare two instances of your custom value type.

```dart
final people1 = [
  Person(name: 'John', age: 30),
  Person(name: 'Mike', age: 25),
];

final people2 = [
  Person(name: 'John', age: 30),
  Person(name: 'Mike', age: 25),
];

print(Equatable.listEquals(people1, people2)); // true
```

> You can also use equatable package to compare a `list` of objects. The `equatable` package uses the `==` operator and the `hashCode` method to determine equality between objects. When the `==` operator is called on two objects, `equatable` compares the values of the properties specified in the props `getter` to determine if they are equal. If the props getter is not implemented or is empty, equatable will use the hashCode method to compare the objects.It’s important to note that **`equatable` only `compares` the properties that you specify in the props `getter`**.

## [Business Logic Component (BLoC) Pattern]()

BLoC is popular in the Flutter community because of its separation of concerns, responsiveness, testability and scalability. However, it may require more boilerplate code than other state management approaches and has a steeper learning curve. There are several core concepts to understand when using BLoC in Flutter:

![bloc_arch](/images/bloc_arch.webp)

- **Events**: events signify user activities or other actions that can alter the application’s state. Events are typically represented as simple data classes.
- **Bloc**: a Bloc is a class that takes in events, processes them, and produces a new state. It is in charge of controlling the application’s state and responding to user input.
- **State**: state represents the current state of the application. It is typically represented as an immutable data class.
- **Stream**: a stream is a collection of asynchronous events that may be monitored for modifications. In the context of BLoC, Streams are used in BLoC to describe the application’s state at any given time.
- **Sink**: a Sink is a Stream controller that can be used to send events to a stream. In the context of BLoC, a Sink is used to send events to the Bloc for processing.
- **StreamController**: StreamController is used to construct and manage streams. In the context of BLoC, a StreamController is used to manage the stream(s) of events that are sent to the Bloc.
- **BlocBuilder**: BlocBuilder is a widget provided by the flutter_bloc package that helps to connect the Bloc to the user interface. It listens to changes in the state of the Bloc and rebuilds the UI accordingly.
- **BlocProvider**: The flutter_bloc package has a widget called BlocProvider that adds a Bloc to the widget tree. It ensures that the Bloc is created only once and is accessible to all the widgets in the subtree.

### Creating an Event

```dart
@immutable
abstract class AppBlocEvent {
 const AppBlocEvent();
}

@immutable
class ChangeTextEvent extends AppBlocEvent {
 const ChangeTextEvent();
}
```

> We have an `abstract` AppBlocEvent class because Bloc expects a single event to be added to the stream. Still, as there can be multiple events in an app, we create an abstract class and extend it whenever we want to create any new event for handling and passing multiple events to the bloc.

### Creating State

```dart
@immutable
class AppState extends Equatable {
 final int index;
 final String text;

 const AppState.empty()
     : index = 0,
       text = 'Initial Text';

 const AppState({
   required this.index,
   required this.text,
 });

 @override
 List<Object> get props => [index, text];
}
```

### Event and State Management using BLoC Pattern

```dart
class AppBlocBloc extends Bloc {
 final List textList = [
   'Initial Text',
   'Changed Text',
   'Changed Again',
 ];
 AppBlocBloc() : super(const AppState.empty()) {
   on((event, emit) {
     try {
       int newIndex = state.index + 1;
       if(newIndex >= textList.length) {
         newIndex = 0;
       }
       emit(
         AppState(
           index: newIndex,
           text: textList[newIndex],
         ),
       );
     } on Exception catch (e) {
       print(e);
     }
   });
 }
}
```

> This is the part that contains the `business logic` of our application. `on` is executed when `ChangeTextEvent` is added to the stream via a button click , it receives the `event`, i.e., any information that you want to pass along with triggering event you can access it using this(like `event.any_info` – you have to change your event class accordingly), `emit` which is used to emit a state for that particular event.

### [Providing our BLoC]()

```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_change/text_controller.dart';

import 'bloc/app_bloc_bloc.dart';
import 'bloc/app_bloc_state.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => AppBlocBloc(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Text Change'),
          ),
          body: BlocConsumer(
            listener: (context, state) {},
            builder: (context, state) {
              return TextController(
                text: state.text,
              );
            },
          ),
        ),
      ),
    );
  }
}
```

> `BlocProvider(…)` is to `provide` an instance of our `bloc` by placing it just below the root of the application so that it is accessible throughout it. `create` creates the instance of our `AppBloBloc`.<br /> `BlocConsumer(…)` is the area where everything happens. It has a property called `listener`, which listens for `state changes` and can `react` in a particular way to a specific state along with state change and `builder` is responsible for building the UI and is `rebuilt for each state change`. `BlocConsumer` also contains `listenWhen` and `buildWhen`, which as the name states, can be tailored to react to specified states.

### Triggering the Event and States

```dart
class TextChangeController extends StatelessWidget {
final String text;

const TextChangeController({Key? key, required this.text}) : super(key: key);

@override
Widget build (BuildContext context) {
      return Column
         children:  [
            TextChange(
               text: text,
            ),
           ElevatedButton(
               onPressed: () =>
                    context.read().add(const ChangeTextEvent()),
              child: const Text('Change Text'),
         ),
      ),
   );
  )
)
```

> Here we have added `ChangeTextEvent` onto the event stream, thereby triggering state change which causes the `rebuild` of the `builder()` in `BlocConsumer`, and changed text is displayed up on the screen.
