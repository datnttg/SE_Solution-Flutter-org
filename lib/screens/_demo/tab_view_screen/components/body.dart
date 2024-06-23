import 'package:flutter/material.dart';

class MyBody extends StatelessWidget {
  final String title;

  const MyBody(this.title, {super.key});

  final mySnackBar = const SnackBar(
    content: Text(
      "Hello There!",
      style: TextStyle(color: Colors.white),
    ),
    duration: Duration(seconds: 3),
    backgroundColor: Colors.blue,
  );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton(
            child: Text("$title  Click me"),
            onPressed: () => {
                  // Scaffold.of(context).showSnackBar(mySnackBar)
                }),
      ],
    );
  }
}
