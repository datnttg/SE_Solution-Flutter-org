import '../models/child_product_model.dart';

class ProductDetailStates {
  String? id;
  String? code;
  String? name;
  String? description;
  String? unitCode;
  String? categoryCode;
  String? typeCode;
  bool? serialRequired;
  int? monthsOfWarranty;
  double? minPrice;
  List<ChildProductModel>? children;

  ProductDetailStates({
    this.id,
    this.code,
    this.name,
    this.description,
    this.unitCode,
    this.categoryCode,
    this.typeCode,
    this.serialRequired,
    this.monthsOfWarranty,
    this.minPrice,
    this.children,
  });

  factory ProductDetailStates.fromJson(Map<String, dynamic> json) {
    return ProductDetailStates(
      id: json['id'],
      code: json['code'],
      name: json['name'],
      description: json['description'],
      unitCode: json['unitCode'],
      categoryCode: json['categoryCode'],
      typeCode: json['typeCode'],
      serialRequired: json['serialRequired'],
      monthsOfWarranty: json['monthsOfWarranty'],
      minPrice: (json['minPrice'] as num).toDouble(),
      children: List<ChildProductModel>.from(
          json['children'].map((x) => ChildProductModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'description': description,
      'unitCode': unitCode,
      'categoryCode': categoryCode,
      'typeCode': typeCode,
      'serialRequired': serialRequired,
      'monthsOfWarranty': monthsOfWarranty,
      'minPrice': minPrice,
      'children': children?.map((x) => x.toMap()).toList(),
    };
  }
}
