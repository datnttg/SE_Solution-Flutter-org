import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:se_solution/utilities/shared_preferences.dart';

import '../../../../utilities/app_service.dart';
import '../models/task_filter_parameter_model.dart';
import '../services/task_fetch_data_service.dart';
import 'task_filter_events.dart';
import 'task_filter_states.dart';

class TaskInfoBloc {
  final eventController = StreamController<TaskFilterEvents>();
  final stateController = StreamController<TaskListState>.broadcast();

  var initialDateRange =
      '${DateFormat('dd/MM/yyyy').format(DateTime(DateTime.now().year, DateTime.now().month - 1, DateTime.now().day + 1))} - ${DateFormat('dd/MM/yyyy').format(DateTime.now())}';
  var params = TaskFilterParameterModel();

  TaskInfoBloc() {
    setDateRange(initialDateRange);
    eventController.stream.listen((event) {
      if (event is ChangeCreatedDate) {
        setDateRange(event.dateRange!);
      } else if (event is ChangeTaskFilterStatus) {
        params.taskStatuses = event.selected!.isNotEmpty
            ? event.selected!.map<String>((e) => e.value).toList()
            : null;
      } else if (event is ChangeTaskFilterAssignedUser) {
        params.assignedUserIds = event.selected!.isNotEmpty
            ? event.selected!.map<String>((e) => e.value).toList()
            : null;
      } else if (event is ChangeTaskFilterType) {
        params.taskTypes = event.selected!.isNotEmpty
            ? event.selected!.map<String>((e) => e.value).toList()
            : null;
      } else if (event is ChangeTaskFilterCreatedUser) {
        params.createdUserIds = event.selected!.isNotEmpty
            ? event.selected!.map<String>((e) => e.value).toList()
            : null;
      }
      loadData();
    });
  }

  bool setDateRange(String dateRange) {
    String? start;
    String? end;
    try {
      var dateList = dateRange.split(' - ').toList();
      start = kDateTimeConvert(dateList[0]).toString();
      end = kDateTimeConvert(dateList[1]).toString();
    } catch (ex) {
      start = null;
      end = null;
      kShowAlert(
          title: sharedPrefs.translate('Invalid format'),
          body: Text(sharedPrefs.translate(
              'Assigned date must be formated like: dd/mm/yyyy - dd/mm/yyyy')));
      return false;
    }
    params.assignedDateStart = start;
    params.assignedDateEnd = end;
    return true;
  }

  void loadData() async {
    var data = await fetchTaskList(params);
    if (data.isNotEmpty) {
      stateController.sink.add(TaskListState(data));
    } else {
      stateController.sink.add(TaskListState(null));
    }
  }

  void dispose() {
    eventController.close();
    stateController.close();
  }
}
