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
  String? lastProgressCode;
  String? lastProgressText;
  String? assignedUserId;
  String? assignedName;
  String? deadline;
  String? beginningDateTime;
  String? createdTime;
  String? createdUserId;
  String? createdName;
  int? waitingProposal;
  List<TaskParticipantModel>? participants;
  List<TaskSubjectModel>? subjects;
  dynamic moreDetail;

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
    this.lastProgressCode,
    this.lastProgressText,
    this.assignedUserId,
    this.assignedName,
    this.deadline,
    this.beginningDateTime,
    this.createdTime,
    this.createdUserId,
    this.createdName,
    this.waitingProposal,
    this.participants,
    this.subjects,
    this.moreDetail,
  });

  // fromJson method
  factory TaskFilterItemModel.fromJson(Map<String, dynamic> json) {
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
      lastProgressCode: json['lastProgressCode'],
      lastProgressText: json['lastProgressText'],
      assignedUserId: json['assignedUserId'],
      assignedName: json['assignedName'],
      deadline: json['deadline'],
      beginningDateTime: json['beginningDateTime'],
      createdTime: json['createdTime'],
      createdUserId: json['createdUserId'],
      createdName: json['createdName'],
      waitingProposal: json['waitingProposal'],
      participants: json['participants'] != null
          ? List<TaskParticipantModel>.from(
              json['participants'].map((x) => TaskParticipantModel.fromJson(x)))
          : null,
      subjects: json['subjects'] != null
          ? List<TaskSubjectModel>.from(
              json['subjects'].map((x) => TaskSubjectModel.fromJson(x)))
          : null,
      moreDetail: json['moreDetail'],
    );
  }

  // toMap method
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
      'lastProgressCode': lastProgressCode,
      'lastProgressText': lastProgressText,
      'assignedUserId': assignedUserId,
      'assignedName': assignedName,
      'deadline': deadline,
      'beginningDateTime': beginningDateTime,
      'createdTime': createdTime,
      'createdUserId': createdUserId,
      'createdName': createdName,
      'waitingProposal': waitingProposal,
      'participants': participants?.map((x) => x.toMap()).toList(),
      'subjects': subjects?.map((x) => x.toMap()).toList(),
      'moreDetail': moreDetail,
    };
  }
}

class TaskParticipantModel {
  String? participantUserId;
  String? participantName;
  TaskParticipantModel({this.participantUserId, this.participantName});

  factory TaskParticipantModel.fromJson(Map<String, dynamic> json) {
    return TaskParticipantModel(
      participantUserId: json['participantUserId'] as String?,
      participantName: json['participantName'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'participantUserId': participantUserId,
      'participantName': participantName,
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
      id: json['id'] as String?,
      type: json['type'] as String?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      customerSource: json['customerSource'] as String?,
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
