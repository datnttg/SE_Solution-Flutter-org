class TaskFilterParameterModel {
  String? assignedDateStart;
  String? assignedDateEnd;
  List<String>? createdUserIds;
  List<String>? assignedUserIds;
  List<String>? taskStatuses;
  List<String>? taskTypes;

  TaskFilterParameterModel({
    this.assignedDateStart,
    this.assignedDateEnd,
    this.createdUserIds,
    this.assignedUserIds,
    this.taskStatuses,
    this.taskTypes,
  });

  Map<String, dynamic> toMap() {
    return {
      'assignedDateStart': assignedDateStart,
      'assignedDateEnd': assignedDateEnd,
      'createdUserIds': createdUserIds,
      'assignedUserIds': assignedUserIds,
      'taskStatuses': taskStatuses,
      'taskTypes': taskTypes,
    };
  }
}
