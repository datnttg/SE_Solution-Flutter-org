import '../../../../utilities/classes/custom_widget_models.dart';

abstract class TaskFilterEvents {}

class InitTaskFilterData extends TaskFilterEvents {
  InitTaskFilterData();
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

class TaskFilterSubmitted extends TaskFilterEvents {
  TaskFilterSubmitted();
}

class SelectedFilterItemChanged extends TaskFilterEvents {
  String? selectedId;
  SelectedFilterItemChanged(this.selectedId);
}
