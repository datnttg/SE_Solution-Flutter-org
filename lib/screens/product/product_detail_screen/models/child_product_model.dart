class ChildProductModel {
  String? childId;
  double? quantityOfChild;
  String? unitCode;
  String? note;

  ChildProductModel({
    this.childId,
    this.quantityOfChild = 0,
    this.unitCode,
    this.note,
  });

  factory ChildProductModel.fromJson(Map<String, dynamic> json) {
    return ChildProductModel(
      childId: json['childId'],
      quantityOfChild: json['quantityOfChild'],
      unitCode: json['unitCode'],
      note: json['note'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'childId': childId,
      'quantityOfChild': quantityOfChild,
      'note': note,
    };
  }
}
