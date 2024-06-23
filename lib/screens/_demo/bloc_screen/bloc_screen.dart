import 'package:flutter/material.dart';
import 'bloc/bloc.dart';
import 'components/floating_action_buttons.dart';
import 'states/states.dart';

class BlocScreen extends StatefulWidget {
  const BlocScreen({super.key, required this.title});

  final String title;

  @override
  _BlocScreenState createState() => _BlocScreenState();
}

class _BlocScreenState extends State<BlocScreen> {
  final bloc = RemoteBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<RemoteState>(
          // sử dụng StreamBuilder để lắng nghe Stream <=== new
          stream: bloc.stateController
              .stream, // truyền stream của stateController vào để lắng nghe <=== new
          initialData: bloc
              .state, // giá trị khởi tạo chính là volume 70 hiện tại <=== new
          builder: (BuildContext context, AsyncSnapshot<RemoteState> snapshot) {
            return Text(
                'Âm lượng hiện tại: ${snapshot.data?.volume}'); // update UI <=== new
          },
        ),
      ),
      floatingActionButton: FloatingActionButtons(bloc: bloc),
      // floatingActionButton: Row(
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   children: <Widget>[
      //     FloatingActionButton(
      //       onPressed: () => bloc.eventController.sink
      //           .add(IncrementEvent(5)), // add event <=== new
      //       child: Icon(Icons.volume_up),
      //     ),
      //     FloatingActionButton(
      //       onPressed: () => bloc.eventController.sink
      //           .add(DecrementEvent(10)), // add event <=== new
      //       child: Icon(Icons.volume_down),
      //     ),
      //     FloatingActionButton(
      //       onPressed: () => bloc.eventController.sink
      //           .add(MuteEvent()), // add event <=== new
      //       child: Icon(Icons.volume_mute),
      //     )
      //   ],
      // ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose(); // dispose bloc <=== new
  }
}
