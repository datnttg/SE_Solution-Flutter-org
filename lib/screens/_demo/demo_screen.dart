import 'package:flutter/material.dart';
import 'package:se_solution/utilities/custom_widgets.dart';
import 'package:se_solution/utilities/responsive.dart';
import '../common_components/main_menu.dart';

class DemoScreen extends StatefulWidget {
  const DemoScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DemoScreenDemo();
  }
}

class _DemoScreenDemo extends State<DemoScreen> {
  // TextEditingController dateInput = TextEditingController();
  //text editing controller for text field

  @override
  void initState() {
    // dateInput.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Widget A = Container(
    //   width: 20,
    //   height: 40,
    //   color: Colors.blue,
    // );
    // Widget B = Container(
    //   width: 20,
    //   height: 40,
    //   color: Colors.yellow,
    // );
    // Widget C = Container(
    //   color: Colors.red,
    // );
    return Scaffold(
        drawer: const MainMenu(),
        appBar: AppBar(
          title: const Text("Demo screen"),
          backgroundColor: Colors.redAccent, //background color of app bar
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //
              // Begin here
              // ====================================================================
              ResponsiveRow(
                context: context,
                horizontalSpacing: 20,
                basicWidth: 360,
                children: [
                  ResponsiveItem(
                    percentWidthOfParent: 100 / 3,
                    child: CTextFormField(
                      labelText: "Label as hint",
                      labelTextAsHint: true,
                      boldText: true,
                      required: true,
                      // labelAsHint: true,
                    ),
                  ),
                  ResponsiveItem(
                    percentWidthOfParent: 100 / 3,
                    child: CTextFormField(
                      labelText: "Label as hint",
                      labelTextAsHint: true,
                      // labelAsHint: true,
                    ),
                  ),
                  ResponsiveItem(
                    percentWidthOfParent: 100 / 3,
                    child: CTextFormField(
                      labelText: "Label here",
                      required: true,
                      // labelAsHint: true,
                    ),
                  ),
                  ResponsiveItem(
                    percentWidthOfParent: 100,
                    child: CTextFormField(
                      labelText: "Label here",
                      wrap: true,
                      maxLines: 3,
                      // labelAsHint: true,
                    ),
                  ),
                ],
              ),

              ///
              CTextFormField(
                labelText: "Label here",
                // labelAsHint: true,
              ),
              CTextFormField(
                labelText: "Label here",
                wrap: true,
                maxLines: 3,
                // labelAsHint: true,
              ),
              Container(
                height: 20,
              ),
              // CTextFormField(
              //   labelText: 'Label',
              // ),
              // ====================================================================
              // End here
              //
              //
              Container(
                height: 20,
              ),
            ],
          ),
        ));
  }
}
