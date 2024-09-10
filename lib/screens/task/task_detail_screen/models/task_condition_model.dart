class TaskConditionModel {
  final String? id;
  final String? conditionEntity;
  final String? conditionProperty;
  final String? conditionValue;
  final String? mappingEntity;
  final String? mappingProperty;
  final String? requirementCode;

  TaskConditionModel({
    this.id,
    this.conditionEntity,
    this.conditionProperty,
    this.conditionValue,
    this.mappingEntity,
    this.mappingProperty,
    this.requirementCode,
  });

  factory TaskConditionModel.fromJson(Map<String, dynamic> json) {
    return TaskConditionModel(
      id: json['id'] as String?,
      conditionEntity: json['conditionEntity'] as String?,
      conditionProperty: json['conditionProperty'] as String?,
      conditionValue: json['conditionValue'] as String?,
      mappingEntity: json['mappingEntity'] as String?,
      mappingProperty: json['mappingProperty'] as String?,
      requirementCode: json['requirementCode'] as String?,
    );
  }

  static List<TaskConditionModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => TaskConditionModel.fromJson(json)).toList();
  }
}
