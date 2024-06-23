class ChildProductModel {
  String childId;
  double quantityOfChild;
  String? note;

  ChildProductModel({
    required this.childId,
    required this.quantityOfChild,
    this.note,
  });

  factory ChildProductModel.fromJson(Map<String, dynamic> json) {
    return ChildProductModel(
      childId: json['childId'],
      quantityOfChild: json['QuantityOfChild'],
      note: json['note'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'childId': childId,
      'QuantityOfChild': quantityOfChild,
      'note': note,
    };
  }
}
