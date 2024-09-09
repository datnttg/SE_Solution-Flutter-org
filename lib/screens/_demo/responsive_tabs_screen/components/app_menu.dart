import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_treeview/flutter_treeview.dart';

import '../../../../utilities/shared_preferences.dart';

// Widget appMenu(BuildContext context) {
//   List<Widget> listView = [
//     const DrawerHeader(
//       decoration: BoxDecoration(
//         color: Colors.blue,
//       ),
//       child: Text(
//         'Menu',
//         style: TextStyle(
//           color: Colors.white,
//           fontSize: 24,
//         ),
//       ),
//     )
//   ];
//   var functions = sharedPref.getFunctions();
//   var appMenu = jsonDecode(functions);
//   for (var item in appMenu) {
//     Widget listTile = GestureDetector(
//       onTap: () => Navigator.pushNamed(context, item['link']),
//       child: ListTile(
//         leading: const Icon(Icons.settings),
//         title: Text(item[sharedPref.getLocale().languageCode]),
//       ),
//     );
//     listView.add(listTile);
//   }
//   return Drawer(
//     child: ListView(
//       padding: EdgeInsets.zero,
//       children: listView,
//     ),
//   );
// }

class AppMenu extends StatefulWidget {
  const AppMenu({super.key});

  @override
  State<AppMenu> createState() => _AppMenuState();
}

class _AppMenuState extends State<AppMenu> {
  @override
  Widget build(BuildContext context) {
    bool allowParentSelect = false;
    bool supportParentDoubleTap = false;
    String? selectedNode;
    ExpanderPosition expanderPosition = ExpanderPosition.end;
    ExpanderType expanderType = ExpanderType.caret;
    ExpanderModifier expanderModifier = ExpanderModifier.none;

    List<Node> buildMenuTree(
      List<dynamic> functions,
      String? parentCode,
      int level,
    ) {
      List<Node> result = [];
      var loop = functions
          .where((element) => element['parentCode'] == parentCode)
          .toList();
      var subLevel = level;
      if (loop.any((element) => true)) {
        functions.removeWhere((e) => loop.any((u) => u['id'] == e['id']));
        for (var item in loop) {
          subLevel++;
          if (item['type'] == 'Function') {
            var node = Node(
              label: item['label'],
              key: item['link'],
              icon: Icons.arrow_right,
            );
            result.add(node);
            functions.remove(item);
          } else if (item['type'] == 'Title') {
            var children = buildMenuTree(functions, item['code'], subLevel);
            Node node = Node(
              label: item['label'].toString().toUpperCase(),
              key: item['link'],
              expanded: level < 2 ? true : false,
              icon: Icons.list,
              iconColor: Colors.blue,
              selectedIconColor: Colors.green,
              children: children,
            );
            result.add(node);
            functions.remove(item);
          } else {
            var children = buildMenuTree(functions, item['code'], subLevel);
            Node node = Node(
              label: item['label'],
              key: item['link'],
              expanded: level < 2 ? true : false,
              icon: Icons.folder,
              iconColor: Colors.blue,
              selectedIconColor: Colors.green,
              children: children,
            );
            result.add(node);
            functions.remove(item);
          }
        }
      }
      return result;
    }

    List<dynamic> functions = jsonDecode(sharedPref.getFunctions());
    List<Node> nodes = buildMenuTree(functions, null, 1);

    TreeViewController treeViewController = TreeViewController(
      children: nodes,
      selectedKey: selectedNode,
    );

    // expandNode(String key, bool expanded) {
    //   String msg = '${expanded ? "Expanded" : "Collapsed"}: $key';
    //   debugPrint(msg);
    // Node? node = treeViewController.getNode(key);
    // if (node != null) {
    //   List<Node> updated;
    //   if (key == 'docs') {
    //     updated = treeViewController.updateNode(
    //         key,
    //         node.copyWith(
    //           expanded: expanded,
    //           icon: expanded ? Icons.folder_open : Icons.folder,
    //         ));
    //   } else {
    //     updated = treeViewController.updateNode(
    //         key, node.copyWith(expanded: expanded));
    //   }
    // }
    // }

    TreeViewTheme treeViewTheme = TreeViewTheme(
      expanderTheme: ExpanderThemeData(
        type: expanderType,
        modifier: expanderModifier,
        position: expanderPosition,
        color: Colors.blue,
        size: 20,
      ),
      labelStyle: const TextStyle(letterSpacing: 0.3),
      parentLabelStyle: TextStyle(
        letterSpacing: 0.1,
        fontWeight: FontWeight.w700,
        color: Colors.blue.shade500,
      ),
      iconTheme: const IconThemeData(
        size: 25,
        // color: Colors.grey.shade800,
      ),
      colorScheme: Theme.of(context).colorScheme,
    );

    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          Expanded(
            child: TreeView(
              controller: treeViewController,
              allowParentSelect: allowParentSelect,
              supportParentDoubleTap: supportParentDoubleTap,
              // onExpansionChanged: (key, expanded) => expandNode(key, expanded),
              onNodeTap: (key) {
                debugPrint('Selected: $key');
                setState(() {
                  selectedNode = key;
                  treeViewController =
                      treeViewController.copyWith(selectedKey: key);
                });
              },
              theme: treeViewTheme,
            ),
          ),
        ],
      ),
    );
  }
}
