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
                context.read<SwitchBloc>().add(EnableOrDisableNotification());
            });
    },
)
```
