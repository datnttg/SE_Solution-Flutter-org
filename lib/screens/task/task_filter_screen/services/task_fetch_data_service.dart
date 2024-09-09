import 'dart:async';
import '../../../../utilities/app_service.dart';
import '../../../../utilities/classes/custom_widget_models.dart';
import '../../../../utilities/constants/core_constants.dart';
import '../../../../utilities/shared_preferences.dart';
import '../models/task_filter_item_model.dart';
import '../models/task_filter_parameter_model.dart';

var hostAddress = Uri.parse(constants.hostAddress);

Stream<List<CDropdownMenuEntry>> fetchTaskCategory(
    {String? categoryProperty}) async* {
  var params = {"categoryProperty": categoryProperty};
  var data = await fetchData(Uri.parse('$hostAddress/Task/ListCategory'),
      parameters: params);
  var listEntries = data['responseData']
      .map<CDropdownMenuEntry>((e) => CDropdownMenuEntry(
            value: e['code'],
            labelText: e[sharedPref.getLocale().languageCode],
          ))
      .toList();
  yield listEntries;
}

Stream<List<CDropdownMenuEntry>?> fetchAssignedUserEntries(
    {List<String>? selectedIds}) async* {
  var params = {"selectedUserIds": selectedIds};
  var data = await fetchData(
    Uri.parse('$hostAddress/Account/ListUsers'),
    parameters: params,
  );
  var listEntries = data['responseData']
      .map<CDropdownMenuEntry>((e) => CDropdownMenuEntry(
            value: e['id'],
            labelText: e['displayName'],
          ))
      .toList();
  yield listEntries;
}

Future<List<TaskFilterItemModel>> fetchTaskList(
    TaskFilterParameterModel params) async {
  var data = await fetchData(
    Uri.parse('$hostAddress/Task/List'),
    parameters: params.toMap(),
  );
  if (data['success'] == false) return [];
  var result = data['responseData']
      .map<TaskFilterItemModel>((e) => TaskFilterItemModel.fromJson(e))
      .toList();
  return result;
}
