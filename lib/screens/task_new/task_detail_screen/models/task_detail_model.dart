class TaskDetailModel {
  TaskAssignment? taskAssignment;
  List<MoreDetail>? moreDetail;
  List<Participant>? participants;
  List<Checklist>? checklist;
  // List<Subject>? contactPoints;
  List<Subject>? subjects;
  List<Contract>? contracts;
  List<Construction>? constructions;

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
    TaskAssignment? taskAssignment,
    List<MoreDetail>? moreDetail,
    List<Participant>? participants,
    List<Checklist>? checklist,
    List<Subject>? subjects,
    List<Contract>? contracts,
    List<Construction>? constructions,
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
          ? TaskAssignment.fromJson(json['taskAssignment'])
          : null,
      moreDetail: json['moreDetail'] != null
          ? (json['moreDetail'] as List)
              .map((i) => MoreDetail.fromJson(i))
              .toList()
          : null,
      participants: json['participants'] != null
          ? (json['participants'] as List)
              .map((i) => Participant.fromJson(i))
              .toList()
          : null,
      checklist: json['checklist'] != null
          ? (json['checklist'] as List)
              .map((i) => Checklist.fromJson(i))
              .toList()
          : null,
      subjects: json['subjects'] != null
          ? (json['subjects'] as List).map((i) => Subject.fromJson(i)).toList()
          : null,
      contracts: json['contracts'] != null
          ? (json['contracts'] as List)
              .map((i) => Contract.fromJson(i))
              .toList()
          : null,
      constructions: json['constructions'] != null
          ? (json['constructions'] as List)
              .map((i) => Construction.fromJson(i))
              .toList()
          : null,
    );
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

class TaskAssignment {
  String? id;
  String? taskType;
  String? taskTitle;
  String? taskDescription;
  String? statusCode;
  String? taskStatusTitle;
  String? categoryCode;
  String? taskCategoryTitle;
  String? assignedUserId;
  String? userNameAssigned;
  String? deadline;
  String? beginningDateTime;

  TaskAssignment({
    this.id,
    this.taskType,
    this.taskTitle,
    this.taskDescription,
    this.statusCode,
    this.taskStatusTitle,
    this.categoryCode,
    this.taskCategoryTitle,
    this.assignedUserId,
    this.userNameAssigned,
    this.deadline,
    this.beginningDateTime,
  });

  TaskAssignment copyWith({
    String? id,
    String? taskType,
    String? taskTitle,
    String? taskDescription,
    String? statusCode,
    String? taskStatusTitle,
    String? categoryCode,
    String? taskCategoryTitle,
    String? assignedUserId,
    String? userNameAssigned,
    String? deadline,
    String? beginningDateTime,
  }) {
    return TaskAssignment(
      id: id ?? this.id,
      taskType: taskType ?? this.taskType,
      taskTitle: taskTitle ?? this.taskTitle,
      taskDescription: taskDescription ?? this.taskDescription,
      statusCode: statusCode ?? this.statusCode,
      taskStatusTitle: taskStatusTitle ?? this.taskStatusTitle,
      categoryCode: categoryCode ?? this.categoryCode,
      taskCategoryTitle: taskCategoryTitle ?? this.taskCategoryTitle,
      assignedUserId: assignedUserId ?? this.assignedUserId,
      userNameAssigned: userNameAssigned ?? this.userNameAssigned,
      deadline: deadline ?? this.deadline,
      beginningDateTime: beginningDateTime ?? this.beginningDateTime,
    );
  }

  factory TaskAssignment.fromJson(Map<String, dynamic> json) {
    return TaskAssignment(
      id: json['id'] as String?,
      taskType: json['taskType'] as String?,
      taskTitle: json['taskTitle'] as String?,
      taskDescription: json['taskDescription'] as String?,
      statusCode: json['statusCode'] as String?,
      taskStatusTitle: json['taskStatusTitle'] as String?,
      categoryCode: json['categoryCode'] as String?,
      taskCategoryTitle: json['taskCategoryTitle'] as String?,
      assignedUserId: json['assignedUserId'] as String?,
      userNameAssigned: json['userNameAssigned'] as String?,
      deadline: json['deadline'],
      beginningDateTime: json['beginningDateTime'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'taskType': taskType,
      'taskTitle': taskTitle,
      'taskDescription': taskDescription,
      'statusCode': statusCode,
      'taskStatusTitle': taskStatusTitle,
      'categoryCode': categoryCode,
      'taskCategoryTitle': taskCategoryTitle,
      'assignedUserId': assignedUserId,
      'userNameAssigned': userNameAssigned,
      'deadline': deadline,
      'beginningDateTime': beginningDateTime,
    };
  }
}

class MoreDetail {
  String? id;
  String? taskId;
  String? taskDetailProperty;
  String? propertyDataType;
  String? taskDetailValue;

  MoreDetail({
    this.id,
    this.taskId,
    this.taskDetailProperty,
    this.propertyDataType,
    this.taskDetailValue,
  });

  factory MoreDetail.fromJson(Map<String, dynamic> json) {
    return MoreDetail(
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

class Participant {
  String? userId;

  Participant({this.userId});

  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(
      userId: json['userId'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
    };
  }
}

class Checklist {
  String? id;
  String? taskId;
  String? text;
  bool? isComplete;
  int? order;

  Checklist({
    this.id,
    this.taskId,
    this.text,
    this.isComplete,
    this.order,
  });

  factory Checklist.fromJson(Map<String, dynamic> json) {
    return Checklist(
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

class Subject {
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

  Subject({
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

  Subject copyWith({
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
    return Subject(
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

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
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

class Contract {
  String? annexId;

  Contract({this.annexId});

  factory Contract.fromJson(Map<String, dynamic> json) {
    return Contract(
      annexId: json['annexId'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'annexId': annexId,
    };
  }
}

class Construction {
  String? id;

  Construction({this.id});

  factory Construction.fromJson(Map<String, dynamic> json) {
    return Construction(
      id: json['id'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
    };
  }
}
