class TaskDetailModel {
  TaskAssignmentDetailModel? taskAssignment;
  List<TaskMoreDetailDetailModel>? moreDetail;
  List<TaskParticipantDetailModel>? participants;
  List<TaskChecklistDetailModel>? checklist;
  // List<TaskSubjectDetailModel>? contactPoints;
  List<TaskSubjectDetailModel>? subjects;
  List<TaskContractDetailModel>? contracts;
  List<TaskConstructionDetailModel>? constructions;

  TaskDetailModel({
    this.taskAssignment,
    this.moreDetail,
    this.participants,
    this.checklist,
    // this.contactPoints,
    this.subjects,
    this.contracts,
    this.constructions,
  });

  TaskDetailModel copyWith({
    TaskAssignmentDetailModel? taskAssignment,
    List<TaskMoreDetailDetailModel>? moreDetail,
    List<TaskParticipantDetailModel>? participants,
    List<TaskChecklistDetailModel>? checklist,
    List<TaskSubjectDetailModel>? subjects,
    List<TaskContractDetailModel>? contracts,
    List<TaskConstructionDetailModel>? constructions,
  }) {
    return TaskDetailModel(
      taskAssignment: taskAssignment ?? this.taskAssignment,
      moreDetail: moreDetail ?? this.moreDetail,
      participants: participants ?? this.participants,
      checklist: checklist ?? this.checklist,
      subjects: subjects ?? this.subjects,
      contracts: contracts ?? this.contracts,
      constructions: constructions ?? this.constructions,
    );
  }

  factory TaskDetailModel.fromJson(Map<String, dynamic> json) {
    return TaskDetailModel(
      taskAssignment: json['taskAssignment'] != null
          ? TaskAssignmentDetailModel.fromJson(json['taskAssignment'])
          : null,
      moreDetail: json['moreDetail'] != null
          ? (json['moreDetail'] as List)
              .map((i) => TaskMoreDetailDetailModel.fromJson(i))
              .toList()
          : null,
      participants: json['participants'] != null
          ? (json['participants'] as List)
              .map((i) => TaskParticipantDetailModel.fromJson(i))
              .toList()
          : null,
      checklist: json['checklist'] != null
          ? (json['checklist'] as List)
              .map((i) => TaskChecklistDetailModel.fromJson(i))
              .toList()
          : null,
      subjects: json['subjects'] != null
          ? (json['subjects'] as List)
              .map((i) => TaskSubjectDetailModel.fromJson(i))
              .toList()
          : null,
      contracts: json['contracts'] != null
          ? (json['contracts'] as List)
              .map((i) => TaskContractDetailModel.fromJson(i))
              .toList()
          : null,
      constructions: json['constructions'] != null
          ? (json['constructions'] as List)
              .map((i) => TaskConstructionDetailModel.fromJson(i))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'taskAssignment': taskAssignment?.toMap(),
      'moreDetail': moreDetail?.map((i) => i.toMap()).toList(),
      'participants': participants?.map((i) => i.toMap()).toList(),
      'checklist': checklist?.map((i) => i.toMap()).toList(),
      'subjects': subjects?.map((i) => i.toMap()).toList(),
      'contracts': contracts?.map((i) => i.toMap()).toList(),
      'constructions': constructions?.map((i) => i.toMap()).toList(),
    };
  }

  Map<String, String> toJson() {
    return {
      'taskAssignment': taskAssignment?.toMap().toString() ?? '',
      'moreDetail': moreDetail?.map((i) => i.toMap()).toList().toString() ?? '',
      'participants':
          participants?.map((i) => i.toMap()).toList().toString() ?? '',
      'checklist': checklist?.map((i) => i.toMap()).toList().toString() ?? '',
      'subjects': subjects?.map((i) => i.toMap()).toList().toString() ?? '',
      'contracts': contracts?.map((i) => i.toMap()).toList().toString() ?? '',
      'constructions':
          constructions?.map((i) => i.toMap()).toList().toString() ?? '',
    };
  }
}

