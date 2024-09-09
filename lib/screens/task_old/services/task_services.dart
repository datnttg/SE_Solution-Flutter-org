import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utilities/app_service.dart';
import '../../../../../utilities/constants/core_constants.dart';
import '../../../../../utilities/shared_preferences.dart';
import '../../../utilities/custom_widgets.dart';
import '../../../utilities/ui_styles.dart';
import '../controllers/task_data_controllers.dart';
import '../controllers/task_ui_controllers.dart';

final taskUIController = Get.find<TaskUIController>();
final taskDetailController = Get.find<TaskDetailController>();
final taskInfoController = Get.find<TaskInfoController>();
final taskFilterController = Get.find<TaskFilterController>();

Future<List> fetchTaskCategories({categoryProperty}) async {
  var uri = Uri.parse("${constants.hostAddress}/Task/ListCategory");
  Map response =
      await fetchData(uri, parameters: {"categoryProperty": categoryProperty});
  var responseData = response['responseData'] as List;
  return responseData;
}

Future<List> fetchTaskCategoryFilter({categoryProperty}) async {
  var categories =
      await fetchTaskCategories(categoryProperty: categoryProperty);
  if (categories.length > 1) {
    categories.insert(0, {
      'id': '',
      'code': '',
      sharedPref.getLocale().languageCode: '--${sharedPref.translate('All')}--',
    });
  }
  return categories;
}

Future<List> fetchTaskUsers() async {
  var uri = Uri.parse("${constants.hostAddress}/Task/ListActiveUser");
  Map response = await fetchData(uri);
  var responseData = response['responseData'] as List;
  return responseData;
}

Future<List> taskUsersFilter() async {
  var users = await fetchTaskUsers();
  if (users.length > 1) {
    users.insert(0, {
      'id': '',
      'displayName': '--${sharedPref.translate('All')}--',
    });
  }
  return users;
}

List<DropdownMenuEntry> convertToView(List list) {
  return list
      .map((e) => DropdownMenuEntry(
            value: e["Id"],
            label: e["Username"] + " - " + e["DisplayName"],
          ))
      .toList();
}

Future<List> fetchListAssignedUsers() async {
  var uri = Uri.parse("${constants.hostAddress}/Task/ListActiveUser");
  Map response = await fetchData(uri);
  var responseData = response['responseData'] as List;
  if (responseData.length > 1) {
    responseData.insert(0, {
      'id': '',
      'displayName': '--${sharedPref.translate('All')}--',
    });
  }
  return responseData;
}

// Future<List<TaskReferenceSubjectModel>> fetchReferenceSubjects(
//     String taskId) async {
//   return [
//     const TaskReferenceSubjectModel(
//         name: "Nguyen The Dat",
//         phone: "0961799288",
//         address: "49/13 Hoang Du Khuong, Phuong 12, Quan 10, TPHCM"),
//     const TaskReferenceSubjectModel(
//         name: "Nguyen The Dat",
//         phone: "0961799288",
//         address: "49/13 Hoang Du Khuong, Phuong 12, Quan 10, TPHCM"),
//     const TaskReferenceSubjectModel(
//         name: "Nguyen The Dat",
//         phone: "0961799288",
//         address: "49/13 Hoang Du Khuong, Phuong 12, Quan 10, TPHCM"),
//     const TaskReferenceSubjectModel(
//         name: "Nguyen The Dat",
//         phone: "0961799288",
//         address: "49/13 Hoang Du Khuong, Phuong 12, Quan 10, TPHCM"),
//   ];
// }

Future<Map> fetchTaskDetail(String taskId) async {
  var parameters = {"taskId": taskId};
  var uri = Uri.parse("${constants.hostAddress}/Task/Detail");
  Map data = await fetchData(uri, parameters: parameters);
  return data['responseData'];
}

Future<List<DropdownMenuEntry>> getListAssignedUserEntries() =>
    fetchListAssignedUsers().then((value) => value
        .map((e) => DropdownMenuEntry(
              value: e['id'],
              label: e['displayName'] +
                  (e['username'] == null ? '' : ' (${e['username']})'),
            ))
        .toList());

