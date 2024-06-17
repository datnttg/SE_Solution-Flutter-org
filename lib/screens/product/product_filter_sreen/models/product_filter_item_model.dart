class ProductFilterItemModel {
  String? id;
  String? code;
  String? name;
  String? description;
  String? unitCode;
  String? unitText;
  String? categoryCode;
  String? categoryText;
  bool? serialRequired;
  int? monthOfWarranty;
  double? minPrice;

  ProductFilterItemModel({
    this.id,
    this.code,
    this.name,
    this.description,
    this.unitCode,
    this.unitText,
    this.categoryCode,
    this.categoryText,
    this.serialRequired,
    this.monthOfWarranty,
    this.minPrice,
  });

  factory ProductFilterItemModel.fromJson(Map<String, dynamic> json) {
    return ProductFilterItemModel(
      id: json['id'],
      code: json['code'],
      name: json['name'],
      description: json['description'],
      unitCode: json['unitCode'],
      unitText: json['unitText'],
      categoryCode: json['categoryCode'],
      categoryText: json['categoryText'],
      serialRequired: json['serialRequired'],
      monthOfWarranty: json['monthOfWarranty'],
      minPrice: (json['minPrice'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'description': description,
      'unitCode': unitCode,
      'unitText': unitText,
      'categoryCode': categoryCode,
      'categoryText': categoryText,
      'serialRequired': serialRequired,
      'monthOfWarranty': monthOfWarranty,
      'minPrice': minPrice,
    };
  }
}
