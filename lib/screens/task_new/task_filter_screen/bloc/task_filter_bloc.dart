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
    on<TaskFilterListLoading>(_onTaskFilterListLoading);
    on<TaskFilterCreatedTimeChanged>(_onChangeCreatedTime);
    on<TaskFilterCreatedUsersChanged>(_onChangeCreatedUsers);
    on<TaskFilterAssignedUsersChanged>(_onChangeAssignedUsers);
    on<TaskFilterParticipantsChanged>(_onChangeParticipants);
    on<TaskFilterLastProgressesChanged>(_onChangeLastProgress);
    on<TaskFilterStatusesChanged>(_onChangeStatuses);
    on<TaskFilterTypesChanged>(_onChangeTypes);
    on<TaskFilterListChanged>(_onChangeFilterList);
    on<SelectedFilterItemChanged>(_changeSelectedItem);
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
    add(TaskFilterListLoading());
  }

  Future<void> _onTaskFilterListLoading(
      TaskFilterListLoading event, Emitter<TaskFilterState> emit) async {
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

  void _onChangeCreatedTime(
      TaskFilterCreatedTimeChanged event, Emitter<TaskFilterState> emit) {
    var timeRange = event.timeRange?.split(" - ");
    var assignedDateStart = timeRange?[0];
    var assignedDateEnd = timeRange?[1];
    state.parameters?.copyWith(
      assignedDateStart: assignedDateStart,
      assignedDateEnd: assignedDateEnd,
    );
    add(TaskFilterListLoading());
  }

  void _onChangeCreatedUsers(
      TaskFilterCreatedUsersChanged event, Emitter<TaskFilterState> emit) {
    state.parameters?.copyWith(
        createdUserIds: event.createdUsers == null
            ? []
            : event.createdUsers!
                .map<String>((e) => e.value.toString())
                .toList());
    add(TaskFilterListLoading());
  }

  void _onChangeAssignedUsers(
      TaskFilterAssignedUsersChanged event, Emitter<TaskFilterState> emit) {
    state.parameters?.copyWith(
        assignedUserIds: event.assignedUsers == null
            ? []
            : event.assignedUsers!
                .map<String>((e) => e.value.toString())
                .toList());
    add(TaskFilterListLoading());
  }

  void _onChangeParticipants(
      TaskFilterParticipantsChanged event, Emitter<TaskFilterState> emit) {
    state.parameters?.copyWith(
        participantUserIds: event.participantUsers == null
            ? []
            : event.participantUsers!
                .map<String>((e) => e.value.toString())
                .toList());
    add(TaskFilterListLoading());
  }

  void _onChangeLastProgress(
      TaskFilterLastProgressesChanged event, Emitter<TaskFilterState> emit) {
    state.parameters?.copyWith(
        lastProgresses: event.lastProgresses == null
            ? []
            : event.lastProgresses!
                .map<String>((e) => e.value.toString())
                .toList());
    add(TaskFilterListLoading());
  }

  void _onChangeStatuses(
      TaskFilterStatusesChanged event, Emitter<TaskFilterState> emit) {
    state.parameters?.copyWith(
        taskStatuses: event.taskStatuses == null
            ? []
            : event.taskStatuses!
                .map<String>((e) => e.value.toString())
                .toList());
    add(TaskFilterListLoading());
  }

  void _onChangeFilterList(
      TaskFilterListChanged event, Emitter<TaskFilterState> emit) {
    state.copyWith(tasks: event.list);
    add(TaskFilterListLoading());
  }

  void _onChangeTypes(
      TaskFilterTypesChanged event, Emitter<TaskFilterState> emit) {
    state.parameters?.copyWith(
        taskTypes:
            event.taskTypes!.map<String>((e) => e.value.toString()).toList());
    add(TaskFilterListLoading());
  }

  void _changeSelectedItem(
      SelectedFilterItemChanged event, Emitter<TaskFilterState> emit) {
    emit(state.copyWith(selectedId: event.selectedId));
  }

  String? getSelectedId() {
    return state.selectedId;
  }
}
