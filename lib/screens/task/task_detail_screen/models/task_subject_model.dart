class TaskSubjectModel {
  String type;
  String name;
  String phone;
  String customerSource;

  TaskSubjectModel({
    required this.type,
    required this.name,
    required this.phone,
    required this.customerSource,
  });

  factory TaskSubjectModel.fromJson(Map<String, dynamic> json) {
    return TaskSubjectModel(
      type: json['type'],
      name: json['name'],
      phone: json['phone'],
      customerSource: json['customerSource'],
    );
  }
}
