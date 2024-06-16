class TaskMoreDetailModel {
  final String? taskDetailProperty;
  final String? propertyDataType;
  final String? taskDetailValue;

  TaskMoreDetailModel({
    this.taskDetailProperty,
    this.propertyDataType,
    this.taskDetailValue,
  });

  factory TaskMoreDetailModel.fromJson(Map<String, dynamic> json) {
    return TaskMoreDetailModel(
      taskDetailProperty: json['taskDetailProperty'] as String,
      propertyDataType: json['propertyDataType'] as String,
      taskDetailValue: json['taskDetailValue'] as String,
    );
  }
}
