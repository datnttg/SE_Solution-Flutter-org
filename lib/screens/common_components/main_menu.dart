import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_treeview/flutter_treeview.dart';
import '../../utilities/configs.dart';
import '../../utilities/shared_preferences.dart';
import '../../utilities/ui_styles.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  String? selectedNode;
  late TreeViewController treeViewController;

  @override
  Widget build(BuildContext context) {
    List<Node> buildMenuTree(
        List<dynamic> functions, String? parentCode, int level) {
      List<Node> result = [];
      var loop = functions
          .where((element) => element['parentCode'] == parentCode)
          .toList();
      if (loop.any((element) => true)) {
        functions.removeWhere((e) => loop.any((u) => u['id'] == e['id']));
        var subLevel = level;
        for (var item in loop) {
          subLevel++;
          if (item['type'] == 'Function') {
            var node = Node(
              key: item['id'],
              label: item['label'],
              data: item['link'],
              icon: Icons.arrow_right,
              iconColor: Theme.of(context).colorScheme.secondary,
            );
            result.add(node);
            functions.remove(item);
          } else if (item['type'] == 'Title') {
            var children = buildMenuTree(functions, item['code'], subLevel);
            Node node = Node(
              key: item['id'],
              label: item['label'].toString().toUpperCase(),
              data: item['link'],
              icon: Icons.list,
              expanded: level < 2 ? true : false,
              children: children,
            );
            result.add(node);
            functions.remove(item);
          } else {
            var children = buildMenuTree(functions, item['code'], subLevel);
            Node node = Node(
              key: item['id'],
              label: item['label'],
              data: NodeData(type: item['type'], link: item['link']),
              icon: Icons.folder,
              expanded: level < 2 ? true : false,
              children: children,
            );
            result.add(node);
            functions.remove(item);
          }
        }
      }
      return result;
    }

    List<dynamic> functions = jsonDecode(sharedPrefs.getFunctions());
    List<Node> nodes = buildMenuTree(functions, null, 1);

    treeViewController = TreeViewController(
      children: nodes,
      selectedKey: selectedNode,
    );

    TreeViewTheme treeViewTheme = TreeViewTheme(
      expanderTheme: ExpanderThemeData(
        type: ExpanderType.caret,
        modifier: ExpanderModifier.none,
        position: ExpanderPosition.end,
        color: Theme.of(context).colorScheme.primary,
      ),
      labelStyle: const TextStyle(
        letterSpacing: 0.3,
      ),
      parentLabelStyle: TextStyle(
        letterSpacing: 0.1,
        fontWeight: FontWeight.w500,
        color: Theme.of(context).colorScheme.primary,
      ),
      iconTheme: IconThemeData(
        size: mediumTextSize * 1.5,
        color: Theme.of(context).colorScheme.primary,
      ),
      colorScheme: Theme.of(context).colorScheme,
      verticalSpacing: defaultPadding,
    );

    expandNode(String key, bool expanded) {
      String msg = '${expanded ? "Expanded" : "Collapsed"}: $key';
      debugPrint(msg);
      Node? node = treeViewController.getNode(key);
      if (node != null) {
        List<Node> updated;
        // NodeData nodeData = node.data;
        // if (nodeData.type != 'Function') {
        //   updated = treeViewController.updateNode(
        //       key,
        //       node.copyWith(
        //         expanded: expanded,
        //         icon: expanded ? Icons.folder_open : Icons.folder,
        //       ));
        // } else {
        //   updated = treeViewController.updateNode(
        //       key, node.copyWith(expanded: expanded));
        // }
        setState(() {
          updated = treeViewController.updateNode(
              key, node.copyWith(expanded: expanded));
          treeViewController = treeViewController.copyWith(children: updated);
        });
      }
    }

    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Text(
              sharedPrefs.translate("Menu"),
              style: const TextStyle(
                color: kContentColor,
                fontSize: 24,
              ),
            ),
          ),
          Expanded(
            child: TreeView(
              controller: treeViewController,
              onExpansionChanged: (key, expanded) => expandNode(key, expanded),
              onNodeTap: (key) {
                debugPrint('Selected function: $key');
                setState(() {
                  selectedNode = key;
                  treeViewController =
                      treeViewController.copyWith(selectedKey: key);

                  List<dynamic> functions =
                      jsonDecode(sharedPrefs.getFunctions());
                  for (var function in functions) {
                    if (function['id'] == key && function['link'] != '#') {
                      Navigator.pushNamed(context, function['link']);
                    }
                  }
                });
              },
              theme: treeViewTheme,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: defaultPadding * 3,
              bottom: defaultPadding * 3,
            ),
            child: Center(
              child: Text(
                '${sharedPrefs.translate('Version')}: ${Config().appVersion}',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NodeData {
  String? type;
  String? link;

  NodeData({this.type, this.link});
}
