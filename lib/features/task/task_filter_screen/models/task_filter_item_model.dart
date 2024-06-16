class TaskFilterItemModel {
  String? taskId;
  String? taskType;
  String? taskTypeTitle;
  String? categoryCode;
  String? taskCategoryTitle;
  String? taskTitle;
  String? taskDescription;
  String? taskStatusCode;
  String? taskStatusText;
  String? userIdAssigned;
  String? assignedName;
  String? deadline;
  String? beginningDateTime;
  String? createdTime;
  String? createdUserId;
  String? createdName;
  List<ParticipantModel>? participants;
  List<TaskDetailModel>? moreDetail;
  List<TaskSubjectModel>? subjects;

  TaskFilterItemModel({
    this.taskId,
    this.taskType,
    this.taskTypeTitle,
    this.categoryCode,
    this.taskCategoryTitle,
    this.taskTitle,
    this.taskDescription,
    this.taskStatusCode,
    this.taskStatusText,
    this.userIdAssigned,
    this.assignedName,
    this.deadline,
    this.beginningDateTime,
    this.createdTime,
    this.createdUserId,
    this.createdName,
    this.participants,
    this.moreDetail,
    this.subjects,
  });

  factory TaskFilterItemModel.fromJson(Map<String, dynamic> json) {
    try {
      return TaskFilterItemModel(
        taskId: json['taskId'],
        taskType: json['taskType'],
        taskTypeTitle: json['taskTypeTitle'],
        categoryCode: json['categoryCode'],
        taskCategoryTitle: json['taskCategoryTitle'],
        taskTitle: json['taskTitle'],
        taskDescription: json['taskDescription'],
        taskStatusCode: json['taskStatusCode'],
        taskStatusText: json['taskStatusText'],
        userIdAssigned: json['userIdAssigned'],
        assignedName: json['assignedName'],
        deadline: json['deadline'],
        beginningDateTime: json['beginningDateTime'],
        createdTime: json['createdTime'],
        createdUserId: json['createdUserId'],
        createdName: json['createdName'],
        participants: List<ParticipantModel>.from(
          json['participants']?.map((e) => ParticipantModel.fromJson(e)),
        ),
        moreDetail: List<TaskDetailModel>.from(
          json['moreDetail']?.map((e) => TaskDetailModel.fromJson(e)),
        ),
        subjects: List<TaskSubjectModel>.from(
          json['subjects']?.map((e) => TaskSubjectModel.fromJson(e)),
        ),
      );
    } catch (ex) {
      return TaskFilterItemModel();
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'taskId': taskId,
      'taskType': taskType,
      'taskTypeTitle': taskTypeTitle,
      'categoryCode': categoryCode,
      'taskCategoryTitle': taskCategoryTitle,
      'taskTitle': taskTitle,
      'taskDescription': taskDescription,
      'taskStatusCode': taskStatusCode,
      'taskStatusText': taskStatusText,
      'userIdAssigned': userIdAssigned,
      'assignedName': assignedName,
      'deadline': deadline,
      'beginningDateTime': beginningDateTime,
      'createdTime': createdTime,
      'createdUserId': createdUserId,
      'createdName': createdName,
      'participants': participants?.map((p) => p.toMap()).toList(),
      'moreDetail': moreDetail?.map((d) => d.toMap()).toList(),
      'subjects': subjects?.map((s) => s.toMap()).toList(),
    };
  }
}

class ParticipantModel {
  final String? participantUserId;
  final String? participantName;

  ParticipantModel({
    this.participantUserId,
    this.participantName,
  });

  factory ParticipantModel.fromJson(Map<String, dynamic> json) {
    return ParticipantModel(
      participantUserId: json['participantUserId'],
      participantName: json['participantName'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'participantUserId': participantUserId,
      'participantName': participantName,
    };
  }
}

class TaskDetailModel {
  final String? taskDetailProperty;
  final String? propertyDataType;
  final String? taskDetailValue;

  TaskDetailModel({
    this.taskDetailProperty,
    this.propertyDataType,
    this.taskDetailValue,
  });

  factory TaskDetailModel.fromJson(Map<String, dynamic> json) {
    return TaskDetailModel(
      taskDetailProperty: json['taskDetailProperty'],
      propertyDataType: json['propertyDataType'],
      taskDetailValue: json['taskDetailValue'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'taskDetailProperty': taskDetailProperty,
      'propertyDataType': propertyDataType,
      'taskDetailValue': taskDetailValue,
    };
  }
}

class TaskSubjectModel {
  String? id;
  String? type;
  String? name;
  String? phone;
  String? address;
  String? customerSource;

  TaskSubjectModel({
    this.id,
    this.type,
    this.name,
    this.phone,
    this.address,
    this.customerSource,
  });

  factory TaskSubjectModel.fromJson(Map<String, dynamic> json) {
    return TaskSubjectModel(
      id: json['id'],
      type: json['type'],
      name: json['name'],
      phone: json['phone'],
      address: json['address'],
      customerSource: json['customerSource'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'name': name,
      'phone': phone,
      'address': address,
      'customerSource': customerSource,
    };
  }
}
