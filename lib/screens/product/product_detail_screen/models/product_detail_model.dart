class ProductDetailModel {
  String? id;
  String? code;
  String? name;
  String? description;
  String? unitCode;
  String? unitText;
  String? statusCode;
  String? statusText;
  String? categoryCode;
  String? categoryText;
  String? typeCode;
  String? typeText;
  bool? serialRequired;
  int? monthsOfWarranty;
  double? minPrice;
  List<ChildProductDetailModel>? children;

  ProductDetailModel({
    this.id,
    this.code,
    this.name,
    this.description,
    this.unitCode,
    this.unitText,
    this.serialRequired,
    this.monthsOfWarranty,
    this.minPrice,
    this.statusCode,
    this.statusText,
    this.categoryCode,
    this.categoryText,
    this.typeCode,
    this.typeText,
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
      serialRequired: json['serialRequired'],
      monthsOfWarranty: json['monthsOfWarranty'],
      minPrice: json['minPrice']?.toDouble(),
      statusCode: json['statusCode'],
      statusText: json['statusText'],
      categoryCode: json['categoryCode'],
      categoryText: json['categoryText'],
      typeCode: json['typeCode'],
      typeText: json['typeText'],
      children: (json['children'] as List<dynamic>?)
          ?.map((childJson) => ChildProductDetailModel.fromJson(childJson))
          .toList(),
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
      'serialRequired': serialRequired,
      'monthsOfWarranty': monthsOfWarranty,
      'statusCode': statusCode,
      'statusText': statusText,
      'categoryCode': categoryCode,
      'categoryText': categoryText,
      'typeCode': typeCode,
      'typeText': typeText,
      'minPrice': minPrice,
      'children': children?.map((x) => x.toMap()).toList(),
    };
  }

  Map<String, String> toJson() {
    return {
      'id': id ?? '',
      'code': code ?? '',
      'name': name ?? '',
      'description': description ?? '',
      'unitCode': unitCode ?? '',
      'unitText': unitText ?? '',
      'statusCode': statusCode ?? '',
      'statusText': statusText ?? '',
      'categoryCode': categoryCode ?? '',
      'categoryText': categoryText ?? '',
      'typeCode': typeCode ?? '',
      'typeText': typeText ?? '',
      'serialRequired': serialRequired?.toString() ?? '',
      'monthsOfWarranty': monthsOfWarranty?.toString() ?? '',
      'minPrice': minPrice?.toString() ?? '',
      'children': children != null
          ? children!.map((e) => e.toMap()).toList().toString()
          : '',
    };
  }

  ProductDetailModel copyWith({
    String? id,
    String? code,
    String? name,
    String? description,
    String? unitCode,
    String? unitText,
    String? statusCode,
    String? statusText,
    String? categoryCode,
    String? categoryText,
    String? typeCode,
    String? typeText,
    bool? serialRequired,
    int? monthsOfWarranty,
    double? minPrice,
    List<ChildProductDetailModel>? children,
  }) {
    return ProductDetailModel(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      description: description ?? this.description,
      unitCode: unitCode ?? this.unitCode,
      unitText: unitText ?? this.unitText,
      statusCode: statusCode ?? this.statusCode,
      statusText: statusText ?? this.statusText,
      categoryCode: categoryCode ?? this.categoryCode,
      categoryText: categoryText ?? this.categoryText,
      typeCode: typeCode ?? this.typeCode,
      typeText: typeText ?? this.typeText,
      serialRequired: serialRequired ?? this.serialRequired,
      monthsOfWarranty: monthsOfWarranty ?? this.monthsOfWarranty,
      minPrice: minPrice ?? this.minPrice,
      children: children ?? this.children,
    );
  }
}

class ChildProductDetailModel {
  String? childId;
  double? quantityOfChild;
  String? unitCode;
  String? note;

  ChildProductDetailModel({
    this.childId,
    this.quantityOfChild = 0,
    this.unitCode,
    this.note,
  });

  factory ChildProductDetailModel.fromJson(Map<String, dynamic> json) {
    return ChildProductDetailModel(
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
