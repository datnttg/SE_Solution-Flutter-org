import '../../../../utilities/classes/custom_widget_models.dart';

class TaskFilterDropdownsModel {
  List<CDropdownMenuEntry>? createdUsers;
  List<CDropdownMenuEntry>? assignedUsers;
  List<CDropdownMenuEntry>? participantUsers;
  List<CDropdownMenuEntry>? lastProgresses;
  List<CDropdownMenuEntry>? taskStatuses;
  List<CDropdownMenuEntry>? taskTypes;

  TaskFilterDropdownsModel({
    this.createdUsers,
    this.assignedUsers,
    this.participantUsers,
    this.lastProgresses,
    this.taskStatuses,
    this.taskTypes,
  });

  TaskFilterDropdownsModel copyWith({
    List<CDropdownMenuEntry>? createdUsers,
    List<CDropdownMenuEntry>? assignedUsers,
    List<CDropdownMenuEntry>? participantUsers,
    List<CDropdownMenuEntry>? lastProgresses,
    List<CDropdownMenuEntry>? taskStatuses,
    List<CDropdownMenuEntry>? taskTypes,
  }) {
    return TaskFilterDropdownsModel(
      createdUsers: createdUsers ?? this.createdUsers,
      assignedUsers: assignedUsers ?? this.assignedUsers,
      participantUsers: participantUsers ?? this.participantUsers,
      lastProgresses: lastProgresses ?? this.lastProgresses,
      taskStatuses: taskStatuses ?? this.taskStatuses,
      taskTypes: taskTypes ?? this.taskTypes,
    );
  }
}
