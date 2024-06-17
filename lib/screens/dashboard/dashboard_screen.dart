import 'package:flutter/material.dart';
import '../../utilities/custom_widgets.dart';
import '../../utilities/shared_preferences.dart';
import '../common_components/main_menu.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return KScaffold(
      drawer: const MainMenu(),
      appBar: AppBar(
        title: Text(sharedPrefs.translate("Dashboard")),
      ),
    );
  }
}
