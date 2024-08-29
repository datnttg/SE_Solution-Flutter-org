import 'package:get/get.dart';

import '../../../../utilities/app_service.dart';
import '../../../../utilities/classes/custom_widget_models.dart';
import '../../../../utilities/constants/core_constants.dart';
import '../../../../utilities/shared_preferences.dart';
import '../models/task_filter_item_model.dart';
import '../models/task_filter_parameters_model.dart';

var hostAddress = constants.hostAddress;

Future<List<CDropdownMenuEntry>> fetchTaskCategoryEntries(
    {String? categoryProperty, String? statusCode, String? selectedId}) async {
  var params = {"categoryProperty": categoryProperty};
  var data = await fetchData(Uri.parse('$hostAddress/Task/ListCategory'),
      parameters: params);
  var listEntries = data['responseData']
      .map<CDropdownMenuEntry>((e) => CDropdownMenuEntry(
            value: e['code'],
            labelText: e[sharedPref.getLocale().languageCode],
          ))
      .toList();
  return listEntries;
}

Future<List<CDropdownMenuEntry>> fetchTaskUserEntries(
    {String? categoryProperty, String? statusCode, String? selectedId}) async {
  var params = {};
  var data = await fetchData(Uri.parse('$hostAddress/Task/ListActiveUser'),
      parameters: params);
  var listEntries = data['responseData']
      .map<CDropdownMenuEntry>((e) => CDropdownMenuEntry(
            value: e['id'],
            labelText: '${'${e['displayName']}'.capitalize} (${e['username']})',
          ))
      .toList();
  return listEntries;
}

Future<List<TaskFilterItemModel>> fetchTaskList(
    TaskFilterParameters? params) async {
  var data = await fetchData(
    Uri.parse('$hostAddress/Task/List'),
    parameters: params?.toMap(),
  );
  if (data['success'] == false) return [];
  var result = data['responseData']
      .map<TaskFilterItemModel>((e) => TaskFilterItemModel?.fromJson(e))
      .toList();
  return result;
}
