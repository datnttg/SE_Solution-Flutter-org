import 'dart:convert';

class TaskModel {
  final Map? taskAssignment;
  final List<TaskReferenceSubjectModel>? referenceSubjects;
  final List<TaskProjectModel>? projects;

  const TaskModel({this.taskAssignment, this.referenceSubjects, this.projects});

  Map<String, dynamic> toJson() => {
        "taskAssignment": jsonEncode(taskAssignment),
        "referenceSubjects": jsonEncode(jsonEncode),
        "projects": jsonEncode(projects),
      };
}

class TaskAssignemntModel {
  const TaskAssignemntModel({
    this.id,
    this.customerSource,
    this.taskDescription,
    this.taskStatus,
    this.taskCategoryId,
    this.userIdAssigned,
    this.deadline,
    this.beginningDateTime,
    this.contractAddendumId,
    this.contractAddendumOldId,
    this.countryId,
    this.provinceId,
    this.districtId,
    this.wardId,
    this.addressDetail,
    this.taskTypeId,
    this.taskTitle,
  });

  final String? id,
      taskTypeId,
      taskTitle,
      taskDescription,
      taskStatus,
      taskCategoryId,
      userIdAssigned,
      beginningDateTime,
      contractAddendumId,
      contractAddendumOldId,
      countryId,
      provinceId,
      districtId,
      wardId,
      addressDetail,
      customerSource,
      deadline;
  // final DateTime? deadline;

  Map<String, dynamic> toJson() => {
        'taskTypeId': taskTypeId,
        'taskTitle': taskTitle,
        'taskDescription': taskDescription,
        'taskStatus': taskStatus,
        'taskCategoryId': taskCategoryId,
        'userIdAssigned': userIdAssigned,
        'deadline': deadline,
        'beginningDateTime': beginningDateTime,
        'contractAddendumId': contractAddendumId,
        'contractAddendumOldId': contractAddendumOldId,
        'countryId': countryId,
        'provinceId': provinceId,
        'districtId': districtId,
        'wardId': wardId,
        'addressDetail': addressDetail,
        'customerSource': customerSource,
      };
}

class TaskReferenceSubjectModel {
  final String? name;
  final String? phone;
  final String? address;
  final String? customerSource;

  const TaskReferenceSubjectModel({
    this.customerSource,
    this.address,
    this.name,
    this.phone,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "address": address,
        "customerSource": customerSource,
      };
}

class TaskProjectModel {
  final String? annexId;
  final String? annexStatus;
  final String? annexCode;
  final String? contractCode;
  final String? contactName;
  final String? contactPhone;
  final String? countryId;
  final String? provinceId;
  final String? districtId;
  final String? wardId;
  final String? address;
  final String? note;

  const TaskProjectModel({
    this.annexId,
    this.annexStatus,
    this.annexCode,
    this.contractCode,
    this.contactName,
    this.contactPhone,
    this.countryId,
    this.provinceId,
    this.districtId,
    this.wardId,
    this.address,
    this.note,
  });

  Map<String, dynamic> toJson() => {
        "annexId": annexId,
        "annexStatus": annexStatus,
        "annexCode": annexCode,
        "contractCode": contractCode,
        "contactName": contactName,
        "contactPhone": contactPhone,
        "countryId": countryId,
        "provinceId": provinceId,
        "districtId": districtId,
        "wardId": wardId,
        "address": address,
        "note": note
      };
}
