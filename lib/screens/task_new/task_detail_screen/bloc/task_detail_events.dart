import '../../../../utilities/enums/ui_enums.dart';
import '../models/task_detail_model.dart';

abstract class ChangeTaskDetailEvents {}

class ScreenModeChanged extends ChangeTaskDetailEvents {
  ScreenModeEnum? screenMode;
  ScreenModeChanged(this.screenMode);
}

class TaskDataInitializing extends ChangeTaskDetailEvents {}

class TaskIdChanged extends ChangeTaskDetailEvents {
  String? id;
  TaskIdChanged(this.id);
}

class TaskTypeChanged extends ChangeTaskDetailEvents {
  String? taskType;
  TaskTypeChanged(this.taskType);
}

class TaskTitleChanged extends ChangeTaskDetailEvents {
  String? title;
  TaskTitleChanged(this.title);
}

class TaskDescriptionChanged extends ChangeTaskDetailEvents {
  String? description;
  TaskDescriptionChanged(this.description);
}

class TaskStatusChanged extends ChangeTaskDetailEvents {
  String? status;
  TaskStatusChanged(this.status);
}

class TaskCategoryChanged extends ChangeTaskDetailEvents {
  String? category;
  TaskCategoryChanged(this.category);
}

class TaskAssignedUsersChanged extends ChangeTaskDetailEvents {
  List<String>? assignedUserIds;
  TaskAssignedUsersChanged(this.assignedUserIds);
}

class TaskDeadlineChanged extends ChangeTaskDetailEvents {
  String? deadline;
  TaskDeadlineChanged(this.deadline);
}

class TaskBeginningTimeChanged extends ChangeTaskDetailEvents {
  String? beginningTime;
  TaskBeginningTimeChanged(this.beginningTime);
}

class TaskMoreDetailChanged extends ChangeTaskDetailEvents {
  List<MoreDetail>? moreDetail;
  TaskMoreDetailChanged(this.moreDetail);
}

class TaskParticipantsChanged extends ChangeTaskDetailEvents {
  List<Participant>? participants;
  TaskParticipantsChanged(this.participants);
}

class TaskChecklistChanged extends ChangeTaskDetailEvents {
  List<Checklist>? checklist;
  TaskChecklistChanged(this.checklist);
}

class TaskContactPointsChanged extends ChangeTaskDetailEvents {
  List<Subject>? contactPoints;
  TaskContactPointsChanged(this.contactPoints);
}

class TaskContractsChanged extends ChangeTaskDetailEvents {
  List<Contract>? contracts;
  TaskContractsChanged(this.contracts);
}

class TaskConstructionsChanged extends ChangeTaskDetailEvents {
  List<Construction>? constructions;
  TaskConstructionsChanged(this.constructions);
}

class TaskSaving extends ChangeTaskDetailEvents {
  TaskDetailModel data;
  TaskSaving(this.data);
}

class TaskDiscardChanges extends ChangeTaskDetailEvents {
  TaskDiscardChanges();
}
