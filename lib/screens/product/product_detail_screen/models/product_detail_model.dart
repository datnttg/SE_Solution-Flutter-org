import 'child_product_model.dart';

class ProductDetailModel {
  String? id;
  String? code;
  String? name;
  String? description;
  String? unitCode;
  String? unitText;
  String? categoryCode;
  String? categoryText;
  bool? serialRequired;
  int? monthsOfWarranty;
  double? minPrice;
  List<ChildProductModel>? children;

  ProductDetailModel({
    this.id,
    this.code,
    this.name,
    this.description,
    this.unitCode,
    this.unitText,
    this.categoryCode,
    this.categoryText,
    this.serialRequired,
    this.monthsOfWarranty,
    this.minPrice,
    this.children,
  });

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailModel(
      id: json['id'],
      code: json['code'],
      name: json['name'],
      description: json['description'],
      unitCode: json['unitCode'],
      unitText: json['unitText'],
      categoryCode: json['categoryCode'],
      categoryText: json['categoryText'],
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
      'unitText': unitText,
      'categoryCode': categoryCode,
      'categoryText': categoryText,
      'serialRequired': serialRequired,
      'monthsOfWarranty': monthsOfWarranty,
      'minPrice': minPrice,
      'children': children?.map((x) => x.toMap()).toList(),
    };
  }
}
