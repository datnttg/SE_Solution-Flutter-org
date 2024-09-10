import '../../../../utilities/enums/ui_enums.dart';
import '../models/task_filter_dropdowns_model.dart';
import '../models/task_filter_item_model.dart';
import '../models/task_filter_parameters_model.dart';

class TaskFilterState {
  TaskFilterParameters? parameters;

  ProcessingStatusEnum? initialStatus;
  TaskFilterDropdownsModel? dropdownData;

  ProcessingStatusEnum? loadingStatus;
  List<TaskFilterItemModel>? tasks;
  String? selectedId;

  TaskFilterState({
    this.parameters,
    this.initialStatus = ProcessingStatusEnum.processing,
    this.dropdownData,
    this.loadingStatus = ProcessingStatusEnum.processing,
    this.tasks,
    this.selectedId,
  });

  TaskFilterState copyWith({
    TaskFilterParameters? parameters,
    ProcessingStatusEnum? initialStatus,
    TaskFilterDropdownsModel? dropdownData,
    ProcessingStatusEnum? loadingStatus,
    List<TaskFilterItemModel>? tasks,
    String? selectedId,
  }) {
    return TaskFilterState(
      parameters: parameters ?? this.parameters,
      initialStatus: initialStatus ?? this.initialStatus,
      dropdownData: dropdownData ?? this.dropdownData,
      loadingStatus: loadingStatus ?? this.loadingStatus,
      tasks: tasks ?? this.tasks,
      selectedId: selectedId ?? this.selectedId,
    );
  }
}
