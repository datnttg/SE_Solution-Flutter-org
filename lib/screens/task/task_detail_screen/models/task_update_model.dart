class TaskUpdateModel {
  TaskAssignmentUpdateModel? taskAssignment;
  List<TaskMoreDetailUpdateModel>? moreDetail;
  List<TaskParticipantUpdateModel>? participants;
  List<TaskChecklistUpdateModel>? checklist;
  // List<TaskSubjectUpdateModel>? contactPoints;
  List<TaskSubjectUpdateModel>? subjects;
  List<TaskContractUpdateModel>? contracts;
  List<TaskConstructionUpdateModel>? constructions;

  TaskUpdateModel({
    this.taskAssignment,
    this.moreDetail,
    this.participants,
    this.checklist,
    // this.contactPoints,
    this.subjects,
    this.contracts,
    this.constructions,
  });

  TaskUpdateModel copyWith({
    TaskAssignmentUpdateModel? taskAssignment,
    List<TaskMoreDetailUpdateModel>? moreDetail,
    List<TaskParticipantUpdateModel>? participants,
    List<TaskChecklistUpdateModel>? checklist,
    List<TaskSubjectUpdateModel>? subjects,
    List<TaskContractUpdateModel>? contracts,
    List<TaskConstructionUpdateModel>? constructions,
  }) {
    return TaskUpdateModel(
      taskAssignment: taskAssignment ?? this.taskAssignment,
      moreDetail: moreDetail ?? this.moreDetail,
      participants: participants ?? this.participants,
      checklist: checklist ?? this.checklist,
      subjects: subjects ?? this.subjects,
      contracts: contracts ?? this.contracts,
      constructions: constructions ?? this.constructions,
    );
  }

  factory TaskUpdateModel.fromJson(Map<String, dynamic> json) {
    return TaskUpdateModel(
      taskAssignment: json['taskAssignment'] != null
          ? TaskAssignmentUpdateModel.fromJson(json['taskAssignment'])
          : null,
      moreDetail: json['moreDetail'] != null
          ? (json['moreDetail'] as List)
              .map((i) => TaskMoreDetailUpdateModel.fromJson(i))
              .toList()
          : null,
      participants: json['participants'] != null
          ? (json['participants'] as List)
              .map((i) => TaskParticipantUpdateModel.fromJson(i))
              .toList()
          : null,
      checklist: json['checklist'] != null
          ? (json['checklist'] as List)
              .map((i) => TaskChecklistUpdateModel.fromJson(i))
              .toList()
          : null,
      subjects: json['subjects'] != null
          ? (json['subjects'] as List)
              .map((i) => TaskSubjectUpdateModel.fromJson(i))
              .toList()
          : null,
      contracts: json['contracts'] != null
          ? (json['contracts'] as List)
              .map((i) => TaskContractUpdateModel.fromJson(i))
              .toList()
          : null,
      constructions: json['constructions'] != null
          ? (json['constructions'] as List)
              .map((i) => TaskConstructionUpdateModel.fromJson(i))
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

class TaskAssignmentUpdateModel {
  String? id;
  String? taskType;
  String? taskTitle;
  String? taskDescription;
  String? statusCode;
  String? lastProgressCode;
  String? categoryCode;
  String? assignedUserId;
  DateTime? deadline;
  DateTime? beginningDateTime;

  TaskAssignmentUpdateModel({
    this.id,
    this.taskType,
    this.taskTitle,
    this.taskDescription,
    this.statusCode,
    this.lastProgressCode,
    this.categoryCode,
    this.assignedUserId,
    this.deadline,
    this.beginningDateTime,
  });

  TaskAssignmentUpdateModel copyWith({
    String? id,
    String? taskType,
    String? taskTitle,
    String? taskDescription,
    String? statusCode,
    String? lastProgressCode,
    String? categoryCode,
    String? assignedUserId,
    DateTime? deadline,
    DateTime? beginningDateTime,
  }) {
    return TaskAssignmentUpdateModel(
      id: id ?? this.id,
      taskType: taskType ?? this.taskType,
      taskTitle: taskTitle ?? this.taskTitle,
      taskDescription: taskDescription ?? this.taskDescription,
      statusCode: statusCode ?? this.statusCode,
      lastProgressCode: lastProgressCode ?? this.lastProgressCode,
      categoryCode: categoryCode ?? this.categoryCode,
      assignedUserId: assignedUserId ?? this.assignedUserId,
      deadline: deadline ?? this.deadline,
      beginningDateTime: beginningDateTime ?? this.beginningDateTime,
    );
  }

  factory TaskAssignmentUpdateModel.fromJson(Map<String, dynamic> json) {
    return TaskAssignmentUpdateModel(
      id: json['id'],
      taskType: json['taskType'],
      taskTitle: json['taskTitle'],
      taskDescription: json['taskDescription'],
      statusCode: json['statusCode'],
      lastProgressCode: json['lastProgressCode'],
      categoryCode: json['categoryCode'],
      assignedUserId: json['assignedUserId'],
      deadline:
          json['deadline'] != null ? DateTime.parse(json['deadline']) : null,
      beginningDateTime: json['beginningDateTime'] != null
          ? DateTime.parse(json['beginningDateTime'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'taskType': taskType,
      'taskTitle': taskTitle,
      'taskDescription': taskDescription,
      'statusCode': statusCode,
      'lastProgressCode': lastProgressCode,
      'categoryCode': categoryCode,
      'assignedUserId': assignedUserId,
      'deadline': deadline?.toIso8601String(),
      'beginningDateTime': beginningDateTime?.toIso8601String(),
    };
  }
}

class TaskMoreDetailUpdateModel {
  String? id;
  String? taskId;
  String? taskDetailProperty;
  String? propertyDataType;
  String? taskDetailValue;

  TaskMoreDetailUpdateModel({
    this.id,
    this.taskId,
    this.taskDetailProperty,
    this.propertyDataType,
    this.taskDetailValue,
  });

  factory TaskMoreDetailUpdateModel.fromJson(Map<String, dynamic> json) {
    return TaskMoreDetailUpdateModel(
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

class TaskParticipantUpdateModel {
  String? userId;

  TaskParticipantUpdateModel({this.userId});

  factory TaskParticipantUpdateModel.fromJson(Map<String, dynamic> json) {
    return TaskParticipantUpdateModel(
      userId: json['userId'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
    };
  }
}

class TaskChecklistUpdateModel {
  String? id;
  String? taskId;
  String? text;
  bool? isComplete;
  int? order;

  TaskChecklistUpdateModel({
    this.id,
    this.taskId,
    this.text,
    this.isComplete,
    this.order,
  });

  factory TaskChecklistUpdateModel.fromJson(Map<String, dynamic> json) {
    return TaskChecklistUpdateModel(
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

class TaskSubjectUpdateModel {
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

  TaskSubjectUpdateModel({
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

  TaskSubjectUpdateModel copyWith({
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
    return TaskSubjectUpdateModel(
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

  factory TaskSubjectUpdateModel.fromJson(Map<String, dynamic> json) {
    return TaskSubjectUpdateModel(
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

class TaskContractUpdateModel {
  String? annexId;

  TaskContractUpdateModel({this.annexId});

  factory TaskContractUpdateModel.fromJson(Map<String, dynamic> json) {
    return TaskContractUpdateModel(
      annexId: json['annexId'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'annexId': annexId,
    };
  }
}

class TaskConstructionUpdateModel {
  String? id;

  TaskConstructionUpdateModel({this.id});

  factory TaskConstructionUpdateModel.fromJson(Map<String, dynamic> json) {
    return TaskConstructionUpdateModel(
      id: json['id'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
    };
  }
}
