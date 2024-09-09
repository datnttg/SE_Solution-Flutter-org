import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utilities/configs.dart';
import '../../../../utilities/enums/ui_enums.dart';
import '../models/task_filter_dropdowns_model.dart';
import '../models/task_filter_parameters_model.dart';
import 'task_filter_events.dart';
import 'task_filter_services.dart';
import 'task_filter_states.dart';

class TaskFilterBloc extends Bloc<TaskFilterEvents, TaskFilterState> {
  static final initialState = TaskFilterState(
    parameters: TaskFilterParameters(),
    dropdownData: TaskFilterDropdownsModel(),
    tasks: [],
  );

  TaskFilterBloc() : super(initialState) {
    on<InitTaskFilterData>(_onInitData);
    on<TaskFilterCreatedTimeChanged>(_onCreatedTimeChanged);
    on<TaskFilterCreatedUsersChanged>(_onCreatedUsersChanged);
    on<TaskFilterAssignedUsersChanged>(_onAssignedUsersChanged);
    on<TaskFilterParticipantsChanged>(_onParticipantsChanged);
    on<TaskFilterLastProgressesChanged>(_onLastProgressesChanged);
    on<TaskFilterStatusesChanged>(_onStatusesChanged);
    on<TaskFilterTypesChanged>(_onTypesChanged);
    on<TaskFilterSubmitted>(_onTaskFilterSubmitted);
    on<SelectedFilterItemChanged>(_onSelectedItemChanged);
  }

  Future<void> _onInitData(
      InitTaskFilterData? event, Emitter<TaskFilterState> emit) async {
    var types = await fetchTaskCategoryEntries(categoryProperty: 'TaskType');
    var statuses =
        await fetchTaskCategoryEntries(categoryProperty: 'TaskStatus');
    var lastProgresses =
        await fetchTaskCategoryEntries(categoryProperty: 'TaskProgress');
    var users = await fetchTaskUserEntries();

    emit(state.copyWith(
      parameters: state.parameters?.copyWith(
        assignedDateStart: df0.format(DateTime(DateTime.now().year,
            DateTime.now().month - 1, DateTime.now().day + 1)),
        assignedDateEnd: df0.format(DateTime(DateTime.now().year,
            DateTime.now().month, DateTime.now().day, 23, 59, 59)),
      ),
      initialStatus: ProcessingStatusEnum.success,
      dropdownData: TaskFilterDropdownsModel(
        createdUsers: users,
        assignedUsers: users,
        participantUsers: users,
        lastProgresses: lastProgresses,
        taskStatuses: statuses,
        taskTypes: types,
      ),
      loadingStatus: ProcessingStatusEnum.processing,
      tasks: [],
      selectedId: null,
    ));
    add(TaskFilterSubmitted());
  }

  void _onCreatedTimeChanged(
      TaskFilterCreatedTimeChanged event, Emitter<TaskFilterState> emit) {
    var timeRange = event.timeRange?.split(" - ");
    var assignedDateStart = timeRange?[0];
    var assignedDateEnd = timeRange?[1];
    state.parameters?.copyWith(
      assignedDateStart: assignedDateStart,
      assignedDateEnd: assignedDateEnd,
    );
    add(TaskFilterSubmitted());
  }

  void _onCreatedUsersChanged(
      TaskFilterCreatedUsersChanged event, Emitter<TaskFilterState> emit) {
    emit(state.copyWith(
        parameters: state.parameters?.copyWith(
            createdUserIds: event.createdUsers == null
                ? []
                : event.createdUsers!
                    .map<String>((e) => e.value.toString())
                    .toList())));
    add(TaskFilterSubmitted());
  }

  void _onAssignedUsersChanged(
      TaskFilterAssignedUsersChanged event, Emitter<TaskFilterState> emit) {
    emit(state.copyWith(
        parameters: state.parameters?.copyWith(
            assignedUserIds: event.assignedUsers == null
                ? []
                : event.assignedUsers!
                    .map<String>((e) => e.value.toString())
                    .toList())));
    add(TaskFilterSubmitted());
  }

  void _onParticipantsChanged(
      TaskFilterParticipantsChanged event, Emitter<TaskFilterState> emit) {
    emit(state.copyWith(
        parameters: state.parameters?.copyWith(
            participantUserIds: event.participantUsers == null
                ? []
                : event.participantUsers!
                    .map<String>((e) => e.value.toString())
                    .toList())));
    add(TaskFilterSubmitted());
  }

  void _onLastProgressesChanged(
      TaskFilterLastProgressesChanged event, Emitter<TaskFilterState> emit) {
    emit(state.copyWith(
        parameters: state.parameters?.copyWith(
            lastProgresses: event.lastProgresses == null
                ? []
                : event.lastProgresses!
                    .map<String>((e) => e.value.toString())
                    .toList())));
    add(TaskFilterSubmitted());
  }

  void _onStatusesChanged(
      TaskFilterStatusesChanged event, Emitter<TaskFilterState> emit) {
    emit(state.copyWith(
        parameters: state.parameters?.copyWith(
            taskStatuses: event.taskStatuses == null
                ? []
                : event.taskStatuses!
                    .map<String>((e) => e.value.toString())
                    .toList())));
    add(TaskFilterSubmitted());
  }

  void _onTypesChanged(
      TaskFilterTypesChanged event, Emitter<TaskFilterState> emit) {
    emit(state.copyWith(
        parameters: state.parameters?.copyWith(
            taskTypes: event.taskTypes == null
                ? []
                : event.taskTypes!
                    .map<String>((e) => e.value.toString())
                    .toList())));
    add(TaskFilterSubmitted());
  }

  Future<void> _onTaskFilterSubmitted(
      TaskFilterSubmitted event, Emitter<TaskFilterState> emit) async {
    emit(state.copyWith(
      initialStatus: ProcessingStatusEnum.success,
      loadingStatus: ProcessingStatusEnum.processing,
    ));

    var filterList = await fetchTaskList(state.parameters);
    emit(state.copyWith(
      tasks: filterList,
      initialStatus: ProcessingStatusEnum.success,
      loadingStatus: ProcessingStatusEnum.success,
    ));
  }

  void _onSelectedItemChanged(
      SelectedFilterItemChanged event, Emitter<TaskFilterState> emit) {
    emit(state.copyWith(selectedId: event.selectedId));
  }

  String? getSelectedId() {
    return state.selectedId;
  }
}
