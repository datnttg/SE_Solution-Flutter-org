import 'dart:convert';

import '../../../../utilities/app_service.dart';
import '../../../../utilities/constants/core_constants.dart';
import '../../../../utilities/shared_preferences.dart';
import '../models/task_condition_model.dart';
import '../models/task_detail_model.dart';

var hostAddress = constants.hostAddress;

Future<TaskDetailModel?> getTaskDetail(String taskId) async {
  var response = await fetchData(
    Uri.parse('$hostAddress/Task/Detail'),
    parameters: {"taskId": taskId},
    showFailureNotification: true,
  );

  if (response['success'] == false) {
    if (response['success'] != true) {
      if (response['responseMessage'] != '') {
        kShowToast(
          title: sharedPref.translate('Fail'),
          content: response['responseMessage'],
          style: 'danger',
        );
      } else if (response['success'] == false) {
        kShowToast(
          title: sharedPref.translate('Fail'),
          content: sharedPref.translate("Connection failed!"),
          style: 'danger',
        );
      } else {
        kShowToast(
          title: sharedPref.translate('Fail'),
          content: response['title'].toString(),
          style: 'danger',
        );
      }
    }
    return null;
  }

  var result = TaskDetailModel?.fromJson(response['responseData']);
  return result;
}

Future<List<TaskDetailModel>> updateTask(TaskDetailModel? params) async {
  var data = await fetchData(
    Uri.parse('$hostAddress/Task/Update'),
    parameters: params?.toJson(),
  );
  if (data['success'] == false) return [];
  var result = data['responseData']
      .map<TaskDetailModel>((e) => TaskDetailModel?.fromJson(e))
      .toList();
  return result;
}

Future<List<TaskConditionModel>> fetchTaskConditionMappings(Map params) async {
  var response = await fetchData(
    Uri.parse('$hostAddress/Task/ConditionMappings'),
    parameters: params,
    showFailureNotification: true,
  );
  if (response['success'] == true) {
    return TaskConditionModel.fromJsonList(response['responseData']);
  } else {
    return [];
  }
}
