class ProductFilterItemModel {
  String? id;
  String? code;
  String? name;
  String? description;
  String? unitCode;
  String? unitText;
  String? statusCode;
  String? statusText;
  bool? serialRequired;
  int? monthsOfWarranty;
  double? minPrice;
  String? categoryCode;
  String? categoryText;
  String? typeCode;
  String? typeText;

  ProductFilterItemModel({
    this.id,
    this.code,
    this.name,
    this.description,
    this.unitCode,
    this.unitText,
    this.statusCode,
    this.statusText,
    this.serialRequired,
    this.monthsOfWarranty,
    this.minPrice,
    this.categoryCode,
    this.categoryText,
    this.typeCode,
    this.typeText,
  });

  factory ProductFilterItemModel.fromJson(Map<String, dynamic> json) {
    return ProductFilterItemModel(
      id: json['id'],
      code: json['code'],
      name: json['name'],
      description: json['description'],
      unitCode: json['unitCode'],
      unitText: json['unitText'],
      statusCode: json['statusCode'],
      statusText: json['statusText'],
      serialRequired: json['serialRequired'],
      monthsOfWarranty: json['monthsOfWarranty'],
      minPrice: (json['minPrice'] as num?)?.toDouble(),
      categoryCode: json['categoryCode'],
      categoryText: json['categoryText'],
      typeCode: json['typeCode'],
      typeText: json['typeText'],
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
      'statusCode': statusCode,
      'statusText': statusText,
      'serialRequired': serialRequired,
      'monthsOfWarranty': monthsOfWarranty,
      'minPrice': minPrice,
      'categoryCode': categoryCode,
      'categoryText': categoryText,
      'typeCode': typeCode,
      'typeText': typeText,
    };
  }
}
