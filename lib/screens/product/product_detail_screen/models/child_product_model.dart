class ChildProductModel {
  String? childId;
  double? quantityOfChild;
  String? note;

  ChildProductModel({
    this.childId,
    this.quantityOfChild,
    this.note,
  });

  factory ChildProductModel.fromJson(Map<String, dynamic> json) {
    return ChildProductModel(
      childId: json['childId'],
      quantityOfChild: json['quantityOfChild'],
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
