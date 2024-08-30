import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utilities/app_service.dart';
import '../../../../utilities/constants/core_constants.dart';
import '../../../../utilities/enums/ui_enums.dart';
import '../../task_filter_screen/bloc/task_filter_services.dart';
import '../models/task_detail_dropdowns_model.dart';
import '../models/task_detail_model.dart';
import 'task_detail_events.dart';
import 'task_detail_services.dart';
import 'task_detail_states.dart';

class TaskDetailBloc extends Bloc<ChangeTaskDetailEvents, TaskDetailState> {
  static final initialState = TaskDetailState(
    screenMode: ScreenModeEnum.view,
    initialStatus: ProcessingStatusEnum.processing,
    dropdownData: TaskDetailDropdownsModel(
      taskTypes: [],
      taskCategories: [],
      creators: [],
      participants: [],
      assignedUsers: [],
    ),
    mappingConditions: [],
    loadingStatus: ProcessingStatusEnum.processing,
    originalDetail: TaskDetailModel(),
    taskDetail: TaskDetailModel(),
  );

  TaskDetailBloc() : super(initialState) {
    on<ScreenModeChanged>(_onScreenModeChanged);
    on<TaskDataInitializing>(_onTaskDataInitializing);
    on<TaskIdChanged>(_onTaskIdChanged);
    on<TaskTypeChanged>(_onTaskTypeChanged);
    on<TaskTitleChanged>(_onTaskTitleChanged);
    on<TaskDescriptionChanged>(_onTaskDescriptionChanged);
    on<TaskStatusChanged>(_onTaskStatusChanged);
    on<TaskCategoryChanged>(_onTaskCategoryChanged);
    on<TaskAssignedUsersChanged>(_onTaskAssignedUsersChanged);
    on<TaskDeadlineChanged>(_onTaskDeadlineChanged);
    on<TaskBeginningTimeChanged>(_onTaskBeginningTimeChanged);
    on<TaskMoreDetailChanged>(_onTaskMoreDetailChanged);
    on<TaskParticipantsChanged>(_onTaskParticipantsChanged);
    on<TaskChecklistChanged>(_onTaskChecklistChanged);
    on<TaskContactPointsChanged>(_onTaskContactPointsChanged);
    on<TaskContractsChanged>(_onTaskContractsChanged);
    on<TaskConstructionsChanged>(_onTaskConstructionsChanged);
    on<TaskSaving>(_onTaskSaving);
    on<TaskDiscardChanges>(_onTaskDiscardChanges);
  }

  Future<void> _onTaskDataInitializing(
      TaskDataInitializing event, Emitter<TaskDetailState> emit) async {
    emit(state.copyWith(
      initialStatus: ProcessingStatusEnum.processing,
      loadingStatus: ProcessingStatusEnum.processing,
    ));
    var types = await fetchTaskCategoryEntries(categoryProperty: 'TaskType');
    var categories =
        await fetchTaskCategoryEntries(categoryProperty: 'TaskCategory');
    var users = await fetchTaskUserEntries();
    var mappingConditions = await fetchTaskConditionMappings({
      "conditionEntity": "TskCategory",
      "conditionProperty": "TaskType",
      "conditionValue": "",
      "mappingEntity": "",
      "mappingProperty": "",
      "statusCode": "",
    });
    emit(state.copyWith(
      initialStatus: ProcessingStatusEnum.success,
      loadingStatus: ProcessingStatusEnum.processing,
      dropdownData: TaskDetailDropdownsModel(
        taskTypes: types,
        taskCategories: categories,
        creators: users,
        assignedUsers: users,
        participants: users,
      ),
      mappingConditions: mappingConditions,
      taskDetail: TaskDetailModel(
        taskAssignment: TaskAssignment(),
      ),
    ));
  }

  Future<void> _onTaskIdChanged(
      TaskIdChanged event, Emitter<TaskDetailState> emit) async {
    await _onTaskDataInitializing(TaskDataInitializing(), emit);

    TaskDetailModel? taskDetail;
    if (event.id != null && event.id!.isNotEmpty) {
      taskDetail = await getTaskDetail(event.id!);
    }
    emit(state.copyWith(
      originalDetail: taskDetail,
      taskDetail: taskDetail,
      initialStatus: ProcessingStatusEnum.success,
      loadingStatus: ProcessingStatusEnum.success,
      screenMode: event.id == '' ? ScreenModeEnum.edit : ScreenModeEnum.view,
    ));
  }

  void _onTaskTypeChanged(
      TaskTypeChanged event, Emitter<TaskDetailState> emit) {
    var showSubject = state.mappingConditions.any((e) =>
        e.conditionValue == state.taskDetail.taskAssignment?.taskType &&
        e.mappingEntity == 'AppSubject');
    var showTaskTitle = event.taskType != 'Basic';
    emit(state.copyWith(
        taskDetail: state.taskDetail.copyWith(
      taskAssignment: state.taskDetail.taskAssignment?.copyWith(
        taskType: event.taskType,
        taskTitle: showTaskTitle == true
            ? state.taskDetail.taskAssignment?.taskTitle
            : null,
      ),
      subjects: showSubject == true ? state.taskDetail.subjects : [Subject()],
    )));
  }

