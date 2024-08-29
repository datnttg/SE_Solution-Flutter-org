import '../../../../utilities/enums/ui_enums.dart';
import '../models/task_detail_dropdowns_model.dart';
import '../models/task_detail_model.dart';

class TaskDetailState {
  ScreenModeEnum screenMode;
  ProcessingStatusEnum initialStatus;
  TaskDetailDropdownsModel dropdownData;
  ProcessingStatusEnum loadingStatus;
  TaskDetailModel taskDetail;

  TaskDetailState({
    required this.screenMode,
    required this.initialStatus,
    required this.dropdownData,
    required this.loadingStatus,
    required this.taskDetail,
  });

  TaskDetailState copyWith({
    ScreenModeEnum? screenMode,
    ProcessingStatusEnum? initialStatus,
    TaskDetailDropdownsModel? dropdownData,
    ProcessingStatusEnum? loadingStatus,
    TaskDetailModel? taskDetail,
  }) {
    return TaskDetailState(
      screenMode: screenMode ?? this.screenMode,
      initialStatus: initialStatus ?? this.initialStatus,
      dropdownData: dropdownData ?? this.dropdownData,
      loadingStatus: loadingStatus ?? this.loadingStatus,
      taskDetail: taskDetail ?? this.taskDetail,
    );
  }
}
