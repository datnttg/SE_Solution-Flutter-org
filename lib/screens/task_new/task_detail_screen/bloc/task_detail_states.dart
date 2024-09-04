import '../../../../utilities/enums/ui_enums.dart';
import '../models/task_condition_model.dart';
import '../models/task_detail_dropdowns_model.dart';
import '../models/task_detail_model.dart';
import '../models/task_update_model.dart';

class TaskDetailState {
  ScreenModeEnum screenMode;
  ProcessingStatusEnum initialStatus;
  TaskDetailDropdownsModel dropdownData;
  List<TaskConditionModel> mappingConditions;
  ProcessingStatusEnum loadingStatus;
  TaskDetailModel taskDetail;
  TaskUpdateModel taskUpdate;

  TaskDetailState({
    required this.screenMode,
    required this.initialStatus,
    required this.dropdownData,
    required this.mappingConditions,
    required this.loadingStatus,
    required this.taskDetail,
    required this.taskUpdate,
  });

  TaskDetailState copyWith({
    ScreenModeEnum? screenMode,
    ProcessingStatusEnum? initialStatus,
    TaskDetailDropdownsModel? dropdownData,
    List<TaskConditionModel>? mappingConditions,
    ProcessingStatusEnum? loadingStatus,
    TaskDetailModel? taskDetail,
    TaskUpdateModel? taskUpdate,
  }) {
    return TaskDetailState(
      screenMode: screenMode ?? this.screenMode,
      initialStatus: initialStatus ?? this.initialStatus,
      dropdownData: dropdownData ?? this.dropdownData,
      mappingConditions: mappingConditions ?? this.mappingConditions,
      loadingStatus: loadingStatus ?? this.loadingStatus,
      taskDetail: taskDetail ?? this.taskDetail,
      taskUpdate: taskUpdate ?? this.taskUpdate,
    );
  }
}
