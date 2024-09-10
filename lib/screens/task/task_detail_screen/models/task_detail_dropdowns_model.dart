import '../../../../utilities/classes/custom_widget_models.dart';

class TaskDetailDropdownsModel {
  List<CDropdownMenuEntry>? taskTypes;
  List<CDropdownMenuEntry>? taskCategories;
  List<CDropdownMenuEntry>? creators;
  List<CDropdownMenuEntry>? participants;
  List<CDropdownMenuEntry>? assignedUsers;

  TaskDetailDropdownsModel({
    this.taskTypes,
    this.taskCategories,
    this.creators,
    this.assignedUsers,
    this.participants,
  });

  TaskDetailDropdownsModel copyWith({
    List<CDropdownMenuEntry>? taskTypes,
    List<CDropdownMenuEntry>? taskCategories,
    List<CDropdownMenuEntry>? creators,
    List<CDropdownMenuEntry>? participants,
    List<CDropdownMenuEntry>? assignedUsers,
  }) {
    return TaskDetailDropdownsModel(
      taskTypes: taskTypes ?? this.taskTypes,
      taskCategories: taskCategories ?? this.taskCategories,
      creators: creators ?? this.creators,
      participants: participants ?? this.participants,
      assignedUsers: assignedUsers ?? this.assignedUsers,
    );
  }
}
