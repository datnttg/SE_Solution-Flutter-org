import 'package:flutter/material.dart';
import '../../../utilities/shared_preferences.dart';
import '../../common_components/main_menu.dart';

class ActionBarDemoScreen extends StatefulWidget {
  const ActionBarDemoScreen({super.key});

  @override
  State<ActionBarDemoScreen> createState() => _ActionBarDemoScreenState();
}

class _ActionBarDemoScreenState extends State<ActionBarDemoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MainMenu(),
      appBar: AppBar(
        title: Text(sharedPref.translate("Dashboard")),
        actions: [
          Container(
            width: 100,
            color: Colors.amber,
          ),
          Container(
            width: 100,
            color: Colors.black,
          ),
          Container(
            width: 100,
            color: Colors.cyan,
          ),
          Container(
            width: 100,
            color: Colors.amber,
          ),
          Container(
            width: 100,
            color: Colors.black,
          ),
          Container(
            width: 100,
            color: Colors.cyan,
          ),
        ],
      ),
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       const Text(
      //         'You have pushed the button this many times:',
      //       ),
      //       Text(
      //         '$_counter',
      //         style: Theme.of(context).textTheme.headlineMedium,
      //       ),
      //     ],
      //   ),
      // ),
      // bottomNavigationBar: const MainBottomNavigationBar(),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