class TaskAssignmentDetailModel {
  String? id;
  String? createdTime;
  String? createdUserId;
  String? createdName;
  String? taskType;
  String? taskTitle;
  String? taskDescription;
  String? statusCode;
  String? taskStatusText;
  String? lastProgressCode;
  String? lastProgressText;
  String? categoryCode;
  String? taskCategoryTitle;
  String? assignedUserId;
  String? assignedName;
  String? deadline;
  String? beginningDateTime;

  TaskAssignmentDetailModel({
    this.id,
    this.createdTime,
    this.createdUserId,
    this.createdName,
    this.taskType,
    this.taskTitle,
    this.taskDescription,
    this.statusCode,
    this.taskStatusText,
    this.lastProgressCode,
    this.lastProgressText,
    this.categoryCode,
    this.taskCategoryTitle,
    this.assignedUserId,
    this.assignedName,
    this.deadline,
    this.beginningDateTime,
  });

  TaskAssignmentDetailModel copyWith({
    String? id,
    String? createdTime,
    String? createdUserId,
    String? createdName,
    String? taskType,
    String? taskTitle,
    String? taskDescription,
    String? statusCode,
    String? taskStatusText,
    String? lastProgressCode,
    String? lastProgressText,
    String? categoryCode,
    String? taskCategoryTitle,
    String? assignedUserId,
    String? assignedName,
    String? deadline,
    String? beginningDateTime,
  }) {
    return TaskAssignmentDetailModel(
      id: id ?? this.id,
      createdTime: createdTime ?? this.createdTime,
      createdUserId: createdUserId ?? this.createdUserId,
      createdName: createdName ?? this.createdName,
      taskType: taskType ?? this.taskType,
      taskTitle: taskTitle ?? this.taskTitle,
      taskDescription: taskDescription ?? this.taskDescription,
      statusCode: statusCode ?? this.statusCode,
      taskStatusText: taskStatusText ?? this.taskStatusText,
      lastProgressCode: lastProgressCode ?? this.lastProgressCode,
      lastProgressText: lastProgressText ?? this.lastProgressText,
      categoryCode: categoryCode ?? this.categoryCode,
      taskCategoryTitle: taskCategoryTitle ?? this.taskCategoryTitle,
      assignedUserId: assignedUserId ?? this.assignedUserId,
      assignedName: assignedName ?? this.assignedName,
      deadline: deadline ?? this.deadline,
      beginningDateTime: beginningDateTime ?? this.beginningDateTime,
    );
  }

  factory TaskAssignmentDetailModel.fromJson(Map<String, dynamic> json) {
    return TaskAssignmentDetailModel(
      id: json['id'],
      createdTime: json['createdTime'],
      createdUserId: json['createdUserId'],
      createdName: json['createdName'],
      taskType: json['taskType'],
      taskTitle: json['taskTitle'],
      taskDescription: json['taskDescription'],
      statusCode: json['statusCode'],
      taskStatusText: json['taskStatusText'],
      lastProgressCode: json['lastProgressCode'],
      lastProgressText: json['lastProgressText'],
      categoryCode: json['categoryCode'],
      taskCategoryTitle: json['taskCategoryTitle'],
      assignedUserId: json['assignedUserId'],
      assignedName: json['assignedName'],
      deadline: json['deadline'],
      beginningDateTime: json['beginningDateTime'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'createdTime': createdTime,
      'createdUserId': createdUserId,
      'createdName': createdName,
      'taskType': taskType,
      'taskTitle': taskTitle,
      'taskDescription': taskDescription,
      'statusCode': statusCode,
      'taskStatusText': taskStatusText,
      'lastProgressCode': lastProgressCode,
      'lastProgressText': lastProgressText,
      'categoryCode': categoryCode,
      'taskCategoryTitle': taskCategoryTitle,
      'assignedUserId': assignedUserId,
      'assignedName': assignedName,
      'deadline': deadline,
      'beginningDateTime': beginningDateTime,
    };
  }
}

class TaskMoreDetailDetailModel {
  String? id;
  String? taskId;
  String? taskDetailProperty;
  String? propertyDataType;
  String? taskDetailValue;

  TaskMoreDetailDetailModel({
    this.id,
    this.taskId,
    this.taskDetailProperty,
    this.propertyDataType,
    this.taskDetailValue,
  });

