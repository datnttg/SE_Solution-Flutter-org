class TaskFilterParameters {
  String? assignedDateStart;
  String? assignedDateEnd;
  List<String>? createdUserIds;
  List<String>? assignedUserIds;
  List<String>? participantUserIds;
  List<String>? lastProgresses;
  List<String>? taskStatuses;
  List<String>? taskTypes;

  TaskFilterParameters({
    this.assignedDateStart,
    this.assignedDateEnd,
    this.createdUserIds,
    this.assignedUserIds,
    this.participantUserIds,
    this.lastProgresses,
    this.taskStatuses,
    this.taskTypes,
  });

  TaskFilterParameters copyWith({
    String? assignedDateStart,
    String? assignedDateEnd,
    List<String>? createdUserIds,
    List<String>? assignedUserIds,
    List<String>? participantUserIds,
    List<String>? lastProgresses,
    List<String>? taskStatuses,
    List<String>? taskTypes,
  }) {
    return TaskFilterParameters(
      assignedDateStart: assignedDateStart ?? this.assignedDateStart,
      assignedDateEnd: assignedDateEnd ?? this.assignedDateEnd,
      createdUserIds: createdUserIds ?? this.createdUserIds,
      assignedUserIds: assignedUserIds ?? this.assignedUserIds,
      participantUserIds: participantUserIds ?? this.participantUserIds,
      lastProgresses: lastProgresses ?? this.lastProgresses,
      taskStatuses: taskStatuses ?? this.taskStatuses,
      taskTypes: taskTypes ?? this.taskTypes,
    );
  }

  factory TaskFilterParameters.fromJson(Map<String, dynamic> json) {
    return TaskFilterParameters(
      assignedDateStart: json['assignedDateStart'],
      assignedDateEnd: json['assignedDateEnd'],
      createdUserIds: json['createdUserIds'] != null
          ? List<String>.from(json['createdUserIds'])
          : null,
      assignedUserIds: json['assignedUserIds'] != null
          ? List<String>.from(json['assignedUserIds'])
          : null,
      participantUserIds: json['participantUserIds'] != null
          ? List<String>.from(json['participantUserIds'])
          : null,
      lastProgresses: json['lastProgresses'] != null
          ? List<String>.from(json['lastProgresses'])
          : null,
      taskStatuses: json['taskStatuses'] != null
          ? List<String>.from(json['taskStatuses'])
          : null,
      taskTypes: json['taskTypes'] != null
          ? List<String>.from(json['taskTypes'])
          : null,
    );
  }

  // toMap method
  Map<String, dynamic> toMap() {
    return {
      'assignedDateStart': assignedDateStart,
      'assignedDateEnd': assignedDateEnd,
      'createdUserIds': createdUserIds,
      'assignedUserIds': assignedUserIds,
      'participantUserIds': participantUserIds,
      'lastProgresses': lastProgresses,
      'taskStatuses': taskStatuses,
      'taskTypes': taskTypes,
    };
  }
}
