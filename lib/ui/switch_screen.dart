import 'package:bloc_flutter/bloc/switch/switch.states.dart';
import 'package:bloc_flutter/bloc/switch/switch_bloc.dart';
import 'package:bloc_flutter/bloc/switch/switch_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SwitchScreen extends StatefulWidget {
  const SwitchScreen({super.key});

  @override
  State<SwitchScreen> createState() => _SwitchScreenState();
}

class _SwitchScreenState extends State<SwitchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Notification"),
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
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              height: 200,
              color: Colors.red.withOpacity(.2),
            ),
            const SizedBox(
              height: 30,
            ),
            Slider(
              value: .4,
              onChanged: (value) {},
            )
            // Slider(value: 4, onChanged: (newValue) {})
          ],
        ),
      ),
    );
  }
}
