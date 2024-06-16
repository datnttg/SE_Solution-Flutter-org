class TaskCheckListModel {
  int? id;
  int? taskId;
  String name;
  bool isComplete;
  int order;

  TaskCheckListModel({
    this.id,
    this.taskId,
    required this.name,
    this.isComplete = false,
    this.order = 0,
  });

  factory TaskCheckListModel.fromJson(Map<String, dynamic> json) {
    return TaskCheckListModel(
      id: json['id'],
      taskId: json['taskId'],
      name: json['name'],
      isComplete: json['isComplete'] ?? false,
      order: json['order'] ?? 0,
    );
  }
}
