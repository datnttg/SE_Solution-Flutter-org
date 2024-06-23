import 'package:flutter/material.dart';

import 'body.dart';

class MultiDropdownScreen extends StatefulWidget {
  const MultiDropdownScreen({super.key});

  @override
  State<MultiDropdownScreen> createState() => _MultiDropdownScreenState();
}

class _MultiDropdownScreenState extends State<MultiDropdownScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MultiDropdown'),
        centerTitle: true,
      ),
      body: MultiDropdownBody(),
    );
  }
}
