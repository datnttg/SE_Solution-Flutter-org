class ChildProductModel {
  final String childId;
  final int quantityOfChild;
  final String note;

  ChildProductModel({
    required this.childId,
    required this.quantityOfChild,
    required this.note,
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
