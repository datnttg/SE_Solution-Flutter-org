class TaskParticipantModel {
  final String? userId;
  final String? displayName;

  TaskParticipantModel({
    this.userId,
    this.displayName,
  });

  factory TaskParticipantModel.fromJson(Map<String, dynamic> json) {
    return TaskParticipantModel(
      userId: json['userId'] as String,
      displayName: json['displayName'] as String,
    );
  }
}