  factory TaskMoreDetailDetailModel.fromJson(Map<String, dynamic> json) {
    return TaskMoreDetailDetailModel(
      id: json['id'] as String?,
      taskId: json['taskId'] as String?,
      taskDetailProperty: json['taskDetailProperty'] as String?,
      propertyDataType: json['propertyDataType'] as String?,
      taskDetailValue: json['taskDetailValue'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'taskId': taskId,
      'taskDetailProperty': taskDetailProperty,
      'propertyDataType': propertyDataType,
      'taskDetailValue': taskDetailValue,
    };
  }
}

class TaskParticipantDetailModel {
  String? userId;

  TaskParticipantDetailModel({this.userId});

  factory TaskParticipantDetailModel.fromJson(Map<String, dynamic> json) {
    return TaskParticipantDetailModel(
      userId: json['userId'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
    };
  }
}

class TaskChecklistDetailModel {
  String? id;
  String? taskId;
  String? text;
  bool? isComplete;
  int? order;

  TaskChecklistDetailModel({
    this.id,
    this.taskId,
    this.text,
    this.isComplete,
    this.order,
  });

  factory TaskChecklistDetailModel.fromJson(Map<String, dynamic> json) {
    return TaskChecklistDetailModel(
      id: json['id'] as String?,
      taskId: json['taskId'] as String?,
      text: json['text'] as String?,
      isComplete: json['isComplete'] as bool?,
      order: json['order'] as int?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'taskId': taskId,
      'text': text,
      'isComplete': isComplete,
      'order': order,
    };
  }
}

class TaskSubjectDetailModel {
  String? id;
  String? type;
  String? name;
  String? phone;
  String? documentType;
  String? documentCode;
  String? address;
  String? issueDate;
  String? issuePlace;
  String? birthDate;
  String? representativeId;
  String? customerSource;

  TaskSubjectDetailModel({
    this.id,
    this.type,
    this.name,
    this.phone,
    this.documentType,
    this.documentCode,
    this.address,
    this.issueDate,
    this.issuePlace,
    this.birthDate,
    this.representativeId,
    this.customerSource,
  });

  TaskSubjectDetailModel copyWith({
    String? id,
    String? type,
    String? name,
    String? phone,
    String? documentType,
    String? documentCode,
    String? address,
    String? issueDate,
    String? issuePlace,
    String? birthDate,
    String? representativeId,
    String? customerSource,
  }) {
    return TaskSubjectDetailModel(
      id: id ?? this.id,
      type: type ?? this.type,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      documentType: documentType ?? this.documentType,
      documentCode: documentCode ?? this.documentCode,
      address: address ?? this.address,
      issueDate: issueDate ?? this.issueDate,
      issuePlace: issuePlace ?? this.issuePlace,
      birthDate: birthDate ?? this.birthDate,
      representativeId: representativeId ?? this.representativeId,
      customerSource: customerSource ?? this.customerSource,
    );
  }

  factory TaskSubjectDetailModel.fromJson(Map<String, dynamic> json) {
    return TaskSubjectDetailModel(
      id: json['id'] as String?,
      type: json['type'] as String?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      documentType: json['documentType'] as String?,
      documentCode: json['documentCode'] as String?,
      address: json['address'] as String?,
      issueDate: json['issueDate'],
      issuePlace: json['issuePlace'] as String?,
      birthDate: json['birthDate'],
      representativeId: json['representativeId'] as String?,
      customerSource: json['customerSource'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'name': name,
      'phone': phone,
      'documentType': documentType,
      'documentCode': documentCode,
      'address': address,
      'issueDate': issueDate,
      'issuePlace': issuePlace,
      'birthDate': birthDate,
      'representativeId': representativeId,
      'customerSource': customerSource,
    };
  }
}

class TaskContractDetailModel {
  String? annexId;

  TaskContractDetailModel({this.annexId});

  factory TaskContractDetailModel.fromJson(Map<String, dynamic> json) {
    return TaskContractDetailModel(
      annexId: json['annexId'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'annexId': annexId,
    };
  }
}

class TaskConstructionDetailModel {
  String? id;

  TaskConstructionDetailModel({this.id});

  factory TaskConstructionDetailModel.fromJson(Map<String, dynamic> json) {
    return TaskConstructionDetailModel(
      id: json['id'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
    };
  }
}
