import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../screens/_demo/_navigator_screen.dart';
import '../screens/login/login_screen.dart';
import '../screens/owner_project_overview/owner_project_overview_screen.dart';
import '../screens/power_station_monitor/power_station_monitor_screen.dart';
import '../screens/product/product_detail_screen/product_detail_screen.dart';
import '../screens/product/product_filter_screen/product_filter_screen.dart';
// import '../screens/task/task_filter_screen/task_filter_screen.dart';
// import '../screens/task_old/task_detail/task_detail_screen.dart';
import '../screens/task/task_detail_screen/task_detail_screen.dart';
import '../screens/task/task_filter_screen/task_filter_screen.dart';
import 'shared_preferences.dart';

class Config {
  String appVersion = sharedPref.getVersion();
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
  String product = '/Product';
  String productAdd = '/Product/Create';
  String productDetail = '/Product/Detail';

  //
  String myProject = '/My/Project';
}

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  List<String>? pathComponents = settings.name?.toLowerCase().split('/detail/');
  var first = pathComponents?[0].toLowerCase();
  if (pathComponents?.length == 1) {
    if (first == customRouteMapping.demo.toLowerCase()) {
      return MaterialPageRoute(
          builder: (_) => const DemoHomePage(title: 'Demo'));
    } else if (first == customRouteMapping.login.toLowerCase()) {
      return MaterialPageRoute(builder: (_) => const LoginScreen());
    } else if (first == customRouteMapping.logout.toLowerCase()) {
      return MaterialPageRoute(builder: (_) => const LoginScreen());
    } else if (first == customRouteMapping.task.toLowerCase()) {
      return MaterialPageRoute(builder: (_) => const TaskFilterScreen());
    } else if (first == customRouteMapping.taskAdd.toLowerCase()) {
      return MaterialPageRoute(builder: (_) => const TaskDetailScreen());
    } else if (first == customRouteMapping.product.toLowerCase()) {
      return MaterialPageRoute(builder: (_) => const ProductFilterScreen());
    } else if (first == customRouteMapping.productAdd.toLowerCase()) {
      return MaterialPageRoute(builder: (_) => const ProductDetailScreen());
    } else if (first ==
        customRouteMapping.powerStationMonitoring.toLowerCase()) {
      return MaterialPageRoute(
          builder: (_) => const PowerStationMonitorScreen());
    } else if (first == customRouteMapping.myProject.toLowerCase()) {
      return MaterialPageRoute(
          builder: (_) => const OwnerProjectOverviewScreen());
    }
    return MaterialPageRoute(builder: (_) => const LoginScreen());
  }

  /// DETAIL routing
  else if (pathComponents?.length == 2) {
    if (first == customRouteMapping.task.toLowerCase()) {
      return MaterialPageRoute(
          builder: (context) => TaskDetailScreen(taskId: pathComponents?[1]));
    } else if (first == customRouteMapping.product.toLowerCase()) {
      return MaterialPageRoute(
          builder: (context) =>
              ProductDetailScreen(productId: pathComponents?[1]));
    }
    return MaterialPageRoute(builder: (_) => const LoginScreen());
  }
  return null;
}

var nf0 = NumberFormat("#,##0", sharedPref.getLocale().toString());
var nf1 = NumberFormat("#,##0.0", sharedPref.getLocale().toString());
var df0 = DateFormat('yyyy-MM-dd HH:mm:ss', sharedPref.getLocaleCode());
var df1 =
    DateFormat(sharedPref.dateFormat, sharedPref.getLocaleCode()); //dd-MM-yyyy
var df2 = DateFormat('dd-MM-yyyy HH:mm', sharedPref.getLocaleCode());

String df0ConvertedFromDf1(String inputDateTime) {
  try {
    var year = '1900';
    var month = '01';
    var day = '01';
    var dateElements = inputDateTime.split("-");
    if (inputDateTime.isEmpty) return '';
    if (dateElements.isNotEmpty) {
      day =
          NumberFormat("00").format(int.parse(dateElements[0])).substring(0, 2);
    }
    if (dateElements.length >= 2 &&
        dateElements[1] != '' &&
        dateElements[1] != '0') {
      month =
          NumberFormat("00").format(int.parse(dateElements[1])).substring(0, 2);
    }
    if (dateElements.length >= 3 &&
        dateElements[2] != '' &&
        dateElements[2] != '0') {
      if (dateElements[2].length < 4) {
        year = NumberFormat("0000").format(int.parse(dateElements[2]) + 2000);
      } else {
        year = NumberFormat("0000").format(int.parse(dateElements[2]));
      }
    }
    return '$year-$month-$day 00:00:00';
  } catch (e) {
    return '';
  }
}

String df0ConvertedFromDf2(String inputDateTime) {
  var hour = '00';
  var minute = '00';
  var second = '00';
  var elements = inputDateTime.split(" ");
  if (elements.length > 1) {
    var time = elements[1];
    var timeSplit = time.split(":");
    if (timeSplit[0].isNotEmpty) {
      hour = NumberFormat("00").format(int.parse(timeSplit[0])).substring(0, 2);
    }
    if (timeSplit.length > 1 && timeSplit[1].isNotEmpty) {
      minute =
          NumberFormat("00").format(int.parse(timeSplit[1])).substring(0, 2);
    }
    if (timeSplit.length > 2 && timeSplit[2].isNotEmpty) {
      second =
          NumberFormat("00").format(int.parse(timeSplit[2])).substring(0, 2);
    }
  }

  var df0String = df0ConvertedFromDf1(elements[0]);
  if (df0String.isEmpty) {
    return '';
  } else {
    var dateString = df0String.split(" ");
    return '${dateString[0]} $hour:$minute:$second';
  }
}
