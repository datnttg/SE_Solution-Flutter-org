// import 'package:flutter/material.dart';
// import '../../utilities/custom_widgets.dart';
// import '../../utilities/responsive.dart';
// import '../common_components/main_menu.dart';
//
// class DemoScreen extends StatefulWidget {
//   const DemoScreen({super.key});
//
//   @override
//   State<StatefulWidget> createState() {
//     return _DemoScreenDemo();
//   }
// }
//
// class _DemoScreenDemo extends State<DemoScreen> {
//   // TextEditingController dateInput = TextEditingController();
//   //text editing controller for text field
//
//   @override
//   void initState() {
//     // dateInput.text = ""; //set the initial value of text field
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // Widget A = Container(
//     //   width: 20,
//     //   height: 40,
//     //   color: Colors.blue,
//     // );
//     // Widget B = Container(
//     //   width: 20,
//     //   height: 40,
//     //   color: Colors.yellow,
//     // );
//     // Widget C = Container(
//     //   color: Colors.red,
//     // );
//     return Scaffold(
//         drawer: const MainMenu(),
//         appBar: AppBar(
//           title: const Text("Demo screen"),
//           backgroundColor: Colors.redAccent, //background color of app bar
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               //
//               // Begin here
//               // ====================================================================
//               ResponsiveRow(
//                 context: context,
//                 horizontalSpacing: 20,
//                 basicWidth: 360,
//                 children: const [
//                   ResponsiveItem(
//                     percentWidthOfParent: 100 / 3,
//                     child: CTextFormField(
//                       labelText: "Label as hint",
//                       labelTextAsHint: true,
//                       boldText: true,
//                       required: true,
//                       // labelAsHint: true,
//                     ),
//                   ),
//                   ResponsiveItem(
//                     percentWidthOfParent: 100 / 3,
//                     child: CTextFormField(
//                       labelText: "Label as hint",
//                       labelTextAsHint: true,
//                       // labelAsHint: true,
//                     ),
//                   ),
//                   ResponsiveItem(
//                     percentWidthOfParent: 100 / 3,
//                     child: CTextFormField(
//                       labelText: "Label here",
//                       required: true,
//                       // labelAsHint: true,
//                     ),
//                   ),
//                   ResponsiveItem(
//                     percentWidthOfParent: 100,
//                     child: CTextFormField(
//                       labelText: "Label here",
//                       wrap: true,
//                       maxLines: 3,
//                       // labelAsHint: true,
//                     ),
//                   ),
//                 ],
//               ),
//
//               ///
//               const CTextFormField(
//                 labelText: "Label here",
//                 // labelAsHint: true,
//               ),
//               const CTextFormField(
//                 labelText: "Label here",
//                 wrap: true,
//                 maxLines: 3,
//                 // labelAsHint: true,
//               ),
//               Container(
//                 height: 20,
//               ),
//               // CTextFormField(
//               //   labelText: 'Label',
//               // ),
//               // ====================================================================
//               // End here
//               //
//               //
//               Container(
//                 height: 20,
//               ),
//             ],
//           ),
//         ));
//   }
// }

import 'package:dropdown_plus_plus/dropdown_plus_plus.dart';
import 'package:flutter/material.dart';

class DemoScreen extends StatefulWidget {
  const DemoScreen({super.key});

  @override
  _DemoScreenState createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  final List<Map<String, dynamic>> _roles = [
    {"name": "Super Admin", "desc": "Having full access rights", "role": 1},
    {
      "name": "Admin",
      "desc": "Having full access rights of a Organization",
      "role": 2
    },
    {
      "name": "Manager",
      "desc": "Having Magenent access rights of a Organization",
      "role": 3
    },
    {
      "name": "Technician",
      "desc": "Having Technician Support access rights",
      "role": 4
    },
    {
      "name": "Customer Support",
      "desc": "Having Customer Support access rights",
      "role": 5
    },
    {"name": "User", "desc": "Having End User access rights", "role": 6},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dropdown Plus Plus Demo'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextDropdownFormField(
              options: ["Male", "Female"],
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.arrow_drop_down),
                  labelText: "Gender"),
              cursorColor: Colors.green,
              dropdownItemColor: Colors.red,
            ),
            SizedBox(
              height: 16,
            ),
            DropdownFormField<Map<String, dynamic>>(
              onEmptyActionPressed: (String str) async {},
              dropdownItemSeparator: Divider(
                color: Colors.black,
                height: 1,
              ),
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.arrow_drop_down),
                  labelText: "Access"),
              onSaved: (dynamic str) {},
              onChanged: (dynamic str) {},
              validator: null,
              displayItemFn: (dynamic item) => Text(
                (item ?? {})['name'] ?? '',
                style: TextStyle(fontSize: 16),
              ),
              findFn: (dynamic str) async => _roles,
              selectedFn: (dynamic item1, dynamic item2) {
                if (item1 != null && item2 != null) {
                  return item1['name'] == item2['name'];
                }
                return false;
              },
              filterFn: (dynamic item, str) =>
                  item['name'].toLowerCase().indexOf(str.toLowerCase()) >= 0,
              dropdownItemFn: (dynamic item, int position, bool focused,
                      bool selected, Function() onTap) =>
                  ListTile(
                title: Text(item['name']),
                subtitle: Text(
                  item['desc'] ?? '',
                ),
                tileColor:
                    focused ? Color.fromARGB(20, 0, 0, 0) : Colors.transparent,
                onTap: onTap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
