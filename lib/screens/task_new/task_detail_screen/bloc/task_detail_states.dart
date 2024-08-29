import '../../../../utilities/enums/ui_enums.dart';
import '../models/task_condition_model.dart';
import '../models/task_detail_dropdowns_model.dart';
import '../models/task_detail_model.dart';

class TaskDetailState {
  ScreenModeEnum screenMode;
  ProcessingStatusEnum initialStatus;
  TaskDetailDropdownsModel dropdownData;
  List<TaskConditionModel> mappingConditions;
  ProcessingStatusEnum loadingStatus;
  TaskDetailModel originalDetail;
  TaskDetailModel taskDetail;

  TaskDetailState({
    required this.screenMode,
    required this.initialStatus,
    required this.dropdownData,
    required this.mappingConditions,
    required this.loadingStatus,
    required this.originalDetail,
    required this.taskDetail,
  });

  TaskDetailState copyWith({
    ScreenModeEnum? screenMode,
    ProcessingStatusEnum? initialStatus,
    TaskDetailDropdownsModel? dropdownData,
    List<TaskConditionModel>? mappingConditions,
    ProcessingStatusEnum? loadingStatus,
    TaskDetailModel? originalDetail,
    TaskDetailModel? taskDetail,
  }) {
    return TaskDetailState(
      screenMode: screenMode ?? this.screenMode,
      initialStatus: initialStatus ?? this.initialStatus,
      dropdownData: dropdownData ?? this.dropdownData,
      mappingConditions: mappingConditions ?? this.mappingConditions,
      loadingStatus: loadingStatus ?? this.loadingStatus,
      taskDetail: taskDetail ?? this.taskDetail,
      originalDetail: originalDetail ?? this.originalDetail,
    );
  }
}
