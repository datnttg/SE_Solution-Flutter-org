import '../../../../utilities/classes/custom_widget_models.dart';
import '../models/task_filter_item_model.dart';

abstract class TaskFilterEvents {}

class InitTaskFilterData extends TaskFilterEvents {
  InitTaskFilterData();
}

class TaskFilterListLoading extends TaskFilterEvents {
  TaskFilterListLoading();
}

class TaskFilterCreatedTimeChanged extends TaskFilterEvents {
  String? timeRange;
  TaskFilterCreatedTimeChanged(this.timeRange);
}

class TaskFilterCreatedUsersChanged extends TaskFilterEvents {
  List<CDropdownMenuEntry>? createdUsers;
  TaskFilterCreatedUsersChanged(this.createdUsers);
}

class TaskFilterAssignedUsersChanged extends TaskFilterEvents {
  List<CDropdownMenuEntry>? assignedUsers;
  TaskFilterAssignedUsersChanged(this.assignedUsers);
}

class TaskFilterParticipantsChanged extends TaskFilterEvents {
  List<CDropdownMenuEntry>? participantUsers;
  TaskFilterParticipantsChanged(this.participantUsers);
}

class TaskFilterLastProgressesChanged extends TaskFilterEvents {
  List<CDropdownMenuEntry>? lastProgresses;
  TaskFilterLastProgressesChanged(this.lastProgresses);
}

class TaskFilterStatusesChanged extends TaskFilterEvents {
  List<CDropdownMenuEntry>? taskStatuses;
  TaskFilterStatusesChanged(this.taskStatuses);
}

class TaskFilterTypesChanged extends TaskFilterEvents {
  List<CDropdownMenuEntry>? taskTypes;
  TaskFilterTypesChanged(this.taskTypes);
}

class TaskFilterListChanged extends TaskFilterEvents {
  List<TaskFilterItemModel>? list;
  TaskFilterListChanged(this.list);
}

class SelectedFilterItemChanged extends TaskFilterEvents {
  String? selectedId;
  SelectedFilterItemChanged(this.selectedId);
}
