import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:se_solution/screens/_demo/demo_screen.dart';
import '../screens/login/login_screen.dart';
import '../screens/owner_project_overview/owner_project_overview_screen.dart';
import '../screens/power_station_monitor/power_station_monitor_screen.dart';
import '../screens/task/task_detail/task_detail_screen.dart';
import '../screens/task/task_filter/task_filter_screen.dart';
import 'shared_preferences.dart';

class Config {
  String appVersion = sharedPrefs.getVersion();
}

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  List<String>? pathComponents = settings.name?.toLowerCase().split('/detail/');
  if (pathComponents?.length == 1) {
    switch (settings.name?.toLowerCase()) {
      /// Demo
      case '/demo':
        return MaterialPageRoute(builder: (_) => const DemoScreen());

      /// Implement
      case '/':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/logout':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/task':
        return MaterialPageRoute(builder: (_) => const TaskFilterScreen());
      case '/task/create':
        return MaterialPageRoute(builder: (_) => const TaskDetailScreen());
      case '/powerStation/monitoring':
        return MaterialPageRoute(
            builder: (_) => const PowerStationMonitorScreen());
      case '/my/project':
        return MaterialPageRoute(
            builder: (_) => const OwnerProjectOverviewScreen());
      default:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
    }
  }

  /// DETAIL routing
  else if (pathComponents?.length == 2) {
    switch (pathComponents?[0]) {
      case '/task':
        return MaterialPageRoute(
            builder: (context) => TaskDetailScreen(taskId: pathComponents?[1]));
      default:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
    }
  }
  return null;
}

var customRouteMapping = CustomRouteMapping();

class CustomRouteMapping {
  String demo = '/Demo';
  String demo2 = '/Demo2';
  String demoResponsiveTabs = '/DemoResponsiveTabs';
  String dashboard = '/Dashboard';
  String login = '/Login';
  String logout = '/Logout';
  String owner = '/Owner';
  String ownerAdd = '/Owner/Add';
  String subject = '/Subject';
  String subjectAdd = '/Subject/Add';
  String user = '/User';
  String userAdd = '/User/Add';
  String powerStationMonitoring = '/PowerStation/Monitoring';
  String task = '/Task';
  String taskAdd = '/Task/Create';
  String taskDetail = '/Task/Detail';

  //
  String myProject = '/My/Project';
}

// var customRoutes = <String, WidgetBuilder>{
//   customRouteMapping.demo: (_) => const ActionBarDemoScreen(),
//   customRouteMapping.demo2: (_) => const Demo2Screen(),
//   customRouteMapping.demoResponsiveTabs: (_) => const ResponsiveTabsScreen(),
//   customRouteMapping.dashboard: (_) => const DashboardScreen(),
//   customRouteMapping.login: (_) => const LoginScreen(),
//   customRouteMapping.logout: (_) => const LoginScreen(),
//   customRouteMapping.owner: (_) => const DashboardScreen(),
//   customRouteMapping.ownerAdd: (_) => const DashboardScreen(),
//   customRouteMapping.subject: (_) => const DashboardScreen(),
//   customRouteMapping.subjectAdd: (_) => const DashboardScreen(),
//   customRouteMapping.user: (_) => const DashboardScreen(),
//   customRouteMapping.userAdd: (_) => const DashboardScreen(),
//   customRouteMapping.powerStationMonitoring: (_) =>
//       const PowerStationMonitorScreen(),
//   customRouteMapping.task: (_) => const TaskFilterScreen(),
//   customRouteMapping.taskAdd: (_) => const TaskDetailScreen(),
//   customRouteMapping.taskDetail: (_) => const TaskDetailScreen(),
//   //
//   customRouteMapping.myProject: (_) => const OwnerProjectOverviewScreen(),
// };

var nf0 = NumberFormat("#,##0", sharedPrefs.getLocale().toString());
var nf1 = NumberFormat("#,##0.0", sharedPrefs.getLocale().toString());
var df0 = DateFormat('yyyy-MM-dd HH:mm:ss');
var df1 = DateFormat(sharedPrefs.dateFormat);
var df2 = DateFormat('dd-MM-yyyy HH:mm');
