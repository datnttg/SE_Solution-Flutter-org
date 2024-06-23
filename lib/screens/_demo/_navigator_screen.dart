import 'package:flutter/material.dart';

import '_custom_demo/demo_screen.dart';
import 'action_bar_demo_screen/action_bar_demo_screen.dart';
import 'bloc_screen/bloc_screen.dart';
import 'multi_dropdown_screen/multi_dropdown_screen.dart';
import 'on_processing/on_processing_screen.dart';
import 'responsive_tabs_screen/responsive_tabs_screen.dart';
import 'tab_view_screen/tab_view_screen.dart';

class DemoHomePage extends StatefulWidget {
  const DemoHomePage({super.key, required this.title});

  final String title;

  @override
  State<DemoHomePage> createState() => _DemoHomePageState();
}

class _DemoHomePageState extends State<DemoHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            /// Start
            /// CUSTOM DEMO

            ElevatedButton(
                child: const Text('Custom demo'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DemoScreen()));
                }),

            /// PLUGIN
            ElevatedButton(
                child: const Text('BLoC pattern'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BlocScreen(
                                title: 'Bloc pattern',
                              )));
                }),
            ElevatedButton(
                child: const Text('MultiDropdown screen'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MultiDropdownScreen()));
                }),
            ElevatedButton(
                child: const Text('TabView screen'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TabViewScreen()));
                }),
            ElevatedButton(
                child: const Text('ActionBarDemoScreen'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ActionBarDemoScreen()));
                }),
            ElevatedButton(
                child: const Text('ResponsiveTabsScreen'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ResponsiveTabsScreen()));
                }),
            ElevatedButton(
                child: const Text('LoadingOverlayAlt'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              LoadingOverlayAlt(child: const Text('data'))));
                }),

            /// End
          ],
        ),
      ),
    );
  }
}
