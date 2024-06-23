import 'package:flutter/material.dart';
import '../bloc/bloc.dart';
import '../events/events.dart';

class FloatingActionButtons extends StatelessWidget {
  const FloatingActionButtons({super.key, required this.bloc});
  final RemoteBloc bloc;

  @override
  Widget build(BuildContext context) {
    // final bloc = RemoteBloc();
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        FloatingActionButton(
          onPressed: () => bloc.eventController.sink
              .add(IncrementEvent(5)), // add event <=== new
          child: const Icon(Icons.volume_up),
        ),
        FloatingActionButton(
          onPressed: () => bloc.eventController.sink
              .add(DecrementEvent(10)), // add event <=== new
          child: const Icon(Icons.volume_down),
        ),
        FloatingActionButton(
          onPressed: () =>
              bloc.eventController.sink.add(MuteEvent()), // add event <=== new
          child: const Icon(Icons.volume_mute),
        )
      ],
    );
  }
}
