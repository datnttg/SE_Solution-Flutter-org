import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se_solution_ori/utilities/configs.dart';

import '../../../../utilities/app_service.dart';
import '../../../../utilities/constants/core_constants.dart';
import '../../../../utilities/enums/ui_enums.dart';
import '../../task_filter_screen/bloc/task_filter_services.dart';
import '../models/task_detail_dropdowns_model.dart';
import '../models/task_detail_model.dart';
import '../models/task_update_model.dart';
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
    taskDetail: TaskDetailModel(),
    taskUpdate: TaskUpdateModel(),
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
    on<TaskBeginningTimeChanged>(_onTaskBeginningTimeChanged);
    on<TaskDeadlineChanged>(_onTaskDeadlineChanged);
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
      taskUpdate: TaskUpdateModel(
        taskAssignment: TaskAssignmentUpdateModel(),
      ),
    ));
  }

  Future<void> _onTaskIdChanged(
      TaskIdChanged event, Emitter<TaskDetailState> emit) async {
    await _onTaskDataInitializing(TaskDataInitializing(), emit);

    TaskDetailModel? taskDetail;
    TaskUpdateModel? taskUpdate;
    if (event.id != null && event.id!.isNotEmpty) {
      taskDetail = await getTaskDetail(event.id!);
      if (taskDetail != null) {
        taskUpdate = TaskUpdateModel.fromJson(taskDetail.toMap());
      }
    }
    emit(state.copyWith(
      taskDetail: taskDetail,
      taskUpdate: taskUpdate,
      initialStatus: ProcessingStatusEnum.success,
      loadingStatus: ProcessingStatusEnum.success,
      screenMode: event.id == '' ? ScreenModeEnum.edit : ScreenModeEnum.view,
    ));
  }

  void _onTaskTypeChanged(
      TaskTypeChanged event, Emitter<TaskDetailState> emit) {
    var showSubject = state.mappingConditions.any((e) =>
        e.conditionValue == state.taskUpdate.taskAssignment?.taskType &&
        e.mappingEntity == 'AppSubject');
    var showTaskTitle = event.taskType != 'Basic';
    emit(state.copyWith(
        taskUpdate: state.taskUpdate.copyWith(
      taskAssignment: state.taskUpdate.taskAssignment?.copyWith(
        taskType: event.taskType,
        taskTitle: showTaskTitle == true
            ? state.taskUpdate.taskAssignment?.taskTitle
            : null,
      ),
      subjects: showSubject == true
          ? state.taskUpdate.subjects
          : [TaskSubjectUpdateModel()],
    )));
  }

  void _onTaskTitleChanged(
      TaskTitleChanged event, Emitter<TaskDetailState> emit) {
    emit(state.copyWith(
        taskUpdate: state.taskUpdate.copyWith(
            taskAssignment: state.taskUpdate.taskAssignment
                ?.copyWith(taskTitle: event.title))));
  }

  void _onTaskDescriptionChanged(
      TaskDescriptionChanged event, Emitter<TaskDetailState> emit) {
    emit(state.copyWith(
        taskUpdate: state.taskUpdate.copyWith(
            taskAssignment: state.taskUpdate.taskAssignment
                ?.copyWith(taskDescription: event.description))));
  }

  void _onTaskStatusChanged(
      TaskStatusChanged event, Emitter<TaskDetailState> emit) {
    emit(state.copyWith(
        taskUpdate: state.taskUpdate.copyWith(
            taskAssignment: state.taskUpdate.taskAssignment
                ?.copyWith(statusCode: event.status))));
  }

  void _onTaskCategoryChanged(
      TaskCategoryChanged event, Emitter<TaskDetailState> emit) {
    emit(state.copyWith(
        taskUpdate: state.taskUpdate.copyWith(
            taskAssignment: state.taskUpdate.taskAssignment
                ?.copyWith(categoryCode: event.category))));
  }

  void _onTaskAssignedUsersChanged(
      TaskAssignedUsersChanged event, Emitter<TaskDetailState> emit) {
    emit(state.copyWith(
        taskUpdate: state.taskUpdate.copyWith(
            taskAssignment: state.taskUpdate.taskAssignment
                ?.copyWith(assignedUserId: event.assignedUserIds?[0]))));
  }

  void _onTaskBeginningTimeChanged(
      TaskBeginningTimeChanged event, Emitter<TaskDetailState> emit) {
    var beginningDateTime = df0ConvertedFromDf2(event.beginningTime!);
    emit(state.copyWith(
        taskUpdate: state.taskUpdate.copyWith(
            taskAssignment: state.taskUpdate.taskAssignment?.copyWith(
                beginningDateTime: (event.beginningTime?.isNotEmpty ?? false)
                    ? df0.parse(beginningDateTime)
                    : null))));
  }

  void _onTaskDeadlineChanged(
      TaskDeadlineChanged event, Emitter<TaskDetailState> emit) {
    var deadline = df0ConvertedFromDf2(event.deadline!);
    emit(state.copyWith(
        taskUpdate: state.taskUpdate.copyWith(
            taskAssignment: state.taskUpdate.taskAssignment?.copyWith(
                deadline: (event.deadline?.isNotEmpty ?? false)
                    ? df0.parse(deadline)
                    : null))));
  }

  void _onTaskMoreDetailChanged(
      TaskMoreDetailChanged event, Emitter<TaskDetailState> emit) {
    emit(state.copyWith(
        taskUpdate: state.taskUpdate.copyWith(moreDetail: event.moreDetail)));
  }

  void _onTaskParticipantsChanged(
      TaskParticipantsChanged event, Emitter<TaskDetailState> emit) {
    emit(state.copyWith(
        taskUpdate:
            state.taskUpdate.copyWith(participants: event.participants)));
  }

  void _onTaskChecklistChanged(
      TaskChecklistChanged event, Emitter<TaskDetailState> emit) {
    emit(state.copyWith(
        taskUpdate: state.taskUpdate.copyWith(checklist: event.checklist)));
  }

  void _onTaskContactPointsChanged(
      TaskContactPointsChanged event, Emitter<TaskDetailState> emit) {
    emit(state.copyWith(
        taskUpdate: state.taskUpdate.copyWith(subjects: event.contactPoints)));
  }

  void _onTaskContractsChanged(
      TaskContractsChanged event, Emitter<TaskDetailState> emit) {
    emit(state.copyWith(
        taskUpdate: state.taskUpdate.copyWith(contracts: event.contracts)));
  }

  void _onTaskConstructionsChanged(
      TaskConstructionsChanged event, Emitter<TaskDetailState> emit) {
    emit(state.copyWith(
        taskUpdate:
            state.taskUpdate.copyWith(constructions: event.constructions)));
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
      parameters: state.taskUpdate.toMap(),
      showFailureNotification: true,
    );
    if (response['success'] == true) {
      add(TaskIdChanged(state.taskDetail.taskAssignment?.id));
    }
  }

  void _onTaskDiscardChanges(
      TaskDiscardChanges event, Emitter<TaskDetailState> emit) {
    emit(state.copyWith(loadingStatus: ProcessingStatusEnum.processing));
    emit(state.copyWith(
      taskUpdate: TaskUpdateModel.fromJson(state.taskDetail.toMap()),
      loadingStatus: ProcessingStatusEnum.success,
      screenMode: ScreenModeEnum.view,
    ));
  }
}
