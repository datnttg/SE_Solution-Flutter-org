import 'package:flutter/material.dart';

import '../../../utilities/custom_widgets.dart';

class DemoScreen extends StatefulWidget {
  const DemoScreen({super.key});

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  TextEditingController textEditingController =
      TextEditingController(text: 'Init value');
  @override
  Widget build(BuildContext context) {
    // textEditingController.text = 'Init value';
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Custom Demo'),
      ),
      body: Column(
        children: [
          CTextFormField(
            readOnly: false,
            required: true,
            labelText: 'Test',
            controller: textEditingController,
          )
        ],
      ),
    );
  }
}
