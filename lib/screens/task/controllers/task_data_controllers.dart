import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../utilities/app_service.dart';
import '../models/task_models.dart';

class TaskDetailController extends GetxController {
  var taskAssignment = const TaskAssignemntModel().obs;
  var referenceSubjects = RxList<TaskReferenceSubjectModel>();
  var projects = RxList<TaskProjectModel>();

  void reset() {
    taskAssignment = const TaskAssignemntModel().obs;
    referenceSubjects = RxList<TaskReferenceSubjectModel>();
    projects = RxList<TaskProjectModel>();
  }
}

class TaskInfoController extends GetxController {
  var taskId = "".obs;
  var taskTypeId = "".obs;
  var userIdAssigned = "".obs;
  var taskTitle = "".obs;
  var taskDescription = "".obs;
  var deadline = "".obs;
  var taskStatus = "".obs;
}

class TaskReferenceSubjectAddingController extends GetxController {
  var name = "".obs;
  var phone = "".obs;
  var address = "".obs;
  var customerSource = "".obs;
}

class TaskProjectAddingController extends GetxController {
  var provinces = RxList<DropdownMenuEntry>();
  var districts = RxList<DropdownMenuEntry>();
  var wards = RxList<DropdownMenuEntry>();
  var annexId = "".obs;
  var annexCode = "".obs;
  var contactName = "".obs;
  var countryId = "".obs;
  var provinceId = "".obs;
  var districtId = "".obs;
  var wardId = "".obs;
  var address = "".obs;
  var note = "".obs;
}

class TaskFilterController extends GetxController {
  RxMap filterParameters = {}.obs;
  RxString taskAssignedDateRange =
      '${DateFormat('dd/MM/yyyy').format(DateTime(DateTime.now().year, DateTime.now().month - 1, DateTime.now().day + 1))} - ${DateFormat('dd/MM/yyyy').format(DateTime.now())}'
          .obs;
  RxString taskStatus = "".obs;
  RxString taskTypeId = "".obs;
  RxString taskAssignedUserId = "".obs;
  RxList listTask = RxList();

  void updateFilterParameters() {
    var dateRange = taskAssignedDateRange.split(' - ').toList();
    filterParameters = {
      "assignedDateStart": kDateTimeConvert(dateRange[0]).toString(),
      "assignedDateEnd": kDateTimeConvert(dateRange[1]).toString(),
      "taskStatus": taskStatus.value,
      "taskTypeId": taskTypeId.value,
      "userIdAssigned": taskAssignedUserId.value
    }.obs;
  }
}
