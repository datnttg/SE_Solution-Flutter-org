import 'dart:async';
import '../models/task_filter_parameter_model.dart';
import '../services/task_fetch_data_service.dart';
import 'task_filter_events.dart';
import 'task_filter_states.dart';

class TaskInfoBloc {
  final eventController = StreamController<TaskFilterEvents>();
  final stateController = StreamController<TaskListState>.broadcast();

  var params = TaskFilterParameterModel();

  TaskInfoBloc() {
    eventController.stream.listen((event) {
      if (event is ChangeTaskFilterStatus) {
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
