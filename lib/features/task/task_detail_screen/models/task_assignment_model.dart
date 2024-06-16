class TaskAssignmentModel {
  final String? id;
  final String? createdUserId;
  final String? createdTime;
  final String? taskType;
  final String? taskTitle;
  final String? taskDescription;
  final String? statusCode;
  final String? categoryCode;
  final String? userIdAssigned;
  final String? userNameAssigned;
  final String? deadline;
  final String? beginningDateTime;

  TaskAssignmentModel({
    this.id,
    this.createdTime,
    this.createdUserId,
    this.taskType,
    this.taskTitle,
    this.taskDescription,
    this.statusCode,
    this.categoryCode,
    this.userIdAssigned,
    this.userNameAssigned,
    this.deadline,
    this.beginningDateTime,
  });

  factory TaskAssignmentModel.fromJson(Map<String, dynamic> json) {
    return TaskAssignmentModel(
      id: json['id'] as String,
      createdUserId: json['createdUserId'] as String,
      createdTime: json['createdTime'],
      taskType: json['taskType'] as String,
      taskTitle: json['taskTitle'] as String,
      taskDescription: json['taskDescription'] as String,
      statusCode: json['statusCode'] as String?,
      categoryCode: json['categoryCode'] as String?,
      userIdAssigned: json['userIdAssigned'] as String,
      userNameAssigned: json['userNameAssigned'] as String,
      deadline: json['deadline'],
      beginningDateTime: json['beginningDateTime'],
    );
  }
}
