class ProductUpdateModel {
  String? id;
  String? code;
  String? name;
  String? description;
  String? unitCode;
  String? statusCode;
  String? categoryCode;
  String? typeCode;
  bool? serialRequired;
  int? monthsOfWarranty;
  double? minPrice;
  List<ChildProductUpdateModel>? children;

  ProductUpdateModel({
    this.id,
    this.code,
    this.name,
    this.description,
    this.unitCode,
    this.serialRequired,
    this.monthsOfWarranty,
    this.minPrice,
    this.statusCode,
    this.categoryCode,
    this.typeCode,
    this.children,
  });

  factory ProductUpdateModel.fromJson(Map<String, dynamic> json) {
    return ProductUpdateModel(
      id: json['id'],
      code: json['code'],
      name: json['name'],
      description: json['description'],
      unitCode: json['unitCode'],
      serialRequired: json['serialRequired'],
      monthsOfWarranty: json['monthsOfWarranty'],
      minPrice: json['minPrice']?.toDouble(),
      statusCode: json['statusCode'],
      categoryCode: json['categoryCode'],
      typeCode: json['typeCode'],
      children: (json['children'] as List<dynamic>?)
          ?.map((childJson) => ChildProductUpdateModel.fromJson(childJson))
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
      'serialRequired': serialRequired,
      'monthsOfWarranty': monthsOfWarranty,
      'statusCode': statusCode,
      'categoryCode': categoryCode,
      'typeCode': typeCode,
      'minPrice': minPrice,
      'children': children?.map((x) => x.toMap()).toList(),
    };
  }

  // Map<String, String> toJson() {
  //   return {
  //     'id': id ?? '',
  //     'code': code ?? '',
  //     'name': name ?? '',
  //     'description': description ?? '',
  //     'unitCode': unitCode ?? '',
  //     'statusCode': statusCode ?? '',
  //     'categoryCode': categoryCode ?? '',
  //     'typeCode': typeCode ?? '',
  //     'serialRequired': serialRequired?.toString() ?? '',
  //     'monthsOfWarranty': monthsOfWarranty?.toString() ?? '',
  //     'minPrice': minPrice?.toString() ?? '',
  //     'children': children != null
  //         ? children!.map((e) => e.toMap()).toList().toString()
  //         : '',
  //   };
  // }

  ProductUpdateModel copyWith({
    String? id,
    String? code,
    String? name,
    String? description,
    String? unitCode,
    String? statusCode,
    String? categoryCode,
    String? typeCode,
    bool? serialRequired,
    int? monthsOfWarranty,
    double? minPrice,
    List<ChildProductUpdateModel>? children,
  }) {
    return ProductUpdateModel(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      description: description ?? this.description,
      unitCode: unitCode ?? this.unitCode,
      statusCode: statusCode ?? this.statusCode,
      categoryCode: categoryCode ?? this.categoryCode,
      typeCode: typeCode ?? this.typeCode,
      serialRequired: serialRequired ?? this.serialRequired,
      monthsOfWarranty: monthsOfWarranty ?? this.monthsOfWarranty,
      minPrice: minPrice ?? this.minPrice,
      children: children ?? this.children,
    );
  }
}

class ChildProductUpdateModel {
  String? childId;
  double? quantityOfChild;
  String? unitCode;
  String? note;

  ChildProductUpdateModel({
    this.childId,
    this.quantityOfChild = 0,
    this.unitCode,
    this.note,
  });

  factory ChildProductUpdateModel.fromJson(Map<String, dynamic> json) {
    return ChildProductUpdateModel(
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