Future<List<DropdownMenuEntry>> getTaskTypeEntries() =>
    fetchTaskCategories(categoryProperty: "Type").then((value) => value
        .map(
          (e) => DropdownMenuEntry(
              value: e['id'], label: e[sharedPref.getLocale().languageCode]),
        )
        .toList());

Future<List> fetchContractAnnexs(Map parameters) async {
  var uri = Uri.parse("${constants.hostAddress}/Contract/ListAnnex");
  Map data = await fetchData(uri, parameters: parameters);
  var contracts = data['responseData'] as List;
  return contracts;
}

Future<List> fetchLocales(Map parameters) async {
  var uri = Uri.parse("${constants.hostAddress}/Locale/List");
  Map data = await fetchData(uri, parameters: parameters);
  var result = data['responseData'] as List;
  return result;
}

Future<List<DropdownMenuEntry>> fetchLocaleDropdownEntries(Map parameters) =>
    fetchLocales(parameters).then(
      (value) => value
          .map((e) => DropdownMenuEntry(
              value: e['id'],
              label: e['name'] ?? "",
              labelWidget: Column(
                children: [
                  Row(
                    children: [Text(e['name'] ?? "")],
                  ),
                  e['note'] != null
                      ? Row(
                          children: [
                            Text(
                              e['note'],
                              style: const TextStyle(fontSize: smallTextSize),
                            )
                          ],
                        )
                      : Container()
                ],
              )))
          .toList(),
    );

Future<List> getFieldMappings(Map? parameters) async {
  var uri = Uri.parse("${constants.hostAddress}/Task/ConditionMappings");
  Map data = await fetchData(uri, parameters: parameters);
  var result = data['responseData'] as List;
  return result;
}

String? getReferenceSubjectRequire(
    String? conditionValue, String? mappingEntity) {
  var taskController = Get.find<TaskUIController>();
  var items = taskController.fieldMappings.firstWhereOrNull((element) =>
      element['conditionValue'].toString().toLowerCase() ==
          conditionValue.toString().toLowerCase() &&
      element['mappingEntity'].toString().toLowerCase() ==
          mappingEntity.toString().toLowerCase());
  return items?['mappingStatus'];
}

Future<Map> confirmTask() async {
  var taskDetailController = Get.find<TaskDetailController>();
  var parameters = {
    "taskAssignment": taskDetailController.taskAssignment,
    "referenceSubjects": taskDetailController.referenceSubjects,
    "projects": taskDetailController.projects
  };
  var uri = Uri.parse('${constants.hostAddress}/Task/Update');
  Map response = await fetchData(uri, parameters: parameters);
  return response['responseData'];
}

Future<List<DropdownMenuEntry>> getTaskStatusEntries() =>
    fetchTaskCategories(categoryProperty: "Status").then((value) => value
        .map(
          (e) => DropdownMenuEntry(
              value: e['code'], label: e[sharedPref.getLocale().languageCode]),
        )
        .toList());

Map? getValue() {
  var taskAssignment = {
    "id": taskInfoController.taskId.value,
    "taskTypeId": taskInfoController.taskTypeId.value,
    "userIdAssigned": taskInfoController.userIdAssigned.value,
    "taskTitle": taskInfoController.taskTitle.value,
    "taskDescription": taskInfoController.taskDescription.value,
    "deadline":
        kDateTimeConvert(taskInfoController.deadline.value).toLocal().toString()
  };
  Map payload = {
    "TaskAssignment": jsonEncode(taskAssignment),
    "ReferenceSubjects": jsonEncode(taskDetailController.referenceSubjects),
    "Projects": jsonEncode(taskDetailController.projects),
  };
  return payload;
}

bool checkConditions() {
  if (taskDetailController.referenceSubjects.isEmpty &&
      getReferenceSubjectRequire(
              taskDetailController.taskAssignment.value.taskTypeId,
              "TaskReferenceSubject") !=
          null) {
    kShowAlert(
        body: KSelectableText(
            sharedPref.translate('Reference subject(s) is required!')),
        title: sharedPref.translate('Result'));
    return false;
  }
  return true;
}

Future refreshTaskList() async {
  taskFilterController.updateFilterParameters();
  var res = await fetchData(Uri.parse('${constants.hostAddress}/task/list'),
      parameters: taskFilterController.filterParameters);
  if (res['responseData'] != null) {
    taskFilterController.listTask.value = res['responseData'];
  }
}