  void _onTaskTitleChanged(
      TaskTitleChanged event, Emitter<TaskDetailState> emit) {
    emit(state.copyWith(
        taskDetail: state.taskDetail.copyWith(
            taskAssignment: state.taskDetail.taskAssignment
                ?.copyWith(taskTitle: event.title))));
  }

  void _onTaskDescriptionChanged(
      TaskDescriptionChanged event, Emitter<TaskDetailState> emit) {
    emit(state.copyWith(
        taskDetail: state.taskDetail.copyWith(
            taskAssignment: state.taskDetail.taskAssignment
                ?.copyWith(taskDescription: event.description))));
  }

  void _onTaskStatusChanged(
      TaskStatusChanged event, Emitter<TaskDetailState> emit) {
    emit(state.copyWith(
        taskDetail: state.taskDetail.copyWith(
            taskAssignment: state.taskDetail.taskAssignment
                ?.copyWith(statusCode: event.status))));
  }

  void _onTaskCategoryChanged(
      TaskCategoryChanged event, Emitter<TaskDetailState> emit) {
    emit(state.copyWith(
        taskDetail: state.taskDetail.copyWith(
            taskAssignment: state.taskDetail.taskAssignment
                ?.copyWith(categoryCode: event.category))));
  }

  void _onTaskAssignedUsersChanged(
      TaskAssignedUsersChanged event, Emitter<TaskDetailState> emit) {
    emit(state.copyWith(
        taskDetail: state.taskDetail.copyWith(
            taskAssignment: state.taskDetail.taskAssignment
                ?.copyWith(assignedUserId: event.assignedUserIds?[0]))));
  }

  void _onTaskDeadlineChanged(
      TaskDeadlineChanged event, Emitter<TaskDetailState> emit) {
    emit(state.copyWith(
        taskDetail: state.taskDetail.copyWith(
            taskAssignment: state.taskDetail.taskAssignment
                ?.copyWith(deadline: event.deadline))));
  }

  void _onTaskBeginningTimeChanged(
      TaskBeginningTimeChanged event, Emitter<TaskDetailState> emit) {
    emit(state.copyWith(
        taskDetail: state.taskDetail.copyWith(
            taskAssignment: state.taskDetail.taskAssignment
                ?.copyWith(beginningDateTime: event.beginningTime))));
  }

  void _onTaskMoreDetailChanged(
      TaskMoreDetailChanged event, Emitter<TaskDetailState> emit) {
    emit(state.copyWith(
        taskDetail: state.taskDetail.copyWith(moreDetail: event.moreDetail)));
  }

  void _onTaskParticipantsChanged(
      TaskParticipantsChanged event, Emitter<TaskDetailState> emit) {
    emit(state.copyWith(
        taskDetail:
            state.taskDetail.copyWith(participants: event.participants)));
  }

  void _onTaskChecklistChanged(
      TaskChecklistChanged event, Emitter<TaskDetailState> emit) {
    emit(state.copyWith(
        taskDetail: state.taskDetail.copyWith(checklist: event.checklist)));
  }

  void _onTaskContactPointsChanged(
      TaskContactPointsChanged event, Emitter<TaskDetailState> emit) {
    emit(state.copyWith(
        taskDetail: state.taskDetail.copyWith(subjects: event.contactPoints)));
  }

  void _onTaskContractsChanged(
      TaskContractsChanged event, Emitter<TaskDetailState> emit) {
    emit(state.copyWith(
        taskDetail: state.taskDetail.copyWith(contracts: event.contracts)));
  }

  void _onTaskConstructionsChanged(
      TaskConstructionsChanged event, Emitter<TaskDetailState> emit) {
    emit(state.copyWith(
        taskDetail:
            state.taskDetail.copyWith(constructions: event.constructions)));
  }

  void _onScreenModeChanged(
      ScreenModeChanged event, Emitter<TaskDetailState> emit) {
    emit(state.copyWith(screenMode: event.screenMode));
  }

  Future<void> _onTaskSaving(
      TaskSaving event, Emitter<TaskDetailState> emit) async {
    // emit(state.copyWith(loadingStatus: ProcessingStatusEnum.processing));
    var hostAddress = Uri.parse("${constants.hostAddress}/Task/Update");
    var response = await fetchData(
      hostAddress,
      parameters: state.taskDetail.toMap(),
      showFailureNotification: true,
    );
    if (response['success'] == true) {
      add(TaskIdChanged(state.taskDetail.taskAssignment?.id));
    }
  }

  void _onTaskDiscardChanges(
      TaskDiscardChanges event, Emitter<TaskDetailState> emit) {
    emit(state.copyWith(loadingStatus: ProcessingStatusEnum.processing));
    var originalDetail = state.originalDetail;
    emit(state.copyWith(
      taskDetail: originalDetail,
      loadingStatus: ProcessingStatusEnum.success,
      screenMode: ScreenModeEnum.view,
    ));
  }
}
